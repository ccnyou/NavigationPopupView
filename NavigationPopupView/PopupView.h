//
//  PopupView.h
//  b866
//
//  Created by ccnyou on 10/30/13.
//  Copyright (c) 2013 ccnyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupViewDelegate <NSObject>

- (void)didBackgroundTap;

@end

@interface PopupView : UIView

@property (nonatomic, weak) id<PopupViewDelegate> delegate;

- (void)show;
- (void)hide;

@end
