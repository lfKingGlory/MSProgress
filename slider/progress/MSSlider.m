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

@interface MSSlider ()
@property (assign, nonatomic, readwrite) float currentValue;
@property (strong, nonatomic) UILabel *lbProgress;
@property (strong, nonatomic) UISlider *slider;
@property (assign, nonatomic) int interval;
@end

@implementation MSSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lbProgress = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        self.lbProgress.text = @"0";
        self.lbProgress.textColor = [UIColor colorWithRed:246/255.0 green:37/255.0 blue:0/255.0 alpha:1];
        self.lbProgress.textAlignment = NSTextAlignmentCenter;
        self.lbProgress.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:self.lbProgress];
        
        self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
        self.slider.minimumTrackTintColor = [UIColor colorWithRed:246/255.0 green:37/255.0 blue:0/255.0 alpha:1];
        self.slider.maximumTrackTintColor = [UIColor ms_colorWithHexString:@"#f8f8f8"];
        UIImage *thumbImage = [UIImage ms_createImageWithColor:[UIColor colorWithRed:246/255.0 green:37/255.0 blue:0/255.0 alpha:1] withSize:CGSizeMake(20, 20)];
        [self.slider setThumbImage:thumbImage forState:UIControlStateNormal];
        [self.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.slider];
        
        self.currentValue = 0;
    }
    return self;
}

- (void)setMinValue:(float)minValue {
    _minValue = minValue;
    self.slider.minimumValue = minValue;
}

- (void)setMaxValue:(float)maxValue {
    _maxValue = maxValue;
    self.slider.maximumValue = maxValue;
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
    self.lbProgress.text = [NSString stringWithFormat:@"%d",self.interval];
}

- (void)valueChanged:(UISlider *)slider {
    
    int value = floorf(slider.value);
    int realValue = (value / self.interval) * self.interval;
    if (realValue == 0) {
        realValue = self.interval;
    }
    self.lbProgress.text = [NSString stringWithFormat:@"%d",realValue];
    self.currentValue = realValue;
    if (self.valueChangeBlock) {
        self.valueChangeBlock(self.currentValue);
    }
}

@end
