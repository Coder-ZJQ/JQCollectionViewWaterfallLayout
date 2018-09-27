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

Same usage as UICollectionViewFlowLayout. But you should pay attention to the  **UICollectionViewDelegateFlowLayout** protocol method `collectionView:layout:sizeForItemAtIndexPath: `.

``` objective-c

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // When scroll direction is UICollectionViewScrollDirectionVertical, the item width is fixed, the item height is flexible. And you can change the col count by measure the item width.
    
    // When scroll direction is UICollectionViewScrollDirectionHorizontal, the item height is fixed, the item width is flexible. And you can change the row count by measure the item height.

}
```

(see more detail in [**Example Project**](https://github.com/Coder-ZJQ/JQCollectionViewWaterfallLayout/blob/7152814d902b63099e878fbb5d92d986ca8496fa/Example/JQCollectionViewWaterfallLayout/JQViewController.m#L97))

## Author

coder-zjq, zjq_joker@163.com

## License

JQCollectionViewWaterfallLayout is available under the MIT license. See the LICENSE file for more info.
