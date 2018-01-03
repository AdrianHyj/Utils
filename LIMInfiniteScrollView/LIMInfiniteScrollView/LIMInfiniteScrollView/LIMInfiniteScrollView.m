//
//  LIMInfiniteScrollView.m
//  LIMInfiniteScrollView
//
//  Created by Jin on 2/1/18.
//  Copyright © 2018年 Jin. All rights reserved.
//

#import "LIMInfiniteScrollView.h"

@interface LIMInfiniteScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *containerView;
//出现的views
@property (nonatomic, strong) NSMutableArray *visibleViews;

@property (nonatomic, assign) NSInteger rightMostVisibleButtonIndex;
@property (nonatomic, assign) NSInteger leftMostVisibleButtonIndex;

/**
 *views之间的间隔
 */
@property (nonatomic, assign) CGFloat componentsSeparateWidth;
/**
 *需要循环展示的View
 *如果views加起来的宽度都不够 scrollview*2 的宽度的话，控件会不可拖动
 */
@property (nonatomic, strong) NSMutableArray<UIView *> *presentViews;

/**
 是否在滚动
 */
@property (nonatomic, assign) BOOL isScrolling;

@end


@implementation LIMInfiniteScrollView

#pragma mark - 初始化

- (instancetype)initWithViews:(NSArray *)views frame:(CGRect)frame seprateWidth:(CGFloat)seprateWidth {
    self = [self initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(5000, self.frame.size.height);
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        
        _containerView = [[UIView alloc] init];
        _containerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height/2);
        [self addSubview:_containerView];
        
        _visibleViews = [NSMutableArray new];
        
        if (views.count > 0) {
            [self resetPresentViews:views seprateWidth:seprateWidth];
        }
        else {
            _presentViews = [NSMutableArray new];
        }
        //初始化的时候先布置一下，让visibleView里面有东西
        [self layoutSubviews];
    }
    return self;
}

#pragma mark - 设置数据 记得在设置数据之后调用 [self setNeedsLayout];
- (void)resetPresentViews:(NSArray *)views seprateWidth:(CGFloat)seprateWidth {
    _presentViews = [NSMutableArray arrayWithArray:views];
    _componentsSeparateWidth = seprateWidth;
    
    [self resetViews];
    
    if (_presentViews.count > 0) {
        CGFloat x = 0;
        
        for (UIView *view in _presentViews) {
            x+= view.frame.size.width + _componentsSeparateWidth;
        }
        
        if (x < self.frame.size.width * 2) {
            self.scrollEnabled = NO;
            self.contentSize = CGSizeMake(self.frame.size.width, self.contentSize.height);
        }
        else {
            self.scrollEnabled = YES;
            self.contentSize = CGSizeMake(5000, self.contentSize.height);
        }
        _containerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height/2);
    }
    
    [self setNeedsLayout];
}

- (void)resetViews {
    for (UIView *view in _containerView.subviews) {
        [view removeFromSuperview];
    }
    _visibleViews = [NSMutableArray new];
}

- (void)scrollViewToMiddle:(UIView *)view {
    if (!self.scrollEnabled && view && !_isScrolling) {
        //如果因为待展现的views（_presentViews）不够宽度导致scrollview不滚动，这个方法不做任何事
        return;
    }
    
    NSUInteger index = [_presentViews indexOfObject:view];
    //找不到对应的view，则不做任何事
    if (index == NSNotFound) {
        return;
    }
    
    //先检测一下，当前显示的view中是否有目标view
    BOOL isSucceed = [self didFindAndScrollToViewInVisibleViews:view];
    //如果找不到，计算当前最右显示的view，找到对应的index判断应该翻滚多少距离offset
    if (!isSucceed) {
        [self findViewAndScrollToMiddle:view index:index];
    }
}

#pragma mark - layoutSubViews （记得[super layoutSubviews];）
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_presentViews.count > 0) {
        [self recenterIfNecessary];
        
        // tile content in visible bounds
        CGRect visibleBounds = [self convertRect:[self bounds] toView:_containerView];
        CGFloat minimumVisibleX = CGRectGetMinX(visibleBounds);
        CGFloat maximumVisibleX = CGRectGetMaxX(visibleBounds);
        [self viewsFromMinX:minimumVisibleX toMaxX:maximumVisibleX];
        
    }
}

