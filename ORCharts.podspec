#
#  Be sure to run `pod spec lint ORCharts.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "ORCharts"
  s.version      = "1.0.0"
  s.ios.deployment_target = '9.0'
  s.summary      = "A iOS Kit which would adapt screen by XIB and Storyboard  better， and  use better  for XIB  and Storyboard。"
  #s.description  = <<-DESC
  #                 DESC

  s.homepage     = "https://github.com/SunriseOYR/ORCharts"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = "Oranges and lemons"
  s.social_media_url   = "https://www.jianshu.com/p/317a79890984"
  s.source       = { :git => "https://github.com/SunriseOYR/ORCharts.git", :tag => "v#{s.version}" }
  s.source_files  = "ORCharts","ORCharts/**/*"
  s.public_header_files = 'ORCharts/ORCharts.h'
  s.requires_arc = true

  s.subspec 'Util' do |su|
    su.ios.deployment_target = '9.0'
    su.source_files = "ORCharts/ORChartUtilities/**/*.{h,m}"
    su.requires_arc = true
  end
 s.subspec 'Ring' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files = "ORCharts/ORRingChart/**/*.{h,m}"
    ss.public_header_files = 'ORCharts/ORRingChart/ORRingChartView.h'
    ss.dependency "ORCharts/Util"
    ss.requires_arc = true
  end
 s.subspec 'Line' do |sss|
    sss.ios.deployment_target = '9.0'
    sss.source_files = "ORCharts/ORLineChart/**/*.{h,m}"
    sss.public_header_files = 'ORCharts/ORLineChart/ORLineChartView.h'
    sss.dependency "ORCharts/Util"
    sss.requires_arc = true

  end

end
