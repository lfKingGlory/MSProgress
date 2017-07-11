//
//  MSSlider.m
//  progress
//
//  Created by msj on 2017/7/3.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSSlider.h"
#import "UIImage+color.h"
#import "UIColor+StringColor.h"
#import "UIView+FrameUtil.h"

@interface MSSlider ()
@property (assign, nonatomic, readwrite) float currentValue;
@property (strong, nonatomic) UILabel *lbProgress;
@property (strong, nonatomic) UISlider *slider;
@property (assign, nonatomic) int interval;

@property (strong, nonatomic) UILabel *lbMin;
@property (strong, nonatomic) UILabel *lbMax;
@end

@implementation MSSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lbProgress = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
        self.lbProgress.centerX = 10;
        self.lbProgress.textColor = [UIColor colorWithRed:246/255.0 green:37/255.0 blue:0/255.0 alpha:1];
        self.lbProgress.textAlignment = NSTextAlignmentCenter;
        self.lbProgress.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:self.lbProgress];
        
        self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lbProgress.frame) + 8, self.width, 20)];
        self.slider.minimumTrackTintColor = [UIColor colorWithRed:246/255.0 green:37/255.0 blue:0/255.0 alpha:1];
        self.slider.maximumTrackTintColor = [UIColor ms_colorWithHexString:@"#f8f8f8"];
        [self.slider setThumbImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.slider];
        
        self.currentValue = 0;
        
        self.lbMin = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.slider.frame) + 8, 200, 15)];
        self.lbMin.centerX = 0;
        self.lbMin.textColor = [UIColor blackColor];
        self.lbMin.alpha = 0.3;
        self.lbMin.textAlignment = NSTextAlignmentCenter;
        self.lbMin.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.lbMin];
        
        self.lbMax = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.slider.frame) + 8, 200, 15)];
        self.lbMax.centerX = self.width;
        self.lbMax.textColor = [UIColor blackColor];
        self.lbMax.alpha = 0.3;
        self.lbMax.textAlignment = NSTextAlignmentCenter;
        self.lbMax.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.lbMax];
    }
    return self;
}

- (void)setMinValue:(float)minValue {
    _minValue = minValue;
    self.slider.minimumValue = minValue;
    self.lbMin.text = [self convertMoneyFormate:minValue];
    
    self.lbProgress.text = [self convertMoneyFormate:minValue];
    CGSize size = [self.lbProgress.text sizeWithAttributes:@{NSFontAttributeName : self.lbProgress.font}];
    self.lbProgress.width = size.width;
    self.lbProgress.centerX = 10;
    
    self.currentValue = minValue;
    [self.slider setValue:minValue animated:YES];
}

- (void)setMaxValue:(float)maxValue {
    _maxValue = maxValue;
    self.slider.maximumValue = maxValue;
    self.lbMax.text = [self convertMoneyFormate:maxValue];
}

- (void)setIntervalStyle:(MSSliderIntervalStyle)intervalStyle {
    _intervalStyle = intervalStyle;
    switch (intervalStyle) {
        case MSSliderIntervalStyle_One:
        {
            self.interval = 1;
            break;
        }
        case MSSliderIntervalStyle_Ten:
        {
            self.interval = 10;
            break;
        }
        case MSSliderIntervalStyle_Hundred:
        {
            self.interval = 100;
            break;
        }
        case MSSliderIntervalStyle_Thousand:
        {
            self.interval = 1000;
            break;
        }
        case MSSliderIntervalStyle_TenThousand:
        {
            self.interval = 10000;
            break;
        }
        default:
            break;
    }
}

- (void)valueChanged:(UISlider *)slider {
    
    int value = floorf(slider.value);
    int realValue = 0;

    if (value == self.minValue || value == self.maxValue) {
        realValue = value;
    } else {
        
        if (self.minValue >= self.interval) {
            realValue = (value / self.interval) * self.interval;
        } else {
            realValue = ((value + self.interval) / self.interval) * self.interval + self.minValue;
            realValue = (realValue > self.maxValue) ? self.maxValue : realValue;
        }
    }
    
    self.lbProgress.text = [self convertMoneyFormate:realValue];
    CGSize size = [self.lbProgress.text sizeWithAttributes:@{NSFontAttributeName : self.lbProgress.font}];
    self.lbProgress.width = size.width;
    
    CGFloat progress = (slider.value - self.minValue) / (self.maxValue - self.minValue);
    
    if (progress == 0) {
        self.lbProgress.centerX = 10;
    } else if (progress == 1) {
        self.lbProgress.centerX = self.width * progress - 10;
    } else {
        self.lbProgress.centerX = self.width * progress;
    }
    
    self.currentValue = realValue;
    if (self.valueChangeBlock) {
        self.valueChangeBlock(self.currentValue);
    }
}

- (NSString *)convertMoneyFormate:(double)amount {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:amount]];
}
@end
