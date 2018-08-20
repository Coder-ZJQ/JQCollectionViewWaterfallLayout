//
//  JQCollectionViewImageCell.m
//  JQCollectionViewBrickLayout_Example
//
//  Created by Joker on 2018/8/20.
//  Copyright © 2018年 coder-zjq. All rights reserved.
//

#import "JQCollectionViewImageCell.h"

@interface JQCollectionViewImageCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation JQCollectionViewImageCell

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

@end
