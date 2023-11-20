Pod::Spec.new do |spec|

spec.name         = "EYCalendar"
spec.version      = "1.0.0"
spec.summary      = "EYCalendar is a versatile and customizable calendar component designed for developers seeking a feature-rich solution for their applications."

spec.description  = <<-DESC
EYCalendar is a versatile and customizable calendar component designed for developers seeking a feature-rich solution for their applications. This open-source project, hosted on GitHub, provides two distinct calendar types - the standard Gregorian calendar and the Islamic calendar. Users can effortlessly switch between these calendars using a simple toggle switch..
DESC

spec.homepage     = "https://github.com/ehabyasser/EYCalendar"

spec.license      = { :type => "MIT", :file => "LICENSE" }

spec.author             = "ehabyasser"
spec.social_media_url   = "https://x.com/ehab12165518?s=11"

spec.swift_version = '5.0'
spec.platform     = :ios, "13.0"

spec.source       = { :git => "https://github.com/ehabyasser/EYCalendar.git", :tag => "#{spec.version}" }

spec.source_files  = "Sources/**/*.swift"

spec.dependency 'SnapKit', '~> 5.6.0'

spec.module_name = 'EYCalendar'

spec.ios.deployment_target = '13.0'

end
