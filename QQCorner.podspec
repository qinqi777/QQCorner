#
# Be sure to run `pod lib lint QQCorner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QQCorner'
  s.version          = '0.1.0'
  s.summary          = 'Some categories that clip corner to UIView or UIImage.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Some categories that clip corner to UIView or UIImage, that you can easily add different corners.'

  s.homepage         = 'https://github.com/qinqi777/QQCorner'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'QinQi' => 'qinqi376990311@163.com' }
  s.source           = { :git => 'https://github.com/qinqi777/QQCorner.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'QQCorner/Classes/**/*.{h,m}'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.requires_arc = true
  s.frameworks = 'CoreGraphics', 'QuartzCore', 'UIKit'  
  
end
