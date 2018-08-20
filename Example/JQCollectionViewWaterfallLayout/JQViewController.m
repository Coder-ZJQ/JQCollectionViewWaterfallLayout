//
//  JQViewController.m
//  JQCollectionViewWaterfallLayout
//
//  Created by coder-zjq on 08/15/2018.
//  Copyright (c) 2018 coder-zjq. All rights reserved.
//

#import "JQViewController.h"
#import "JQCollectionViewWaterfallLayout.h"
#import "JQCollectionViewImageCell.h"

static CGFloat const kPadding = 5.f;
#define kHeaderFooterSize CGSizeMake(50.f, 50.f)

@interface JQViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

/// collection view
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
/// collection view data
@property (nonatomic, strong) NSMutableArray *data;
/// collection view scroll direction
@property (nonatomic) UICollectionViewScrollDirection direction;

@end

@implementation JQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JQCollectionViewImageCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.direction = UICollectionViewScrollDirectionVertical;
}

#pragma mark -
#pragma mark - action

- (IBAction)changeScrollDirection:(id)sender {
    self.direction = self.direction == UICollectionViewScrollDirectionVertical ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
}

#pragma mark -
#pragma mark - getter & setter

- (void)setDirection:(UICollectionViewScrollDirection)direction {
    _direction = direction;
    JQCollectionViewWaterfallLayout *layout = (JQCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.scrollDirection = direction;
    _data = nil;
    [self.collectionView reloadData];
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        for (int i = 0; i < 31; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"image_%d.jpg", i];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image) [arr1 addObject:image];
        }
        NSMutableArray *arr2 = [[NSMutableArray alloc] init];
        for (int i = 31; i < 61; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"image_%d.jpg", i];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image) [arr2 addObject:image];
        }
        NSMutableArray *arr3 = [[NSMutableArray alloc] init];
        for (int i = 61; i < 92; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"image_%d.jpg", i];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image) [arr3 addObject:image];
        }
        [_data addObject:arr1];
        [_data addObject:arr2];
        [_data addObject:arr3];
    }
    return _data;
}

#pragma mark -
#pragma mark - JQCollectionViewDelegateWaterfallLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets insets = [self collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:indexPath.section];
    CGFloat minimumInteritemSpacing = [self collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    UIImage *image = self.data[indexPath.section][indexPath.item];
    if (self.direction == UICollectionViewScrollDirectionVertical) {
        CGFloat width =(CGRectGetWidth(collectionView.frame) - insets.left - insets.right - collectionView.contentInset.left - collectionView.contentInset.right + minimumInteritemSpacing) / (CGFloat)(2 + indexPath.section) - minimumInteritemSpacing;
        return CGSizeMake(width, image.size.height / image.size.width * width);
    } else {
        CGFloat height =(CGRectGetHeight(collectionView.frame) - insets.top - insets.bottom - collectionView.contentInset.top - collectionView.contentInset.bottom + minimumInteritemSpacing) / (CGFloat)(self.data.count + 1 - indexPath.section) - minimumInteritemSpacing;
        return CGSizeMake(image.size.width / image.size.height * height, height);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JQCollectionViewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.image = self.data[indexPath.section][indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *images = self.data[section];
    return images.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor greenColor];
        return header;
    } else {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor blueColor];
        return footer;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // test update
    NSMutableArray *images = self.data[indexPath.section];
    if (images.count == 1) {
        [self.data removeObjectAtIndex:indexPath.section];
        [collectionView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    } else {
        [images removeObjectAtIndex:indexPath.item];
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return kHeaderFooterSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return kHeaderFooterSize;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kPadding;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kPadding;
}

@end
