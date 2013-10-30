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

@protocol NavigationPopupViewDelegate <NSObject>
@end


@interface NavigationPopupView : UIView<PopupViewDelegate>

- (id)initWithButtonFrame:(CGRect)frame popupViewFrame:(CGRect)popupViewFrame andTitle:(NSString *)title;

@property (nonatomic, strong) TitleButton *titleButton;
@property (nonatomic,   weak) id<NavigationPopupViewDelegate> delegate;
@property (nonatomic, strong) PopupView* popupView;

- (void)setTitle:(NSString *)title;
- (void)displayInView:(UIView *)aView;

@end
