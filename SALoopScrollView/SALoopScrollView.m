//
//  SALoopScrollView.m
//  SALoopScrollView
//
//  Created by Andy on 15/9/16.
//  Copyright (c) 2015年 Andy. All rights reserved.
//

#import "SALoopScrollView.h"
#import "SASinglePageView.h"

#define kLoopScrollviewWidth    (self.bounds.size.width)
#define kLoopScrollviewHeight   (self.bounds.size.height)

@interface SALoopScrollView() {
    
    BOOL _isFirstTimeScroll;         //是否第一次滑动
    NSInteger _currentIndex;         //当前展示第几个大图，初始值为1
}

@property (nonatomic, strong) SASinglePageView  *firstView;
@property (nonatomic, strong) SASinglePageView  *secondView;
@property (nonatomic, strong) SASinglePageView  *thirdView;

@end

@implementation SALoopScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self prepareSubviews];
    }
    return self;
}

- (void)initData {
    
    _isFirstTimeScroll = YES;
    _currentIndex = 1;
}

- (void)prepareSubviews {
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollview.delegate = self;
    scrollview.contentSize = CGSizeMake(kLoopScrollviewWidth * 3, kLoopScrollviewHeight);
    scrollview.bounces = YES;
    scrollview.pagingEnabled = YES;
    [self addSubview:scrollview];
    // 添加3个子视图到scrollview上
    _firstView = [[SASinglePageView alloc] initWithFrame:CGRectMake(0, 0, kLoopScrollviewWidth, kLoopScrollviewHeight)];
    _firstView.title = @"1";
    [scrollview addSubview:_firstView];
    
    _secondView = [[SASinglePageView alloc] initWithFrame:CGRectMake(kLoopScrollviewWidth, 0, kLoopScrollviewWidth, kLoopScrollviewHeight)];
    _secondView.title = @"2";
    [scrollview addSubview:_secondView];
    
    _thirdView = [[SASinglePageView alloc] initWithFrame:CGRectMake(2 * kLoopScrollviewWidth, 0, kLoopScrollviewWidth, kLoopScrollviewHeight)];
    [scrollview addSubview:_thirdView];
    
}

#pragma mark UIScrollview Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"%f",offset.x);
    // 滑动后是第几个view，从1~3
    int currentPage = floor((offset.x - kLoopScrollviewWidth/2)/kLoopScrollviewWidth) + 2;
    
    // 计算view的index
    if (0) {
        _isFirstTimeScroll = NO;
        _currentIndex += offset.x/kLoopScrollviewWidth;
        // 如果第一次往滑完还停留在页面1，则return
        if (_currentIndex == 1) {
            return;
        }
    }
    else {
        // 判断是否从第一页开始滑动
        if (_currentIndex == 1) {
            // 左滑或停留在当前页
            if (currentPage == 1) {
                return;
            }
            // 又滑
            else if (currentPage == 2) {
                _currentIndex += 1;
            }
        }
        // 不是从第一页滑动,
        else {
            // 左滑
            if (currentPage == 1) {
                _currentIndex -= 1;
            }
            // 右滑
            else if (currentPage == 3) {
                _currentIndex += 1;
            }
        }
        
    }
    
    if (_currentIndex == 1) {
        return;
    }

    
    // 目的：将当前显示的图移到3个view中间的那个，即offset为视图宽度
    // offset=0，当前view位于左边的，需要将交换指针，将view3对应的视图放在view1上
    if (currentPage == 1) {
        SASinglePageView *tmpView = _thirdView;
        _thirdView = _secondView;
        _secondView = _firstView;
        _firstView = tmpView;
    }
    // 此时，当前视图为view3，需将该视图移到view2位置上
    else if (currentPage == 3) {
        SASinglePageView *tmpView = _firstView;
        _firstView = _secondView;
        _secondView = _thirdView;
        _thirdView = tmpView;
        
    }
    
    // 配置scrollview
    [self configScrollviewWithCurrentIndex:_currentIndex];
    
    // 重新设置offset
    _firstView.frame = CGRectMake(0, 0, kLoopScrollviewWidth, kLoopScrollviewHeight);
    _secondView.frame = CGRectMake(kLoopScrollviewWidth, 0, kLoopScrollviewWidth, kLoopScrollviewHeight);
    _thirdView.frame = CGRectMake(2 * kLoopScrollviewWidth, 0, kLoopScrollviewWidth, kLoopScrollviewHeight);
    scrollView.contentOffset = CGPointMake(kLoopScrollviewWidth, 0);
}

// 配置3个view
- (void)configScrollviewWithCurrentIndex:(NSInteger)index {
    
    _firstView.title = [NSString stringWithFormat:@"%ld",index - 1];
    _secondView.title = [NSString stringWithFormat:@"%ld",index];
    _thirdView.title = [NSString stringWithFormat:@"%ld",index + 1];
}

@end