#pragma mark - 代理
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isScrolling = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _isScrolling = NO;
}

#pragma mark - 其他
- (void)recenterIfNecessary {
    CGPoint curOffset = self.contentOffset;
    CGFloat contentWidth = self.contentSize.width;
    //可滚动的中心 左边是0 右边界是 （contentSize.width - width）
    CGFloat scrollWidthCenterX = (contentWidth - [self bounds].size.width)/2;
    //当前里滚动中心的距离
    CGFloat curDistanceFromCenter = fabs(curOffset.x - scrollWidthCenterX);
    //如果滚动超过contentsize.width/4的距离，重新定位到中间，其中的元素也要定位回去中间
    if (curDistanceFromCenter > contentWidth/4.0) {
        self.contentOffset = CGPointMake(scrollWidthCenterX, curOffset.y);
        for (UIView *view in _visibleViews) {
            CGPoint viewCenter = [_containerView convertPoint:view.center toView:self];
            viewCenter.x += (scrollWidthCenterX - curOffset.x);
            view.center = [self convertPoint:viewCenter toView:_containerView];
        }
    }
}

//布局右边的view
- (CGFloat)placeViewAtRightWithOriX:(CGFloat)oriX {
    _rightMostVisibleButtonIndex ++;
    if (_rightMostVisibleButtonIndex == _presentViews.count) {
        _rightMostVisibleButtonIndex = 0;
        [self nextRound];
    }
    
    UIView *view = _presentViews[_rightMostVisibleButtonIndex];
    if (view) {
        view.frame = CGRectMake(oriX, 0, view.frame.size.width, view.frame.size.height);
        [_visibleViews addObject:view];
        [_containerView addSubview:view];
        return CGRectGetMaxX(view.frame);
    }
    return oriX;
}

//布局左边的view
- (CGFloat)placeViewAtLeftWithOriX:(CGFloat)oriX {
    _leftMostVisibleButtonIndex--;
    if (_leftMostVisibleButtonIndex < 0) {
        _leftMostVisibleButtonIndex = _presentViews.count - 1;
    }
    
    UIView *view = _presentViews[_leftMostVisibleButtonIndex];
    if (view) {
        view.frame = CGRectMake(oriX - view.frame.size.width, 0, view.frame.size.width, view.frame.size.height);
        [_visibleViews insertObject:view atIndex:0];
        [_containerView addSubview:view];
        return CGRectGetMinX(view.frame);
    }
    return oriX;
}

- (void)viewsFromMinX:(CGFloat)minX toMaxX:(CGFloat)maxX {
    if (_visibleViews.count == 0) {
        _leftMostVisibleButtonIndex = 0;
        _rightMostVisibleButtonIndex = -1;
        [self placeViewAtRightWithOriX:minX];
    }
    
    //向右边填充
    UIView *lastView = [_visibleViews lastObject];
    CGFloat rightEdge = CGRectGetMaxX(lastView.frame);
    while (rightEdge < maxX) {
        rightEdge += _componentsSeparateWidth;
        rightEdge = [self placeViewAtRightWithOriX:rightEdge];
    }
    //向左边填充
    UIView *firstView = _visibleViews[0];
    CGFloat leftEdge = CGRectGetMinX(firstView.frame);
    while (leftEdge > minX) {
        leftEdge -= _componentsSeparateWidth;
        leftEdge = [self placeViewAtLeftWithOriX:leftEdge];
    }
    
    //清理右边过界的view
    lastView = [_visibleViews lastObject];
    while (CGRectGetMinX(lastView.frame) > maxX + _componentsSeparateWidth) {
        [lastView removeFromSuperview];
        [_visibleViews removeObject:lastView];
        lastView = [_visibleViews lastObject];
        
        _rightMostVisibleButtonIndex--;
        if (_rightMostVisibleButtonIndex < 0) {
            _rightMostVisibleButtonIndex = [_presentViews count] - 1;
            [self previousRound];
        }
    }
    //清理左边过界的view
    firstView = _visibleViews[0];
    while (CGRectGetMaxX(firstView.frame) < minX - _componentsSeparateWidth) {
        [firstView removeFromSuperview];
        [_visibleViews removeObject:firstView];
        firstView = _visibleViews[0];
        
        _leftMostVisibleButtonIndex++;
        if (_leftMostVisibleButtonIndex == [_presentViews count]) {
            _leftMostVisibleButtonIndex = 0;
        }
    }
}

