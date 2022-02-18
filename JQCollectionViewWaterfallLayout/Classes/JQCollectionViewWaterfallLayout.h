//
//  JQCollectionViewWaterfallLayout.h
//  JQCollectionViewWaterfallLayout
//
//  Created by coder-zjq on 2018/8/13.
//  Copyright © 2018年 coder-zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * _Nonnull const JQCollectionElementKindCell NS_AVAILABLE_IOS(6_0);


@protocol JQCollectionViewWaterfallLayoutDelegate <UICollectionViewDelegateFlowLayout>

/// number of colums in section
/// @param collectionView UICollectionView
/// @param section UICollectionView section
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfColumnsInSection:(NSInteger)section;

@end

@interface JQCollectionViewWaterfallLayout : UICollectionViewFlowLayout

/// number of columns for all sections(default: 2)
@property (nonatomic) NSInteger numberOfColumns;

@end
