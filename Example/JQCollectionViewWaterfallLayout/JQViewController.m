//
//  JQViewController.m
//  JQCollectionViewWaterfallLayout
//
//  Created by coder-zjq on 08/15/2018.
//  Copyright (c) 2018 coder-zjq. All rights reserved.
//

#import "JQViewController.h"
#import "JQCollectionViewWaterfallLayout.h"

NSMutableArray *randomValues() {
    NSMutableArray *heights = [[NSMutableArray alloc] init];
    NSInteger count = 30 + arc4random() % 10;
    for (int j = 0; j < count; j++)
    {
        [heights addObject:@(100 + arc4random() % 100)];
    }
    return heights;
}
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
    self.collectionView.contentInset = UIEdgeInsetsMake(30, 30, 30, 30);
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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
        NSMutableArray *data = [[NSMutableArray alloc] init];
        if (self.direction == UICollectionViewScrollDirectionVertical) {
            CGFloat width = [UIScreen mainScreen].bounds.size.width - self.collectionView.contentInset.left - self.collectionView.contentInset.right;
            for (int i = 5; i > 1; i --) {
                [data addObject:@{@"width": @((width - 1.f - kPadding * (i + 1)) / i),@"heights": randomValues()}];
            }
        } else {
            CGFloat height = [UIScreen mainScreen].bounds.size.height - 44.f - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom;
            for (int i = 6; i > 2; i --) {
                [data addObject:@{@"widths": randomValues(),@"height": @((height - 1.f - kPadding * (i + 1)) / i)}];
            }
        }
        _data = data;
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
    if (self.direction == UICollectionViewScrollDirectionVertical) {
        CGFloat width = [self.data[indexPath.section][@"width"] floatValue];
        NSArray *heights = self.data[indexPath.section][@"heights"];
        CGFloat height = [heights[indexPath.item] floatValue];
        return CGSizeMake(width, height);
    } else {
        CGFloat height = [self.data[indexPath.section][@"height"] floatValue];
        NSArray *widths = self.data[indexPath.section][@"widths"];
        CGFloat width = [widths[indexPath.item] floatValue];
        return CGSizeMake(width, height);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *values = self.direction == UICollectionViewScrollDirectionVertical ? self.data[section][@"heights"] : self.data[section][@"widths"];
    return values.count;
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
    NSMutableArray *values = self.direction == UICollectionViewScrollDirectionVertical ? self.data[indexPath.section][@"heights"] : self.data[indexPath.section][@"widths"];
    if (values.count == 1) {
        [self.data removeObjectAtIndex:indexPath.section];
        [collectionView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    } else {
        [values removeObjectAtIndex:indexPath.item];
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
