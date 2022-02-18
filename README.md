# JQCollectionViewWaterfallLayout

[![Version](https://img.shields.io/cocoapods/v/JQCollectionViewWaterfallLayout.svg?style=flat)](https://cocoapods.org/pods/JQCollectionViewWaterfallLayout)
[![License](https://img.shields.io/cocoapods/l/JQCollectionViewWaterfallLayout.svg?style=flat)](https://cocoapods.org/pods/JQCollectionViewWaterfallLayout)
[![Platform](https://img.shields.io/cocoapods/p/JQCollectionViewWaterfallLayout.svg?style=flat)](https://cocoapods.org/pods/JQCollectionViewWaterfallLayout)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

|               **Direction**               |                          **Image**                           |
| :---------------------------------------: | :----------------------------------------------------------: |
|  UICollectionViewScrollDirectionVertical  | ![](https://github.com/Coder-ZJQ/JQCollectionViewWaterfallLayout/blob/master/Image/demo_vertical.gif?raw=true) |
| UICollectionViewScrollDirectionHorizontal | ![](https://github.com/Coder-ZJQ/JQCollectionViewWaterfallLayout/blob/master/Image/demo_horizontal.gif?raw=true) |

## Feature

- [x] vertical and horizontal scroll direction;
- [x] different row/col count with different section;
- [x] section headerView and footerView;
- [x] contentInset of collectionView;
- [x] inset for section;
- [x] updates of UICollectionView cells;
- [x] same usage as UICollectionViewFlowLayout.


## Requirements

iOS 6.0+

## Installation

JQCollectionViewWaterfallLayout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JQCollectionViewWaterfallLayout'
```

## Usage

- property
``` objective-c
layout.numberOfColumns = 3;
```

- or delegate
``` objective-c
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfColumnsInSection:(NSInteger)section {
    return [self.data[section][@"column"] integerValue];
}
```

(see more detail in [**Example Project**](https://github.com/Coder-ZJQ/JQCollectionViewWaterfallLayout/blob/master/Example/JQCollectionViewWaterfallLayout/JQViewController.m#L115-L122))

## Author

coder-zjq, zjq_joker@163.com

## License

JQCollectionViewWaterfallLayout is available under the MIT license. See the LICENSE file for more info.
