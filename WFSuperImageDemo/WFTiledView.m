//
//  WFTiledView.m
//  WFSuperImageDemo
//
//  Created by 江文帆 on 2017/2/28.
//  Copyright © 2017年 江文帆. All rights reserved.
//

#import "WFTiledView.h"
#import "UIImage+WF.h"

@interface WFTiledView ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat imageScale;
@property (nonatomic, assign) CGRect imageRect;
@end

@implementation WFTiledView

+ (Class)layerClass
{
    return [CATiledLayer class];
}


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image scale:(CGFloat)scale
{
    if ((self = [super initWithFrame:frame])) {
        _image = image;
        _imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
        _imageScale = scale;
        
        CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
        tiledLayer.levelsOfDetail = 4;
        tiledLayer.levelsOfDetailBias = 4;
        tiledLayer.tileSize = CGSizeMake(256, 256);
    }
    return self;
}


- (void)setContentScaleFactor:(CGFloat)contentScaleFactor
{
    [super setContentScaleFactor:1];
}


- (void)drawRect:(CGRect)rect
{
    //    NSLog(@"drawRect %@ ",NSStringFromCGRect(rect));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextScaleCTM(context, _imageScale, _imageScale);
    [_image drawInRect:_imageRect];
    CGContextRestoreGState(context);
}

@end
