//
//  TggAdvertisementView.m
//  AdvertisementTestDemo
//
//  Created by 吴玉铁 on 15/11/24.
//  Copyright © 2015年 铁哥. All rights reserved.
//

#import "TggCycleAdView.h"
#import "UIImageView+WebCache.h"

#define MaxTimes        100000
static NSString *const identifier = @"TggAdCell";


@interface TggCycleAdView (){
    UICollectionView *_collectionView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
}

@property (nonatomic,strong) NSArray *urlArray;
@property (nonatomic,assign,getter=isTimed) BOOL timed;
@property (nonatomic,copy) DidSelectItemBlock didSelectItemBlock;


@end


@implementation TggCycleAdView 


+ (instancetype)cycleAdViewWithUrlArray:(NSArray *)urls
                                  Frame:(CGRect)frame
                     DidSelectItemBlock:(DidSelectItemBlock)didSelectItemBlock{
    TggCycleAdView *tggAdView = [[self alloc]initWithFrame:frame];
    tggAdView.urlArray = urls;
    tggAdView.didSelectItemBlock = tggAdView.didSelectItemBlock;
    return tggAdView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)setUrlArray:(NSArray *)urlArray{
    if (_urlArray != urlArray) {
        _urlArray = urlArray;
        [self parseUrlArray];
    }
}

- (void)parseUrlArray{
    /*
     *  image: image2 image0 image1 image2 image0
     *  cell:  cell0  cell1  cell2  cell3  cell4   cell5
     */
    self.timed = NO;
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.urlArray];
    [temp addObject:[_urlArray firstObject]];
    [temp insertObject:[_urlArray lastObject] atIndex:0];
    _urlArray = temp;
    _pageControl.numberOfPages = self.urlArray.count - 2;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:MaxTimes / 2 + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)createSubviews{
    // configCollectionView
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView.collectionViewLayout = layout;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
    [self addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    _collectionView.backgroundColor = [UIColor greenColor];
    _collectionView.pagingEnabled = YES;
    [_collectionView setContentOffset:CGPointMake(width, 0)];
    // configPageControl
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((width - 150) / 2,height - 20, 150, 20)];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.numberOfPages = self.urlArray.count - 2;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];

}

- (void)setTimed:(BOOL)Timed WithTimerInterval:(CGFloat)timerInterval{
    // timer
    if (Timed == YES) {
        _timed = YES;
        CGFloat interval = 5.0;
        if (timerInterval > 0) {
            interval = timerInterval;
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(scrollViewSetContentOffsetX) userInfo:nil repeats:YES];
    }
}

#pragma mark scrollViewDelagate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = (index - 1) % (self.urlArray.count - 2);
    if (self.isTimed) {
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scrollViewSetContentOffsetX) userInfo:nil repeats:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.x == 0) {
        [scrollView setContentOffset:CGPointMake(self.frame.size.width * (self.urlArray.count - 2), 0)];
    }else if (point.x == self.frame.size.width * ((self.urlArray.count - 2) * MaxTimes + 2 - 1)){
        [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
}

#pragma mark collectionViweDelagate&DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return (self.urlArray.count - 2) * MaxTimes + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier  forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    UIImageView *bgImage = [[UIImageView alloc]init];
    NSString *url = self.urlArray[indexPath.item % (self.urlArray.count - 2)];
    [bgImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[self tggAlterToImageWithColor:[UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0]]];
    cell.backgroundView = bgImage;
    cell.layer.cornerRadius = 50;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(indexPath.item);
    }
}

#pragma mark-ScrollSetContentX
- (void)scrollViewSetContentOffsetX{
    [_collectionView setContentOffset:CGPointMake(_collectionView.contentOffset.x + self.frame.size.width, 0) animated:YES];
    [self performSelector:@selector(timerScrollViewDidEndDecelerating) withObject:nil afterDelay:0.3];
}

- (void)timerScrollViewDidEndDecelerating{
    
    NSUInteger index = _collectionView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = (index - 1) % (self.urlArray.count - 2);
    
}

#pragma mark-＊＊＊＊＊工具方法

- (UIImage *)tggAlterToImageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
