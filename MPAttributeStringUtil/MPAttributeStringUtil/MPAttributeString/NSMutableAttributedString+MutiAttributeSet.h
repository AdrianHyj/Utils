//
//  NSMutableAttributedString+MutiAttributeSet.h
//  MPAttributeStringUtil
//
//  Created by Jin on 14/12/17.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#pragma mark MPAttributeStringModel
@interface MPAttributeStringModel : NSObject
//default: @""
@property (nonatomic, strong) NSString *contentString;
//default: [UIFont systemFontOfSize:13.0f]
@property (nonatomic, strong) UIFont *font;
//default: [UIColor colorWithWhite:0.9 alpha:1]
@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

@end


#pragma mark - NSMutableAttributedString (MutiAttributeSet)
@interface NSMutableAttributedString (MutiAttributeSet)

#pragma mark initialization code
/**
 生成对应字体颜色的NSMutableAttributedString

 @param str 文字
 @param font 字体大小
 @param fontColor 颜色
 @return NSMutableAttributedString
 */
- (instancetype)initWithString:(NSString *)str font:(UIFont *)font fontColor:(UIColor *)fontColor;

/**
 生成对应字体、颜色、行距、布局方式等展现格式的NSMutableAttributedString

 @param str 文字
 @param font 字体大小
 @param fontColor 颜色
 @param lineSpacing 行距
 @param textAlignment 文字对齐方式
 @param style 一些文字属性，偏移，等属性。 (NSMutableParagraphStyle)
 @return NSMutableAttributedString
 */
- (instancetype)initWithString:(NSString *)str font:(UIFont *)font fontColor:(UIColor *)fontColor lineSpacing:(float)lineSpacing textAlignment:(NSTextAlignment)textAlignment otherStyleAttribute:(NSMutableParagraphStyle *)style;

/**
 生成对应字体颜色的NSMutableAttributedString
 每一个数组生成一段对应字体颜色AttributeString

 @param attrModels MPAttributeStringModel数组，每一个数组一段AttributeString，然后合并起来
 @return NSMutableAttributedString
 */
- (instancetype)initWithAttributeModels:(NSArray<MPAttributeStringModel *> *)attrModels;

#pragma mark set methods
- (NSMutableAttributedString *)appendString:(NSString *)str font:(UIFont *)font fontColor:(UIColor *)fontColor;
- (NSMutableAttributedString *)setlineSpacing:(float)lineSpacing textAlignment:(NSTextAlignment)textAlignment otherStyleAttribute:(NSMutableParagraphStyle *)style;

@end
