Pod::Spec.new do |s|
  s.name         = "RMPhoneFormat"
  s.version      = "0.0.1"
  s.summary      = "RMPhoneFormat provides a simple to use class for formatting and validating phone numbers in iOS apps."
  s.description  = <<-DESC
                    RMPhoneFormat provides a simple to use class for formatting and validating phone numbers in iOS apps. The formatting should replicate what you would see in the Contacts app for the same phone number.

The included sample project demonstrates how to use the formatting class to setup a text field that formats itself as the user types in a phone number. While the sample app is for iOS, the RMPhoneFormat class should work as-is under OS X.
                   DESC
  s.homepage     = "https://github.com/rmaddy/RMPhoneFormat.git"

  s.license      = {
    :type => :BSD,
    :text => <<-LICENSE
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
    LICENSE
  }

  s.author       = { "Rick Maddy" => "rmaddy@maddyhome.com" }
  s.source       = { :git => "https://github.com/rmaddy/RMPhoneFormat.git", :commit => '23236e0925aa215bd83b794f7660ad7d4d79ecc6' } # This needs to be updated with commit that includes the .dat file
  s.platform     = :ios
  s.source_files = 'RMPhoneFormat/RMPhoneFormat.{h,m}'
  s.resource  = "RMPhoneFormat/PhoneFormats.dat"
  s.requires_arc = true
end
