//
//  ViewController.m
//  SALoopScrollView
//
//  Created by Andy on 15/9/16.
//  Copyright (c) 2015年 Andy. All rights reserved.
//

#import "ViewController.h"
#import "SALoopScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareLoopScrollview];
}

- (void)prepareLoopScrollview {
    
    CGRect rect = self.view.bounds;
    SALoopScrollView *loopScrollview = [[SALoopScrollView alloc] initWithFrame:rect];
    [self.view addSubview:loopScrollview];
}

@end
