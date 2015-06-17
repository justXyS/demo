//
//  Index0_cell_1.m
//  E小区
//
//  Created by apple on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Index0_cell_1.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface Index0_cell_1()

@property(nonatomic,copy,readonly) NSMutableArray *urls;
@property(nonatomic,copy,readonly) NSMutableArray *imgNames;
@property (strong, nonatomic) UIImageView *imgView;
@property (nonatomic,assign) NSUInteger page;
@property (nonatomic,copy) NSMutableArray *images;
@property (nonatomic,copy) NSMutableArray *temp;
@property (nonatomic,strong) UIPageControl *pageCtl;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSString *animationType;
@property (nonatomic,assign) BOOL needPageIcon;
@property (nonatomic,assign) BOOL onlyOne;
@end

@implementation Index0_cell_1

-(void)setImgNames:(NSMutableArray *)imgNames{
    _imgNames = imgNames;
    [self setTemp:imgNames];
}

-(void)setUrls:(NSMutableArray *)urls{
    _urls = urls;
    [self setTemp:urls];
}

-(void)setTemp:(NSMutableArray *)temp{
    _temp = temp;
    if(temp&&temp.count>0){
        if(temp.count==1){self.onlyOne = YES;self.needPageIcon = YES;}
        [self setUp];
    }
}

-(void)setUrls:(NSMutableArray *)urls AndTimer:(NSTimeInterval)timeInterval isAuto:(BOOL)atou placeholderImage:(UIImage *)placeholderImage animationType:(NSString *)animationType
{
    _timeInterval = timeInterval;
    _isAutoScroll = atou;
    _placeholderImage = placeholderImage;
    self.animationType = animationType;
    [self setUrls:urls];
}

-(void)setImageNames:(NSMutableArray *)imageNames AndTimer:(NSTimeInterval)timeInterval isAuto:(BOOL)atou placeholderImage:(UIImage *)placeholderImage animationType:(NSString *)animationType notNeedPageIcon:(BOOL)needPageIcon{
    _timeInterval = timeInterval;
    _isAutoScroll = atou;
    _placeholderImage = placeholderImage;
    self.animationType = animationType;
    self.needPageIcon = needPageIcon;
    [self setImgNames:imageNames];
}

-(void)setUp{
    if(_pageCtl){
        [_pageCtl removeFromSuperview];
    }
    //_page = 1;
    if(!_timeInterval){
        _timeInterval = 4;
    }
    if(_temp && _temp.count>0){
        if(!self.onlyOne){
            [self addTouchEvents];
        }
        if(!self.needPageIcon){
            [self addPageIcon];
        }
        if(_isAutoScroll && !self.onlyOne){
            if(!_timer){
                _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(autoChange) userInfo:nil repeats:YES];
            }
        }
    }
}

-(void)autoChange{
    [self toRight];
}

-(void)addAnimations:(BOOL)isRight{
    CATransition *animator = [CATransition animation];
    animator.type = self.animationType;
    if(isRight){
        animator.subtype = kCATransitionFromRight;
    }else{
        animator.subtype = kCATransitionFromLeft;
    }
    animator.duration = 0.8f;
    [_imgView.layer addAnimation:animator forKey:nil];
}

-(void)addTouchEvents{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftAction)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [swipeLeft setNumberOfTouchesRequired:1];
    [self.imageView addGestureRecognizer:swipeLeft];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [swipeRight setNumberOfTouchesRequired:1];
    [self.imageView addGestureRecognizer:swipeRight];
}

-(void)addPageIcon{
    _pageCtl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, 80, 5*_temp.count, 10)];
    _pageCtl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageCtl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageCtl.currentPage = _page-1;
    _pageCtl.enabled = NO;
    _pageCtl.numberOfPages = _temp.count;
    [self addSubview:_pageCtl];
}

-(void)swipeLeftAction
{
    _page--;
    if(_page < 1){
        _page = [_temp count];
    }
    [self chage];
    [self addAnimations:NO];
}

-(void)swipeRightAction
{
    [self toRight];
}

-(void)toRight{
    _page++;
    if(_page > [_temp count]){
        _page = 1;
    }
    [self chage];
    [self addAnimations:YES];
}

-(void)chage{
    _pageCtl.currentPage = _page-1;
    if(_imgNames){
        _imgView.image = [UIImage imageNamed:_temp[_page-1]];
    }else{
        [_imgView sd_setImageWithURL:_temp[_page-1]];
    }
}

-(NSString *)animationType{
    if(!_animationType){
        _animationType = @"push";
    }
    return _animationType;
}

-(UIImageView *)imageView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        self.page = 1;
        [self chage];
    }
    return _imgView;
}

@end
