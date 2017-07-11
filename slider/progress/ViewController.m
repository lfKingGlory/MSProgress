//
//  ViewController.m
//  progress
//
//  Created by msj on 2017/7/3.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "ViewController.h"
#import "MSSlider.h"


@interface ViewController ()
@property (strong, nonatomic) MSSlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width - 60, 68)];
    slider.minValue = 1000;
    slider.maxValue = 100000;
    slider.intervalStyle = MSSliderIntervalStyle_Thousand;
    [self.view addSubview:slider];
    self.slider = slider;
    slider.valueChangeBlock = ^(float currentValue) {
      
        NSLog(@"%.2f",currentValue);
        
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.slider.minValue = 1000;
        self.slider.maxValue = 100000;
        self.slider.intervalStyle = MSSliderIntervalStyle_Thousand;
    });
    
    {
        MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 200, self.view.frame.size.width - 60, 68)];
        slider.minValue = 10;
        slider.maxValue = 10000;
        slider.intervalStyle = MSSliderIntervalStyle_Thousand;
        [self.view addSubview:slider];
    }
    
    {
        MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 300, self.view.frame.size.width - 60, 68)];
        slider.minValue = 1000;
        slider.maxValue = 10000;
        slider.intervalStyle = MSSliderIntervalStyle_Hundred;
        [self.view addSubview:slider];
    }
    
    {
        MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 400, self.view.frame.size.width - 60, 68)];
        slider.minValue = 1000;
        slider.maxValue = 100000;
        slider.intervalStyle = MSSliderIntervalStyle_TenThousand;
        [self.view addSubview:slider];
    }
    
    {
        MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 500, self.view.frame.size.width - 60, 68)];
        slider.minValue = 10;
        slider.maxValue = 1000;
        slider.intervalStyle = MSSliderIntervalStyle_Ten;
        [self.view addSubview:slider];
    }
    
    
    NSLog(@"%@",[self convertMoneyFormate:93845348.34]);
    
    
    
}

- (NSString *)convertMoneyFormate:(double)amount {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:amount]];
    
}

@end
