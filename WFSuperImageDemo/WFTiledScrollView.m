//
//  WFTiledScrollView.m
//  WFSuperImageDemo
//
//  Created by 江文帆 on 2017/2/28.
//  Copyright © 2017年 江文帆. All rights reserved.
//

#import "WFTiledScrollView.h"
#import "UIImage+WF.h"
#import "UIView+WF.h"
#import "WFTiledView.h"

@interface WFTiledScrollView () <UIScrollViewDelegate>
@property (nonatomic, strong) WFTiledView *tiledView;
@property (nonatomic, strong) WFTiledView *backtiledView;
@property (nonatomic, strong) UIImageView *fakeImageView;

@property (nonatomic, assign) CGFloat minimumScale;
@property (nonatomic, assign) CGFloat imageScale;
@property (nonatomic, strong) UIImage *image;
@end

@implementation WFTiledScrollView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithImage:image];
    }
    return self;
}

- (void)setupWithImage:(UIImage *)image
{
    self.image = image;
    
    self.delegate = self;
    self.maximumZoomScale = 8.0f;
    self.minimumZoomScale = 0.125f;
    
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    self.imageScale = self.width/imageW;
    
    self.minimumScale = _imageScale;
    
    NSLog(@"imageScale: %f",_imageScale);
    
    CGRect imageRect = CGRectMake(0, 0, imageW * _imageScale, imageH * _imageScale);
    
    NSLog(@"imageRect: %@",NSStringFromCGRect(imageRect));
    
    [self showFakeImage:image withRect:imageRect];
    [self createtiledViewWithImage:image withRect:imageRect];
}


- (void)createtiledViewWithImage:(UIImage *)image withRect:(CGRect)imageRect
{
    self.tiledView = [[WFTiledView alloc] initWithFrame:imageRect image:image scale:_imageScale];
    [self addSubview:_tiledView];
}


- (void)showFakeImage:(UIImage *)image withRect:(CGRect)imageRect
{
    UIImageView *fakeImageView = [[UIImageView alloc] initWithFrame:imageRect];
    fakeImageView.image = [image imageByResizeToRect:imageRect];
    fakeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self insertSubview:fakeImageView atIndex:0];
    self.fakeImageView = fakeImageView;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.size;
    CGRect frame = _tiledView.frame;
    
    if (frame.size.width < size.width) {
        frame.origin.x = (size.width - frame.size.width) / 2;
    }else {
        frame.origin.x = 0;
    }
    
    if (frame.size.height < size.height) {
        frame.origin.y = (size.height - frame.size.height) / 2;
    }else {
        frame.origin.y = 0;
    }
    
    _tiledView.frame = frame;
    _fakeImageView.frame = frame;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _tiledView;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.imageScale *= scale;
    
    if(_imageScale < _minimumScale) {
        self.imageScale = _minimumScale;
    }
    
    CGFloat imageW = _image.size.width;
    CGFloat imageH = _image.size.height;
    CGRect imageRect = CGRectMake(0, 0, imageW * _imageScale, imageH * _imageScale);
    [self createtiledViewWithImage:_image withRect:imageRect];
}


- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    [_backtiledView removeFromSuperview];
    self.backtiledView = _tiledView;
}

@end
