#
# Be sure to run `pod lib lint MTMediaSource.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MTMediaSource'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MTMediaSource.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "MT Tech Media Source Handlers"

  s.homepage         = 'https://github.com/hippiefox/MTMediaSource'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hippie Fox' => 'foxhippie5@gmail.com' }
  s.source           = { :git => 'https://github.com/hippiefox/MTMediaSource.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'MTMediaSource/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MTMediaSource' => ['MTMediaSource/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit'
  s.dependency 'Kingfisher'
end
