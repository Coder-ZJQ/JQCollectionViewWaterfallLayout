#
# Be sure to run `pod lib lint JQCollectionViewWaterfallLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JQCollectionViewWaterfallLayout'
  s.version          = '0.1.1'
  s.summary          = 'UICollectionView waterfall layout.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  UICollectionView waterfall layout:
  1. support vertical and horizontal scroll direction;
  2. support different row/col count with different section;
  3. support section headerView and footerView;
  4. support UICollectionView updates.
                       DESC

  s.homepage         = 'https://github.com/coder-zjq/JQCollectionViewWaterfallLayout'
  s.screenshots      = 'https://github.com/Coder-ZJQ/JQCollectionViewWaterfallLayout/blob/master/Image/demo_vertical.gif?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'coder-zjq' => 'zjq_joker@163.com' }
  s.source           = { :git => 'https://github.com/coder-zjq/JQCollectionViewWaterfallLayout.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '6.0'

  s.source_files = 'JQCollectionViewWaterfallLayout/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JQCollectionViewWaterfallLayout' => ['JQCollectionViewWaterfallLayout/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
