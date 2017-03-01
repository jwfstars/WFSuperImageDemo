//
//  ViewController.m
//  WFSuperImageDemo
//
//  Created by 江文帆 on 2017/2/28.
//  Copyright © 2017年 江文帆. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+MKBlockTimer.h"
#import "WFTiledView.h"
#import "WFTiledScrollView.h"
#import "UIView+WF.h"

@interface ViewController () <CALayerDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) WFTiledScrollView *scrollView;
@property (nonatomic, strong) WFTiledView *tiledView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

#error please download the image then delete this line
    /*
     Image URL 
     
     http://www.eso.org/public/archives/images/publicationtiff/eso1242a.tif
     http://www.eso.org/public/images/eso1242a/
     */
    UIImage *bigImage = [UIImage imageNamed:@"eso1242a.tif"];
//    UIImage *bigImage = [UIImage imageNamed:@"eso1242a_small.jpg"];
    
    [self setupScrollViewWithImage:bigImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupScrollViewWithImage:(UIImage *)image
{
    WFTiledScrollView *scrollView = [[WFTiledScrollView alloc] initWithFrame:self.view.bounds image:image];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

@end
