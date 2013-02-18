#RMPhoneFormat

RMPhoneFormat provides a simple to use class for formatting and validating phone numbers in iOS apps. The formatting should replicate what you would see in the Contacts app for the same phone number.

The included sample project demonstrates how to use the formatting class to setup a text field that formats itself as the user types in a phone number. While the sample app is for iOS, the RMPhoneFormat class should work as-is under OS X.

##Setup

This class depends on a copy of an Apple provided private framework file named Default.phoneformat being copied into the app's resource bundle and named PhoneFormats.dat.

The Default.phoneformat file can be located in:

    /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator<version>.sdk/System/Library/PrivateFrameworks/AppSupport.framework

where \<version\> is the version of the iPhone SDK installed. It is recommended that you use the one from 6.0.

Add RMPhoneFormat.m and RMPhoneFormat.h to your own project. These files use ARC. If your project is not using ARC then you must add the -fobjc-arc flag to the RMPhoneFormat.m file. Select your target in Xcode. Select the Build Phases tab. Open the Compile Sources pane. Select RMPhoneFormat.m and press Enter. Add -fobjc-arc in the popup window so it appears in the Compiler Flags column.

##Usage

In its simplest form you do the following:

    RMPhoneFormat *fmt = [[RMPhoneFormat alloc] init];
    // Call any number of times
    NSString *numberString = // the phone number to format
    NSString *formattedNumber = [fmt format:numberString];

You can also pass in a specific default country code if you don't want to rely on the Region Format setting. Pass in a valid ISO 3166-1 two-letter country code in lowercase:

    RMPhoneFormat *fmt = [[RMPhoneFormat alloc] initWithDefaultCountry:@"uk"];
    // Call any number of times
    NSString *numberString = // the phone number to format
    NSString *formattedNumber = [fmt format:numberString];

You may also use the singleton interface if desired:

    RMPhoneFormat *fmt = [RMPhoneFormat instance];
    // Call any number of times
    NSString *numberString = // the phone number to format
    NSString *formattedNumber = [fmt format:numberString];

To validate a phone number you can do the following:

    RMPhoneFormat *fmt = [[RMPhoneFormat alloc] init];
    // Call any number of times
    NSString *numberString = // the phone number to validate
    BOOL valid = [fmt isPhoneNumberValid:fmt];
    
The phone number to validate can include formatting characters or not. The number will be valid if there are an appropriate set of digits.

RMPhoneFormat can also be used to lookup a country's calling code:

    RMPhoneFormat *fmt = [RMPhoneFormat instance];
    NSString *callingCode = [fmt callingCodeForCountryCode:@"AU"]; // Australia - returns 61
    NSString *defaultCallingCode = [fmt defaultCallingCode]; // based on current Region Format (locale)

##Notes

See the comments in RMPhoneFormat.m for additional details.

Please note that the format of the Default.phoneformat file is undocumented. There are aspects to this file that are not yet understood. This means that some phone numbers in some countries may not be formatted correctly.

##Issues

If you encounter an issue where a phone number is formatted differently with RMPhoneFormat than the Contacts app, please let me know. Be sure to provide the phone number, the output from RMPhoneFormat, the output shown in Contacts, and the Region Format setting from the Settings app.

##License
    Copyright (c) 2012, Rick Maddy
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this
      list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
    OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