//寻找当前显示的views（_visibleViews），如果有，则直接中间
- (BOOL)didFindAndScrollToViewInVisibleViews:(UIView *)view {
    for (UIView *visibleView in _visibleViews) {
        //如果找到匹配的
        if (view == visibleView) {
            //可滚动的中心
            CGFloat curSrollX = self.contentOffset.x + [self bounds].size.width/2;
            //view在scrollview的转换中心点
            CGPoint viewCenterAtScroll = [_containerView convertPoint:visibleView.center toView:self];
            //目标view的中心距离滚动中心的距离
            CGFloat viewDistanceFromCenter = viewCenterAtScroll.x - curSrollX;
            [self scrollRectToVisible:CGRectMake(self.contentOffset.x + viewDistanceFromCenter, self.contentOffset.y, self.bounds.size.width,self.bounds.size.height) animated:YES];
            return YES;
        }
    }
    return NO;
}

//寻找当前显示的views（_visibleViews）的最右边一个，按照index计算目标view的坐标，使scrollview滚动
- (void)findViewAndScrollToMiddle:(UIView *)view index:(NSUInteger)index {
    //显示的最右边的view
    UIView *rightView = [_visibleViews lastObject];
    if (rightView) {
        //可滚动的中心
        CGFloat curSrollX = self.contentOffset.x + [self bounds].size.width/2;
        //显示的最右边的View在scrollview的转换中心点
        CGPoint rightViewCenterAtScroll = [_containerView convertPoint:rightView.center toView:self];
        //目标view的中心距离滚动中心的距离
        CGFloat viewDistanceFromCenter = rightViewCenterAtScroll.x - curSrollX;
        
        CGFloat offsetNeedToScroll = ((NSInteger)index - _rightMostVisibleButtonIndex)*_componentsSeparateWidth;
        if (index < _rightMostVisibleButtonIndex) {
            //向左边滚动
            for (NSInteger i = (NSInteger)index + 1; i < _rightMostVisibleButtonIndex; i++) {
                UIView *countView = _presentViews[i];
                if (countView) {
                    offsetNeedToScroll -= countView.frame.size.width;
                }
            }
            offsetNeedToScroll -= _presentViews[index].frame.size.width/2;
            offsetNeedToScroll -= _presentViews[_rightMostVisibleButtonIndex].frame.size.width/2;
        }
        else {
            //向右边滚动
            for (NSInteger i = _rightMostVisibleButtonIndex + 1; i < (int)index; i++) {
                UIView *countView = _presentViews[i];
                if (countView) {
                    offsetNeedToScroll += countView.frame.size.width;
                }
            }
            offsetNeedToScroll += _presentViews[index].frame.size.width/2;
            offsetNeedToScroll += _presentViews[_rightMostVisibleButtonIndex].frame.size.width/2;
        }
        [self scrollRectToVisible:CGRectMake(self.contentOffset.x + viewDistanceFromCenter + offsetNeedToScroll, self.contentOffset.y, self.bounds.size.width,self.bounds.size.height) animated:YES];
    }
}

- (void)previousRound {
    //前一个循环
    if (!self.scrollEnabled) {
        //如果是不能滚动的。就不调用了
        return;
    }
    if (self.infiniteScrollDelegate && [self.infiniteScrollDelegate respondsToSelector:@selector(infiniteScrollViewDidScrollToPreRound:)]) {
        [self.infiniteScrollDelegate infiniteScrollViewDidScrollToPreRound:self];
    }
}

- (void)nextRound {
    //下一个循环
    if (!self.scrollEnabled) {
        //如果是不能滚动的。就不调用了
        return;
    }
    if (self.infiniteScrollDelegate && [self.infiniteScrollDelegate respondsToSelector:@selector(infiniteScrollViewDidScrollToNextRound:)]) {
        [self.infiniteScrollDelegate infiniteScrollViewDidScrollToNextRound:self];
    }
}

@end
