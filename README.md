# 基于collectionView可复用的图片轮播广告(可定时轮播或不定时)

##特性：
### 1.可以循环滚动
### 2.定时或不定时
### 3.可以复用
### 4.一步初始化init搞定

##内容简介：
### 代码：
TggCycleAdView *view = [TggCycleAdView cycleAdViewWithUrlArray:urls Frame:(CGRect){0,0,kScreenWidth,250} DidSelectItemBlock:^(NSUInteger index) {
        
}];
[view setTimed:YES WithTimerInterval:5.0];
[self.view addSubview:view];
#### 先自己用用看

