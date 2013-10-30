//
//  TitleButton.h
//  b866
//
//  Created by ccnyou on 10/30/13.
//  Copyright (c) 2013 ccnyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleButton : UIControl

@property (assign, nonatomic) BOOL isActive;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* arrow;

+ (CGGradientRef)newSpotlightGradient;

@end
