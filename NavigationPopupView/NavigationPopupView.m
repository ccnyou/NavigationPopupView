//
//  NavigationPopupView.m
//  NavigationMenu
//
//  Created by ccnyou on 10/30/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "NavigationPopupView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+ccWidgets.h"


@interface NavigationPopupView  ()

@property (nonatomic, strong) UIView* containerView;

@end


@implementation NavigationPopupView


- (id)initWithButtonFrame:(CGRect)frame popupViewFrame:(CGRect)popupViewFrame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.titleButton = [[TitleButton alloc] initWithFrame:frame];
        self.titleButton.titleLabel.text = title;
        [self.titleButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [super addSubview:self.titleButton];

        self.popupView = [[PopupView alloc] initWithFrame:popupViewFrame];
        self.popupView.delegate = self;
    }
    return self;
}

- (void)addSubview:(UIView *)view
{
    if (view == self.popupView) {
        [NSException raise:@"error here" format:@"不能在这里添加popupView"];
        return;
    }
    
    [self.popupView addSubview:view];
}

- (void)setTitle:(NSString *)title
{
    if (self.titleButton == nil) {
        CGRect frame = self.frame;
        frame.origin.y += 1.0;
        self.titleButton = [[TitleButton alloc] initWithFrame:frame];
        [self.titleButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [super addSubview:self.titleButton];
    }
    self.titleButton.titleLabel.text = title;
}

- (void)displayInView:(UIView *)aView
{
    self.containerView = aView;
}

- (void)onHandleMenuTap:(id)sender
{
    if (self.titleButton.isActive) {
        [self onPopupUp];
    } else {
        [self onHide];
    }
}


- (void)onPopupUp
{
    [self.containerView addSubview:self.popupView];
    [self rotateArrow:M_PI];
    [self.popupView show];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationPopupViewDidShow:)]) {
        [self.delegate navigationPopupViewDidShow:self];
    }
    
}

- (void)onHide
{
    [self.popupView hide];
    [self rotateArrow:0];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationPopupViewDidHide:)]) {
        [self.delegate navigationPopupViewDidHide:self];
    }
}


//让那个小三角形转圈效果
- (void)rotateArrow:(float)degrees
{
    float animationDuration = 0.3f;
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.titleButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

- (void)didBackgroundTap
{
    self.titleButton.isActive = !self.titleButton.isActive;
    [self onHandleMenuTap:nil];
}

@end
