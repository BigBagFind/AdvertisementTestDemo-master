//
//  TggAdvertisementView.h
//  AdvertisementTestDemo
//
//  Created by 吴玉铁 on 15/11/24.
//  Copyright © 2015年 铁哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectItemBlock)(NSUInteger index);

@interface TggCycleAdView : UIView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

+ (instancetype)cycleAdViewWithUrlArray:(NSArray *)urls
                                  Frame:(CGRect)frame
                     DidSelectItemBlock:(DidSelectItemBlock)didSelectItemBlock;

- (void)setTimed:(BOOL)Timed WithTimerInterval:(CGFloat)timerInterval;//是否开启自动化轮播且设置时间,默认为5.0秒


@end
