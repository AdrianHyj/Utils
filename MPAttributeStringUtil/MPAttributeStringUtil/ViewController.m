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
    NSMutableAttributedString *topMString = [[NSMutableAttributedString alloc] initWithString:@"通过初始化方法生成一段字体大小，颜色的AttributeSting"
                                                                                         font:font13
                                                                                    fontColor:blueColor
                                                                                  lineSpacing:5.0
                                                                                textAlignment:NSTextAlignmentLeft
                                                                          otherStyleAttribute:style];
    _labelTop.numberOfLines = 0;
    _labelTop.attributedText = topMString;
    
    _labelMiddle.numberOfLines = 0;
    _labelMiddle.attributedText = [topMString appendString:@"通过appendString方法组合AttributeSting"
                                                      font:[UIFont systemFontOfSize:11.0f]
                                                 fontColor:darkGrayColor];
    
    MPAttributeStringModel *part1 = [[MPAttributeStringModel alloc] init];
    part1.contentString = @"第一段文字";
    part1.color = purpleColor;
    
    MPAttributeStringModel *part2 = [[MPAttributeStringModel alloc] init];
    part2.contentString = @"\n第二段文字：";
    part2.color = darkGrayColor;
    part2.font = [UIFont systemFontOfSize:17.0];
    
    MPAttributeStringModel *part3 = [[MPAttributeStringModel alloc] initWithString:@"第三段描述文字 ..."
                                                                              font:[UIFont systemFontOfSize:10.0]
                                                                             color:greenColor];
    
    _labelBottom.numberOfLines = 0;
    _labelBottom.attributedText = [[NSMutableAttributedString alloc] initWithAttributeModels:@[part1,part2,part3]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
