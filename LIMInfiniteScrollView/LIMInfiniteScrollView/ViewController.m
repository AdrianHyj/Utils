//
//  ViewController.m
//  LIMInfiniteScrollView
//
//  Created by Jin on 2/1/18.
//  Copyright © 2018年 Jin. All rights reserved.
//

#import "ViewController.h"
#import "LIMInfiniteScrollView.h"

@interface ViewController () <LIMInfiniteScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *views1;
@property (nonatomic, strong) NSMutableArray *views2;

@property (nonatomic, strong) LIMInfiniteScrollView *scrollView1;
@property (nonatomic, strong) LIMInfiniteScrollView *scrollView2;

@property (nonatomic, assign) int roundCount1;
@property (nonatomic, strong) UILabel *roundLabel1;
@property (nonatomic, assign) int roundCount2;
@property (nonatomic, strong) UILabel *roundLabel2;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _views1 = [NSMutableArray new];
    for (int i = 0; i < 5; i ++) {
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
        [_views1 addObject:countLabel];
    }
    
    _scrollView1 = [[LIMInfiniteScrollView alloc] initWithViews:_views1 frame:CGRectMake(0, (self.view.frame.size.height - 50)/2 - 100, self.view.frame.size.width, 50) seprateWidth:0];
    _scrollView1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    _scrollView1.infiniteScrollDelegate = self;
    
    _roundLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView1.frame) + 10, self.view.frame.size.width/2, 44.0)];
    _roundLabel1.font = [UIFont systemFontOfSize:13.0f];
    _roundLabel1.textColor = [UIColor darkGrayColor];
    _roundLabel1.textAlignment = NSTextAlignmentCenter;
    [self refreshRoundLabel1];
    
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_roundLabel1.frame), CGRectGetMinY(_roundLabel1.frame), _roundLabel1.frame.size.width, _roundLabel1.frame.size.height)];
    _button1.backgroundColor = [UIColor lightGrayColor];
    [_button1 setTitle:@"跳转到。" forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(didPressButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: _roundLabel1];
    [self.view addSubview: _scrollView1];
    [self.view addSubview: _button1];

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
    
    _scrollView2 = [[LIMInfiniteScrollView alloc] initWithViews:_views2 frame:CGRectMake(0, CGRectGetMaxY(_roundLabel1.frame) + 20, self.view.frame.size.width, 50) seprateWidth:0];
    _scrollView2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    _scrollView2.infiniteScrollDelegate = self;
    
    _roundLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView2.frame) + 10, self.view.frame.size.width/2, 44.0)];
    _roundLabel2.font = [UIFont systemFontOfSize:13.0f];
    _roundLabel2.textColor = [UIColor darkGrayColor];
    _roundLabel2.textAlignment = NSTextAlignmentCenter;
    [self refreshRoundLabel2];
    
    _button2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_roundLabel2.frame), CGRectGetMinY(_roundLabel2.frame), _roundLabel2.frame.size.width, _roundLabel2.frame.size.height)];
    _button2.backgroundColor = [UIColor lightGrayColor];
    [_button2 setTitle:@"跳转到。" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_button2 addTarget:self action:@selector(didPressButton2:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: _roundLabel2];
    [self.view addSubview: _scrollView2];
    [self.view addSubview: _button2];
}

- (void)setRoundCount1:(int)roundCount1 {
    _roundCount1 = roundCount1;
    [self refreshRoundLabel1];
}

- (void)setRoundCount2:(int)roundCount2 {
    _roundCount2 = roundCount2;
    [self refreshRoundLabel2];
}

- (void)refreshRoundLabel1 {
    _roundLabel1.text = [NSString stringWithFormat:@"第 %d round.",_roundCount2];
}
- (void)refreshRoundLabel2 {
    _roundLabel2.text = [NSString stringWithFormat:@"第 %d round.",_roundCount2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didPressButton1:(UIButton *)button {
    [_scrollView1 scrollViewToMiddle:_views1[_views1.count/2]];
}

- (void)didPressButton2:(UIButton *)button {
    [_scrollView2 scrollViewToMiddle:_views2[_views2.count/2]];
}

#pragma mark - LIMInfiniteScrollViewDelegate
- (void)infiniteScrollViewDidScrollToPreRound:(LIMInfiniteScrollView *)scrollview {
    if (scrollview == _scrollView1) {
        self.roundCount1 -= 1;
    }
    else {
        self.roundCount2 -= 1;
    }
}

- (void)infiniteScrollViewDidScrollToNextRound:(LIMInfiniteScrollView *)scrollview {
    if (scrollview == _scrollView1) {
        self.roundCount1 += 1;
    }
    else {
        self.roundCount2 += 1;
    }
}


@end
