//
//  JQCollectionViewWaterfallLayout.m
//  JQCollectionViewWaterfallLayout
//
//  Created by coder-zjq on 2018/8/13.
//  Copyright © 2018年 coder-zjq. All rights reserved.
//

#import "JQCollectionViewWaterfallLayout.h"

@interface JQCollectionViewWaterfallLayout ()

@property (nonatomic, strong) NSMutableDictionary *layoutAttributes;

@end

CGPoint CGPointBiggestYPoint(int count, CGPoint points[])
{
    CGPoint biggest = CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN);
    for (int i = 0; i < count; i++)
    {
        CGPoint point = points[i];
        if (point.y > biggest.y)
        {
            biggest = point;
        }
    }
    return biggest;
}

CGPoint CGPointBiggestXPoint(int count, CGPoint points[])
{
    CGPoint biggest = CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN);
    for (int i = 0; i < count; i++)
    {
        CGPoint point = points[i];
        if (point.x > biggest.x)
        {
            biggest = point;
        }
    }
    return biggest;
}

CGPoint CGPointSmallestYPoint(int count, CGPoint points[])
{
    CGPoint smallest = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
    for (int i = 0; i < count; i++)
    {
        CGPoint point = points[i];
        if (point.y < smallest.y)
        {
            smallest = point;
        }
    }
    return smallest;
}

CGPoint CGPointSmallestXPoint(int count, CGPoint points[])
{
    CGPoint smallest = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
    for (int i = 0; i < count; i++)
    {
        CGPoint point = points[i];
        if (point.x < smallest.x)
        {
            smallest = point;
        }
    }
    return smallest;
}

void CGPointReplaceSmallestYPoint(CGPoint point, CGPoint points[], int count)
{
    int index = 0;
    CGPoint smallest = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
    for (int i = 0; i < count; i++)
    {
        CGPoint point = points[i];
        if (point.y < smallest.y)
        {
            smallest = point;
            index = i;
        }
    }
    points[index] = point;
}

void CGPointReplaceSmallestXPoint(CGPoint point, CGPoint points[], int count)
{
    int index = 0;
    CGPoint smallest = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
    for (int i = 0; i < count; i++)
    {
        CGPoint point = points[i];
        if (point.x < smallest.x)
        {
            smallest = point;
            index = i;
        }
    }
    points[index] = point;
}

@implementation JQCollectionViewWaterfallLayout (attributes)

- (CGFloat)jq_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)])
    {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    }
    else
    {
        return self.minimumInteritemSpacing;
    }
}

- (CGFloat)jq_minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)])
    {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    }
    else
    {
        return self.minimumLineSpacing;
    }
}

- (UIEdgeInsets)jq_insetForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)])
    {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    else
    {
        return self.sectionInset;
    }
}

- (CGSize)jq_sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)])
    {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    else
    {
        return self.itemSize;
    }
}

- (BOOL)jq_hasHeaderInSection:(NSInteger)section
{
    CGSize size = [self jq_referenceSizeForHeaderInSection:section];
    return !CGSizeEqualToSize(size, CGSizeZero);
}

- (BOOL)jq_hasFooterInSection:(NSInteger)section
{
    CGSize size = [self jq_referenceSizeForFooterInSection:section];
    return !CGSizeEqualToSize(size, CGSizeZero);
}

- (CGSize)jq_referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)])
    {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
    }
    else
    {
        return self.headerReferenceSize;
    }
}

- (CGSize)jq_referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)])
    {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
    }
    else
    {
        return self.footerReferenceSize;
    }
}

@end

NSString *JQGenerateCacheKey(NSString *kind, NSIndexPath *indexPath)
{
    return [NSString stringWithFormat:@"<%@,%ld,%ld>", kind, (long) indexPath.section, (long) indexPath.item];
}
NSString *const JQCollectionElementKindCell = @"JQCollectionElementKindCell";
static NSString *const kContentHeightWidth = @"kContentHeightWidth";

@implementation JQCollectionViewWaterfallLayout (cache)

