**用法**

1.新建需要循环的views的数组
```
_views2 = [NSMutableArray new];
for (int i = 0; i < 12; i ++) {
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/5, 44.0)];
    countLabel.font = [UIFont systemFontOfSize:13.0f];
    countLabel.textColor = [UIColor darkGrayColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    if (i%2) {
        countLabel.backgroundColor = [UIColor yellowColor];
    }
    else {
        countLabel.backgroundColor = [UIColor greenColor];
    }
    countLabel.text = [NSString stringWithFormat:@"第%d个",i+1];
    [_views2 addObject:countLabel];
}
```

2.初始化无限循环scrollview
```
_scrollView2 = [[LIMInfiniteScrollView alloc] initWithViews:_views2 frame:CGRectMake(0, CGRectGetMaxY(_roundLabel1.frame) + 20, self.view.frame.size.width, 50) seprateWidth:0];
_scrollView2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
_scrollView2.infiniteScrollDelegate = self;
    
```

**Delegate**
```
//下一个循环
- (void)infiniteScrollViewDidScrollToNextRound:(LIMInfiniteScrollView *)scrollview;
//上一个循环
- (void)infiniteScrollViewDidScrollToPreRound:(LIMInfiniteScrollView *)scrollview;
```
