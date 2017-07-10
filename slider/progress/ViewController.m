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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width - 60, 45)];
    slider.minValue = 1000;
    slider.maxValue = 100000;
    slider.intervalStyle = MSSliderIntervalStyle_Thousand;
    [self.view addSubview:slider];
    
    slider.valueChangeBlock = ^(float currentValue) {
      
        NSLog(@"%.2f",currentValue);
        
    };
    
    {
        MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 200, self.view.frame.size.width - 60, 45)];
        slider.minValue = 10;
        slider.maxValue = 100;
        slider.intervalStyle = MSSliderIntervalStyle_One;
        [self.view addSubview:slider];
    }
    
    {
        MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 300, self.view.frame.size.width - 60, 45)];
        slider.minValue = 1000;
        slider.maxValue = 10000;
        slider.intervalStyle = MSSliderIntervalStyle_Hundred;
        [self.view addSubview:slider];
    }
    
    {
        MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 400, self.view.frame.size.width - 60, 45)];
        slider.minValue = 1000;
        slider.maxValue = 100000;
        slider.intervalStyle = MSSliderIntervalStyle_TenThousand;
        [self.view addSubview:slider];
    }
    
    {
        MSSlider *slider = [[MSSlider alloc] initWithFrame:CGRectMake(30, 500, self.view.frame.size.width - 60, 45)];
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
