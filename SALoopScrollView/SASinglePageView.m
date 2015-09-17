//
//  SASinglePageView.m
//  SALoopScrollView
//
//  Created by Andy on 15/9/17.
//  Copyright (c) 2015年 Andy. All rights reserved.
//

#import "SASinglePageView.h"

@interface SASinglePageView()

@property (nonatomic, strong) UILabel   *titleLabel;

@end

@implementation SASinglePageView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareSubviews];
    }
    return self;
}

- (void)prepareSubviews {
    
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:MIN(self.bounds.size.height, self.bounds.size.width)/3];
    _titleLabel.backgroundColor = [UIColor colorWithRed:(float)(arc4random()%255)/255 green:(float)(arc4random()%255)/255 blue:(float)(arc4random()%255)/255 alpha:1];
    [self addSubview:_titleLabel];
}

-(void)setTitle:(NSString *)title {
    
    _titleLabel.text = title;
}

@end
