    //
//  XLCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "XLCycleScrollView.h"
#import "Constant.h"

@implementation XLCycleScrollView
@synthesize scrollView = _scrollView;
@synthesize currentPage = _curPage;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;

@synthesize autoScrollTimer;


- (void)dealloc
{
    [_scrollView release];
    [_pageControl release];
    [_curViews release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupUIControl];
    }
    return self;
}

- (void)setupUIControl
{
    self.backgroundColor = [UIColor clearColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    _pageControl.center = self.center;
    
    CGRect rect = self.bounds;
    rect.origin.x = (APP_W - 80)/2;
    rect.origin.y = rect.size.height - 25;
    rect.size.width = 80;
    rect.size.height = 30;
    _pageControl = [[UIPageControl alloc] initWithFrame:rect];
 
    
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];

    _curPage = 0;
    self.addGesture = YES;
}

- (void)setDataource:(id<XLCycleScrollViewDatasource>)datasource
{
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData
{
    _totalPages = [_datasource numberOfPages];
    
    if (_totalPages == 0) {
        return;
    }
    if (_totalPages == 1) {//禁止滑动
        _scrollView.scrollEnabled = NO;
        _pageControl.hidden = YES;
    }else{
        _scrollView.scrollEnabled = YES;
        _pageControl.hidden = NO;
    }
    //add by meng
    if ([_datasource respondsToSelector:@selector(showBottomScrollLabel)]) {
        if ([_datasource showBottomScrollLabel]) {
            CGRect rect = self.bounds;
            rect.origin.y = rect.size.height - 55;
            [_pageControl setFrame:CGRectMake(0, _scrollView.frame.origin.y + _scrollView.frame.size.height - 55, [UIScreen mainScreen].bounds.size.width, 25)];
        }
    }
    _curPage = 0;
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    _pageControl.currentPage = _curPage;
    [_pageControl updateCurrentPageDisplay];
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
  
    
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < 3; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        if(self.addGesture){
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
            [singleTap release];
        }
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    if([self.delegate respondsToSelector:@selector(scollerToindex:)])
    {
        [self.delegate scollerToindex:_curPage];
    }
}

- (void)getDisplayImagesWithCurpage:(NSInteger)page {
    
    NSInteger pre = [self validPageValue:_curPage-1];
    NSInteger last = [self validPageValue:_curPage+1];
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    [_curViews addObject:[_datasource pageAtIndex:pre]];
    [_curViews addObject:[_datasource pageAtIndex:page]];
    [_curViews addObject:[_datasource pageAtIndex:last]];
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    return value;
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            if(self.addGesture) {
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleTap:)];
                [v addGestureRecognizer:singleTap];
                [singleTap release];
            }
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [_scrollView addSubview:v];
        }
    }
}

- (void)startAutoScroll:(NSTimeInterval)interval
{
    if(autoScrollTimer) {
        dispatch_source_cancel(autoScrollTimer);
    }
    autoScrollTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(autoScrollTimer, dispatch_time(DISPATCH_TIME_NOW, 5ull*NSEC_PER_SEC), 5ull*NSEC_PER_SEC , DISPATCH_TIME_FOREVER);
    dispatch_source_set_event_handler(autoScrollTimer, ^{
        [self scrollToNextPage];
    });
    dispatch_source_set_cancel_handler(autoScrollTimer, ^{
        NSLog(@"has been canceled");
    });
    dispatch_resume(autoScrollTimer);

    
}

- (void)resumeTimer
{
    if(autoScrollTimer) {
        [self startAutoScroll:5.0];
    }
}

- (void)stopAutoScroll
{
    if(autoScrollTimer) {
        dispatch_source_cancel(autoScrollTimer);
        autoScrollTimer = nil;
    }
}

- (void)scrollToNextPage
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width + self.bounds.size.width, 0) animated:YES];
    });
    
    
}

- (void)scrollAtIndex:(NSUInteger)index
{
    if(index > _curPage) {
        _curPage = index - 1;
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width + self.bounds.size.width, 0) animated:YES];
    }else{
        _curPage = index + 1;
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width - self.bounds.size.width, 0) animated:YES];
    }
    _curPage = [self validPageValue:_curPage];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    int x = aScrollView.contentOffset.x;
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    if([self.delegate respondsToSelector:@selector(didScrolltoPage:atIndex:)])
        [self.delegate didScrolltoPage:self atIndex:_curPage];
}

@end
