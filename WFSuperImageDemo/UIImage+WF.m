//
//  UIImage+WF.m
//  WFSuperImageDemo
//
//  Created by 江文帆 on 2017/3/1.
//  Copyright © 2017年 江文帆. All rights reserved.
//

#import "UIImage+WF.h"

@implementation UIImage (WF)

- (UIImage *)imageByResizeToSize:(CGSize)size
{
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByResizeToRect:(CGRect)imageRect
{
    UIGraphicsBeginImageContext(imageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, 0, imageRect.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSaveGState(context);
//    CGContextDrawImage(context, imageRect, self.CGImage);
    [self drawInRect:imageRect];
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
