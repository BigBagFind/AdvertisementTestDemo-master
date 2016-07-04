//
//  ViewController.m
//  AdvertisementTestDemo
//
//  Created by 吴玉铁 on 15/11/24.
//  Copyright © 2015年 铁哥. All rights reserved.
//

#import "ViewController.h"
#import "TggCycleAdView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController


- (IBAction)action:(id)sender {
    NSArray *urls = @[@"http://o97xkam4w.bkt.clouddn.com/tiequantech_ios_1467362218.422740",
                      @"http://o97xkam4w.bkt.clouddn.com/tiequantech_ios_1467362218.413845",
                      @"http://o97xkam4w.bkt.clouddn.com/tiequantech_ios_1467269451.926199",
                      @"http://o97xkam4w.bkt.clouddn.com/tiequantech_ios_1467269451.913519"];
    TggCycleAdView *view = [TggCycleAdView cycleAdViewWithUrlArray:urls Frame:(CGRect){0,0,kScreenWidth,250} DidSelectItemBlock:^(NSUInteger index) {
        
    }];
    [view setTimed:YES WithTimerInterval:5.0];
    [self.view addSubview:view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
}



@end
