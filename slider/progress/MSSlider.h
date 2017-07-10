//
//  MSSlider.h
//  progress
//
//  Created by msj on 2017/7/3.
//  Copyright © 2017年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MSSliderIntervalStyle) {
    MSSliderIntervalStyle_One,
    MSSliderIntervalStyle_Ten,
    MSSliderIntervalStyle_Hundred,
    MSSliderIntervalStyle_Thousand,
    MSSliderIntervalStyle_TenThousand
};

@interface MSSlider : UIView
@property (assign, nonatomic) float minValue;
@property (assign, nonatomic) float maxValue;
@property (assign, nonatomic, readonly) float currentValue;
@property (assign, nonatomic) MSSliderIntervalStyle intervalStyle;
@property (copy, nonatomic) void (^valueChangeBlock)(float currentValue);
@end
