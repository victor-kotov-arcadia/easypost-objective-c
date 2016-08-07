
Pod::Spec.new do |s|

  s.name         = "EasyPost"
  s.version      = "0.0.3"
  s.summary      = "https://easypost.com shipping API"

  s.description  = <<-DESC
  EasyPost is a shipping API for https://easypost.com. You can sign up for an account at https://easypost.com
                   DESC

  s.homepage     = "https://easypost.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Sinisa Drpa" => "sdrpa@tagtaxa.com" }
  s.social_media_url   = "http://twitter.com/Sinisa Drpa"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"

  s.source       = { :git => "https://github.com/rodionovd/easypost-objective-c.git"}
  s.source_files  = "EasyPost", "EasyPost/**/*.{h,m}"
  s.private_header_files = ["EasyPost/AFHTTPRequestOperationManager+Synchronous.h", "EasyPost/EZPClient+Private.h", "EasyPost/EZPClient+Synchronous.h"]

  s.dependency "AFNetworking", '~>2.6.3'

end
