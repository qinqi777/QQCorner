#
# Be sure to run `pod lib lint QQCorner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QQCorner'
  s.version          = '1.1.1'
  s.summary          = 'Some categories that add corner to UIView/CALayer or UIImage.'

  s.description      = 'Some categories that add corner to UIView/CALayer or UIImage, that you can easily add different corners.'

  s.homepage         = 'https://github.com/qinqi777/QQCorner'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'QinQi' => 'qinqi376990311@163.com' }
  s.source           = { :git => 'https://github.com/qinqi777/QQCorner.git', :tag => s.version.to_s }
  s.social_media_url = 'https://blog.csdn.net/qinqi376990311'
  s.ios.deployment_target = '8.0'
  s.source_files = 'QQCorner/Classes/**/*.{h,m}'
  s.requires_arc = true
  s.frameworks = 'CoreGraphics', 'QuartzCore', 'UIKit'  
  
end
