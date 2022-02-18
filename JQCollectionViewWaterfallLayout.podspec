#
# Be sure to run `pod lib lint JQCollectionViewWaterfallLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JQCollectionViewWaterfallLayout'
  s.version          = '0.2.0'
  s.summary          = 'UICollectionView waterfall layout.'

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
  s.ios.deployment_target = '6.0'
  s.source_files = 'JQCollectionViewWaterfallLayout/Classes/**/*'
  
end
