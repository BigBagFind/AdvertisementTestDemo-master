# 基于collectionView可复用的图片轮播广告(可定时轮播或不定时)

##特性：
### 1.可以循环滚动
### 2.定时或不定时
### 3.可以复用
### 4.一步初始化init搞定

##内容简介：
### 第一步：
####- (instancetype)initWithFrame:(CGRect)frame ContentImages:(NSArray *)contentImages;//初始化一步搞定循环广告
### 第二步：
####  - (void)setisTimed:(BOOL)isTimed WithTimerInterval:(CGFloat)timerInterval;//是否开启自动化轮播且设置时间,默认为5.0秒

### 第三步：
#### 简简单单自己用

![](http://chuantu.biz/t2/20/1448336111x-1376440232.png)
