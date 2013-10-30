//
//  PopupView.m
//  b866
//
//  Created by ccnyou on 10/30/13.
//  Copyright (c) 2013 ccnyou. All rights reserved.
//

#import "PopupView.h"

@interface PopupView()

@property (nonatomic, assign) CGRect endFrame;
@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, strong) UIColor* mainColor;
@property (nonatomic, strong) UIColor* activeColor;
@property (nonatomic, strong) UIControl* bgControl;
@property (nonatomic, strong) UIScrollView* scrollView;
@end

@implementation PopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mainColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.activeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        self.layer.backgroundColor = self.mainColor.CGColor;
        self.clipsToBounds = YES;
        
        self.endFrame = self.bounds;
        self.startFrame = self.endFrame;
        _startFrame.origin.y -= _endFrame.size.height;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.startFrame];
        self.scrollView.contentSize = self.startFrame.size;
        [super addSubview:self.scrollView];
        
        UIControl* bgControl = [[UIControl alloc] initWithFrame:self.bounds];
        [bgControl addTarget:self action:@selector(onBackgroundClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:bgControl];
        self.bgControl = bgControl;
    }
    return self;
    
}

- (void)onBackgroundClicked
{
    [self.delegate didBackgroundTap];
}

- (void)addSubview:(UIView *)view
{
    if (view == self.scrollView) {
        [NSException raise:@"error here" format:@"不能在这里添加控件"];
        return;
    }
    
    [self.bgControl addSubview:view];
}

- (void)show
{
    float bounceOffset = -7.0;
    float animationDuration = 0.3f;
    [UIView animateWithDuration:animationDuration animations:^{
        self.layer.backgroundColor = self.activeColor.CGColor;
        self.scrollView.frame = self.endFrame;
        self.scrollView.contentOffset = CGPointMake(0, bounceOffset);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }];
}

- (void)hide
{
    float bounceOffset = -7.0;
    float animationDuration = 0.3f;
    [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
        self.scrollView.contentOffset = CGPointMake(0, bounceOffset);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.layer.backgroundColor = self.mainColor.CGColor;
            self.scrollView.frame = self.startFrame;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}


- (float)bounceAnimationDuration
{
    float percentage = 28.57;
    float animationDuration = 0.3f;
    return animationDuration * percentage / 100.0;
}

@end
