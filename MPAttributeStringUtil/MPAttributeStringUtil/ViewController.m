//
//  ViewController.m
//  MPAttributeStringUtil
//
//  Created by Jin on 14/12/17.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableAttributedString+MutiAttributeSet.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelTop;
@property (weak, nonatomic) IBOutlet UILabel *labelMiddle;
@property (weak, nonatomic) IBOutlet UILabel *labelBottom;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIFont *font13 = [UIFont systemFontOfSize:13.0f];
    UIColor *purpleColor = [UIColor purpleColor];
    UIColor *blueColor = [UIColor blueColor];
    UIColor *darkGrayColor = [UIColor darkGrayColor];
    UIColor *greenColor = [UIColor greenColor];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = 10.0;
    _labelTop.attributedText = [[NSMutableAttributedString alloc] initWithString:@"梁富华是傻逼。\n没错，你说的没错。" font:font13 fontColor:blueColor lineSpacing:5.0 textAlignment:NSTextAlignmentLeft otherStyleAttribute:style];
    _labelTop.numberOfLines = 0;
    
    MPAttributeStringModel *part1 = [[MPAttributeStringModel alloc] init];
    part1.contentString = @"";
    part1.color = purpleColor;
    
    MPAttributeStringModel *part2 = [[MPAttributeStringModel alloc] init];
    part2.contentString = @"\n猜猜我是谁。";
    part2.color = darkGrayColor;
    part2.font = [UIFont systemFontOfSize:17.0];
    
    MPAttributeStringModel *part3 = [[MPAttributeStringModel alloc] initWithString:@"我才不猜。2016年3月22日 - modifier参数将imageView放置在父视图尺寸的某个百分比的位置上，如下所示: 2016-01-24-002.png. 寓教于乐。这里有三种方式来创建该布局，第一是使用IB, 第二是用代码添加约束，第三是使用stack view. 使用Interface Builder创建约束. 对每个image view 我们需要添加两个约束。使用文档大纲工具栏或者直接在 ..." font:[UIFont systemFontOfSize:10.0] color:greenColor];
    
    _labelMiddle.attributedText = [[NSMutableAttributedString alloc] initWithAttributeModels:@[part1,part2,part3]];
    _labelMiddle.numberOfLines = 0;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
