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

#define kPadding 5.f
#define kHeaderFooterSize CGSizeMake(50.f, 50.f)
#define kSectionInset UIEdgeInsetsMake(10, 10, 10, 10)
#define kContentInset UIEdgeInsetsMake(30, 30, 30, 30)

@interface JQViewController () <JQCollectionViewWaterfallLayoutDelegate, UICollectionViewDataSource>

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
    self.collectionView.contentInset = kContentInset;
    [self.collectionView registerNib:[UINib nibWithNibName:@"JQCollectionViewImageCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.direction = UICollectionViewScrollDirectionVertical;
}

- (void)reloadCollectionView {
    JQCollectionViewWaterfallLayout *layout = (JQCollectionViewWaterfallLayout *) self.collectionView.collectionViewLayout;
    layout.scrollDirection = self.direction;
    _data = nil;
    [self.collectionView reloadData];
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
    // reload collection view when scroll ended
    [self performSelector:@selector(reloadCollectionView) withObject:nil afterDelay:0.f inModes:@[ NSDefaultRunLoopMode ]];
}

- (NSMutableArray *)data {
    if (!_data) {
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        for (int i = 0; i < 31; i++) {
            NSString *imageName = [NSString stringWithFormat:@"image_%d.jpg", i];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image)
                [arr1 addObject:image];
        }
        NSMutableArray *arr2 = [[NSMutableArray alloc] init];
        for (int i = 31; i < 61; i++) {
            NSString *imageName = [NSString stringWithFormat:@"image_%d.jpg", i];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image)
                [arr2 addObject:image];
        }
        NSMutableArray *arr3 = [[NSMutableArray alloc] init];
        for (int i = 61; i < 92; i++) {
            NSString *imageName = [NSString stringWithFormat:@"image_%d.jpg", i];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image)
                [arr3 addObject:image];
        }
        _data = @[
            @{
                @"column" : @3,
                @"images" : arr1
            },
            @{
                @"column" : @2,
                @"images" : arr2
            },
            @{
                @"column" : @4,
                @"images" : arr3
            }
        ].mutableCopy;
    }
    return _data;
}

#pragma mark -
#pragma mark - JQCollectionViewWaterfallLayoutDelegate

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return kSectionInset;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfColumnsInSection:(NSInteger)section {
    return [self.data[section][@"column"] integerValue];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = self.data[indexPath.section][@"images"][indexPath.item];
    return image.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JQCollectionViewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.image = self.data[indexPath.section][@"images"][indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *images = self.data[section][@"images"];
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
    NSMutableArray *images = self.data[indexPath.section][@"images"];
    if (images.count == 1) {
        [self.data removeObjectAtIndex:indexPath.section];
        [collectionView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    } else {
        [images removeObjectAtIndex:indexPath.item];
        [collectionView deleteItemsAtIndexPaths:@[ indexPath ]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return kHeaderFooterSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return kHeaderFooterSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kPadding;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kPadding;
}

@end
