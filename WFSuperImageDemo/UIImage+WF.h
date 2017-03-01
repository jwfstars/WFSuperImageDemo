//
//  UIImage+WF.h
//  WFSuperImageDemo
//
//  Created by 江文帆 on 2017/3/1.
//  Copyright © 2017年 江文帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WF)

- (UIImage *)imageByResizeToSize:(CGSize)size;
- (UIImage *)imageByResizeToRect:(CGRect)imageRect;
@end
