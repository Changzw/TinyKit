#
# Be sure to run `pod lib lint TinyKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TinyKit'
  s.version          = '0.1.1'
  s.summary          = 'A short description of TinyKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here. 日常工作便捷工具
                       DESC

  s.homepage         = 'https://github.com/Changzw/TinyKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Changzw' => 'changzhongwei3@gmail.com' }
  s.source           = { :git => 'https://github.com/Changzw/TinyKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.5'
  
  # s.resource_bundles = {
  #   'TinyKit' => ['TinyKit/Assets/*.png']
  # }

  s.subspec 'Store' do |ss|
    ss.source_files = 'TinyKit/Classes/Store/*'
  end

  s.subspec 'Extensions' do |ss|
    ss.source_files = 'TinyKit/Classes/Extensions/*'
  end

  s.subspec 'StateMachine' do |ss|
    ss.source_files = 'TinyKit/Classes/StateMachine/*'
  end
   
  s.subspec 'Wrapper' do |ss|
    ss.source_files = 'TinyKit/Classes/Wrapper/*'
  end

  s.subspec 'nonname' do |ss|
    ss.source_files = 'TinyKit/Classes/*.swift'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.subspec 'dependency' do |d|
    d.dependency 'Action',           '4.2.0'
    d.dependency 'RxCocoa',          '5.1.1'
    d.dependency 'RxSwiftExt',       '5.2.0'
    d.dependency 'RxGesture',        '3.0.2'
    d.dependency 'RxAnimated',       '0.7.0'
    d.dependency 'NSObject+Rx',      '5.1.0'
    d.dependency 'Moya/RxSwift',     '14.0.0'
    d.dependency 'Nuke',             '9.5.0'
    d.dependency 'Hue',              '5.0.0'
    d.dependency 'SnapKit',          '5.0.1'
    d.dependency 'MagazineLayout',   '1.6.3'
    d.dependency 'DifferenceKit',    '1.1.5'
    d.dependency 'MJRefresh',        '3.5.0'
    d.dependency 'FSPagerView',      '0.8.3'
    d.dependency 'KeychainAccess',   '4.2.2'
    d.dependency 'PagingKit',        '1.18.0'
    d.dependency 'SwiftRichString',  '3.7.2'
    d.dependency 'LookinServer',     :configurations => ['Debug']
    d.dependency 'MMKV',             '1.2.7'
    d.dependency 'SwiftTweaks',      '4.1.2'
  end
end
