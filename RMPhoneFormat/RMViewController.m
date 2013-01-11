// Copyright (c) 2012, Rick Maddy
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
// OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "RMViewController.h"
#import "RMPhoneFormat.h"
#import <QuartzCore/QuartzCore.h>

@interface RMViewController () <UITextFieldDelegate>

@end

@implementation RMViewController {
    RMPhoneFormat *_phoneFormat;
    NSMutableCharacterSet *_phoneChars;
    UITextField *_textField;
}

- (id)init {
    if ((self = [super init])) {
        [self setupFormatter];
        _phoneChars = [[NSCharacterSet decimalDigitCharacterSet] mutableCopy];
        [_phoneChars addCharactersInString:@"+*#,"];
        
        // Listen for changes locale (if the user changes the Region Format settings)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeChanged) name:NSCurrentLocaleDidChangeNotification object:nil];
    }
    
    return self;
}

- (void)setupFormatter {
    _phoneFormat = [[RMPhoneFormat alloc] init];
}

- (void)localeChanged {
    [self setupFormatter];
    
    // Reformat the current phone number
    if (_textField) {
        NSString *text = _textField.text;
        NSString *phone = [_phoneFormat format:text];
        _textField.text = phone;
    }
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // For some reason, the 'range' parameter isn't always correct when backspacing through a phone number
    // This calculates the proper range from the text field's selection range.
    UITextRange *selRange = textField.selectedTextRange;
    UITextPosition *selStartPos = selRange.start;
    UITextPosition *selEndPos = selRange.end;
    NSInteger start = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selStartPos];
    NSInteger end = [textField offsetFromPosition:textField.beginningOfDocument toPosition:selEndPos];
    NSRange repRange;
    if (start == end) {
        if (string.length == 0) {
            repRange = NSMakeRange(start - 1, 1);
        } else {
            repRange = NSMakeRange(start, end - start);
        }
    } else {
        repRange = NSMakeRange(start, end - start);
    }
    
    // This is what the new text will be after adding/deleting 'string'
    NSString *txt = [textField.text stringByReplacingCharactersInRange:repRange withString:string];
    // This is the newly formatted version of the phone number
    NSString *phone = [_phoneFormat format:txt];
    BOOL valid = [_phoneFormat isPhoneNumberValid:phone];
    
    textField.textColor = valid ? [UIColor blackColor] : [UIColor redColor];
    
    // If these are the same then just let the normal text changing take place
    if ([phone isEqualToString:txt]) {
        return YES;
    } else {
        // The two are different which means the adding/removal of a character had a bigger effect
        // from adding/removing phone number formatting based on the new number of characters in the text field
        // The trick now is to ensure the cursor stays after the same character despite the change in formatting.
        // So first let's count the number of non-formatting characters up to the cursor in the unchanged text.
        int cnt = 0;
        for (NSUInteger i = 0; i < repRange.location + string.length; i++) {
            if ([_phoneChars characterIsMember:[txt characterAtIndex:i]]) {
                cnt++;
            }
        }
        
        // Now let's find the position, in the newly formatted string, of the same number of non-formatting characters.
        int pos = [phone length];
        int cnt2 = 0;
        for (NSUInteger i = 0; i < [phone length]; i++) {
            if ([_phoneChars characterIsMember:[phone characterAtIndex:i]]) {
                cnt2++;
            }
            
            if (cnt2 == cnt) {
                pos = i + 1;
                break;
            }
        }
        
        // Replace the text with the updated formatting
        textField.text = phone;
        
        // Make sure the caret is in the right place
        UITextPosition *startPos = [textField positionFromPosition:textField.beginningOfDocument offset:pos];
        UITextRange *textRange = [textField textRangeFromPosition:startPos toPosition:startPos];
        textField.selectedTextRange = textRange;
        
        return NO;
    }
}

#pragma mark UIViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(20, 40, self.view.frame.size.width - 40, 44)];
    bg.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    bg.backgroundColor = [UIColor whiteColor];
    bg.layer.cornerRadius = 10;

    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, bg.frame.size.width - 20, 24)];
    tf.keyboardType = UIKeyboardTypePhonePad;
    tf.backgroundColor = [UIColor whiteColor];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    tf.placeholder = @"phone number";
    tf.delegate = self;
    
    [bg addSubview:tf];

    [self.view addSubview:bg];
    
    _textField = tf;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_textField becomeFirstResponder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSCurrentLocaleDidChangeNotification object:nil];
}

@end
