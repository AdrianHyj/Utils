#用法#

1.通过初始化方法生成一段字体大小，颜色的AttributeSting
```
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
```

2.通过appendString方法组合AttributeSting：
```
 _labelMiddle.numberOfLines = 0;
 _labelMiddle.attributedText = [topMString appendString:@"通过appendString方法组合AttributeSting"
                                                      font:[UIFont systemFontOfSize:11.0f]
                                                 fontColor:darkGrayColor];
```

3.通过模型数组生成不同样式的AttributeSting组合：

```
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
    
```
