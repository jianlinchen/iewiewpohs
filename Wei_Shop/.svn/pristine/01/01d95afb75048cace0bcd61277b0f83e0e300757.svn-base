//
//  XLCycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLCycleScrollViewDelegate;
@protocol XLCycleScrollViewDatasource;

@interface XLCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;

    
    NSInteger _totalPages;
    NSInteger _curPage;
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic, copy) dispatch_source_t   autoScrollTimer;

@property (nonatomic, assign) BOOL     addGesture;
@property (nonatomic,assign,setter = setDataource:) id<XLCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<XLCycleScrollViewDelegate> delegate;

- (void)resumeTimer;
- (void)setupUIControl;
- (void)startAutoScroll:(NSTimeInterval)interval;
- (void)stopAutoScroll;
- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
- (void)scrollAtIndex:(NSUInteger)index;
@end

@protocol XLCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index;
- (void)scollerToindex:(NSUInteger)index;
- (void)didScrolltoPage:(XLCycleScrollView *)csView atIndex:(NSUInteger)index;

@end

@protocol XLCycleScrollViewDatasource <NSObject>

@optional
- (BOOL)showBottomScrollLabel;
@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end
