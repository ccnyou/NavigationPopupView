//
//  NavigationPopupView.h
//  NavigationMenu
//
//  Created by ccnyou on 10/30/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleButton.h"
#import "PopupView.h"

@class NavigationPopupView;

@protocol NavigationPopupViewDelegate <NSObject>

@optional
- (void)navigationPopupViewDidShow:(NavigationPopupView *)popupView;
- (void)navigationPopupViewDidHide:(NavigationPopupView *)popupView;

@end


@interface NavigationPopupView : UIView<PopupViewDelegate>

@property (nonatomic, strong) TitleButton *titleButton;
@property (nonatomic,   weak) id<NavigationPopupViewDelegate> delegate;
@property (nonatomic, strong) PopupView* popupView;


- (id)initWithButtonFrame:(CGRect)frame popupViewFrame:(CGRect)popupViewFrame andTitle:(NSString *)title;

- (void)setTitle:(NSString *)title;
- (void)displayInView:(UIView *)aView;

//两个方法供用户手动弹出或收起
- (void)show;
- (void)hide;

@end