- (void)jq_cacheLayoutAttribute:(UICollectionViewLayoutAttributes *)attribute of:(NSString *)kind at:(NSIndexPath *)indexPath
{
    NSString *key = JQGenerateCacheKey(kind, indexPath);
    self.layoutAttributes[key] = attribute;
}

- (UICollectionViewLayoutAttributes *)jq_cachedLayoutAttributeOf:(NSString *)kind at:(NSIndexPath *)indexPath
{
    NSString *key = JQGenerateCacheKey(kind, indexPath);
    return self.layoutAttributes[key];
}

@end

@implementation JQCollectionViewWaterfallLayout

#pragma mark -
#pragma mark - prepare

- (void)prepareLayout
{
    [self.layoutAttributes removeAllObjects];
    self.layoutAttributes = [[NSMutableDictionary alloc] init];
    NSInteger sections = [self.collectionView numberOfSections];
    BOOL isVertical = self.scrollDirection == UICollectionViewScrollDirectionVertical;
    CGFloat preMax = 0.f;
    for (NSInteger section = 0; section < sections; section++)
    {
        NSInteger items = [self.collectionView numberOfItemsInSection:section];

        //*********************** layout info ***********************//
        CGSize size = items > 0 ? [self jq_sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]] : CGSizeZero;
        CGFloat minimumInteritemSpacing = [self jq_minimumInteritemSpacingForSectionAtIndex:section];
        CGFloat minimumLineSpacing = [self jq_minimumLineSpacingForSectionAtIndex:section];
        BOOL hasHeader = [self jq_hasHeaderInSection:section];
        BOOL hasFooter = [self jq_hasFooterInSection:section];
        CGSize headerSize = [self jq_referenceSizeForHeaderInSection:section];
        CGSize footerSize = [self jq_referenceSizeForFooterInSection:section];
        UIEdgeInsets sectionInset = [self jq_insetForSectionAtIndex:section];
        UIEdgeInsets contentInset = self.collectionView.contentInset;

        //*********************** header ***********************//
        if (hasHeader)
        {
            UICollectionViewLayoutAttributes *headerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            headerAttr.frame = isVertical ? CGRectMake(0, preMax, self.collectionView.frame.size.width - contentInset.left - contentInset.right, headerSize.height) : CGRectMake(preMax, 0, headerSize.width, self.collectionView.frame.size.height - contentInset.top - contentInset.bottom);
            [self jq_cacheLayoutAttribute:headerAttr of:UICollectionElementKindSectionHeader at:[NSIndexPath indexPathForItem:0 inSection:section]];
            preMax += isVertical ? CGRectGetHeight(headerAttr.frame) : CGRectGetWidth(headerAttr.frame);
        }

        //*********************** cell ***********************//
        int rowCount = 0;
        CGFloat interitemSpacing = 0.f;
        if (isVertical)
        {
            rowCount = (self.collectionView.frame.size.width - sectionInset.left - sectionInset.right - contentInset.left - contentInset.right + minimumInteritemSpacing) / (size.width + minimumInteritemSpacing);
            interitemSpacing = rowCount > 1 ? (self.collectionView.frame.size.width - sectionInset.left - sectionInset.right - contentInset.left - contentInset.right - size.width * rowCount) / (rowCount - 1.f) : minimumInteritemSpacing;
        }
        else
        {
            rowCount = (self.collectionView.frame.size.height - sectionInset.top - sectionInset.bottom - contentInset.top - contentInset.bottom + minimumInteritemSpacing) / (size.height + minimumInteritemSpacing);
            interitemSpacing = rowCount > 1 ? (self.collectionView.frame.size.height - sectionInset.top - sectionInset.bottom - contentInset.top - contentInset.bottom - size.height * rowCount) / (rowCount - 1.f) : minimumInteritemSpacing;
        }
        CGPoint *points = new CGPoint[rowCount];
        for (NSInteger item = 0; item < items; item++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGSize itemSize = [self jq_sizeForItemAtIndexPath:indexPath];
            if (item < rowCount)
            {
                CGFloat x, y;
                if (isVertical)
                {
                    x = rowCount == 1 ? (self.collectionView.frame.size.width - itemSize.width) / 2.f : (sectionInset.left + (size.width + interitemSpacing) * item);
                    y = preMax + sectionInset.top;
                }
                else
                {
                    x = preMax + sectionInset.left;
                    y = rowCount == 1 ? (self.collectionView.frame.size.height - itemSize.height) / 2.f : (sectionInset.top + (size.height + interitemSpacing) * item);
                }
                UICollectionViewLayoutAttributes *cellAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                cellAttr.frame = isVertical ? CGRectMake(x, y, size.width, itemSize.height) : CGRectMake(x, y, itemSize.width, size.height);
                [self jq_cacheLayoutAttribute:cellAttr of:JQCollectionElementKindCell at:indexPath];
                points[item] = isVertical ? CGPointMake(x, y + itemSize.height) : CGPointMake(x + itemSize.width, y);
            }
            else
            {
                CGPoint small = isVertical ? CGPointSmallestYPoint(rowCount, points) : CGPointSmallestXPoint(rowCount, points);
                CGFloat x = isVertical ? small.x : small.x + minimumLineSpacing;
                CGFloat y = isVertical ? small.y + minimumLineSpacing : small.y;
                UICollectionViewLayoutAttributes *cellAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                cellAttr.frame = isVertical ? CGRectMake(x, y, size.width, itemSize.height) : CGRectMake(x, y, itemSize.width, size.height);
                [self jq_cacheLayoutAttribute:cellAttr of:JQCollectionElementKindCell at:indexPath];
                isVertical ? CGPointReplaceSmallestYPoint(CGPointMake(x, y + itemSize.height), points, rowCount) : CGPointReplaceSmallestXPoint(CGPointMake(x + itemSize.width, y), points, rowCount);
            }
        }
        if (items == 0)
        {
            preMax += isVertical ? sectionInset.top + sectionInset.bottom : sectionInset.left + sectionInset.right;
        }
        else
        {
            preMax = isVertical ? CGPointBiggestYPoint(rowCount, points).y + sectionInset.bottom : CGPointBiggestXPoint(rowCount, points).x + sectionInset.right;
        }
        delete[] points;
        
        //*********************** footer ***********************//
        if (hasFooter)
        {
            CGFloat biggestXY = preMax;
            UICollectionViewLayoutAttributes *footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            footerAttr.frame = isVertical ? CGRectMake(0, biggestXY, self.collectionView.frame.size.width - contentInset.left - contentInset.right, footerSize.height) : CGRectMake(biggestXY, 0, footerSize.width, self.collectionView.frame.size.height - contentInset.top - contentInset.bottom);
            [self jq_cacheLayoutAttribute:footerAttr of:UICollectionElementKindSectionFooter at:[NSIndexPath indexPathForItem:0 inSection:section]];
            preMax = isVertical ? CGRectGetMaxY(footerAttr.frame) : CGRectGetMaxX(footerAttr.frame);
        }
    }
    self.layoutAttributes[kContentHeightWidth] = @(preMax);
}

#pragma mark -
#pragma mark - layout

- (CGSize)collectionViewContentSize
{
    CGFloat contentHeightWidth = [self.layoutAttributes[kContentHeightWidth] floatValue];
    BOOL isVertical = self.scrollDirection == UICollectionViewScrollDirectionVertical;
    return isVertical ? CGSizeMake(self.collectionView.frame.size.width - self.collectionView.contentInset.left - self.collectionView.contentInset.right, contentHeightWidth) : CGSizeMake(contentHeightWidth, self.collectionView.frame.size.height - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attrs = [[NSMutableArray alloc] init];
    for (UICollectionViewLayoutAttributes *attr in self.layoutAttributes.allValues)
    {
        if (![attr isKindOfClass:[UICollectionViewLayoutAttributes class]]) continue;
        if (CGRectIntersectsRect(attr.frame, rect))
        {
            [attrs addObject:attr];
        }
    }
    return attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self jq_cachedLayoutAttributeOf:JQCollectionElementKindCell at:indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    return [self jq_cachedLayoutAttributeOf:elementKind at:indexPath];
}

@end
