//
//  NSMutableAttributedString+MutiAttributeSet.m
//  MPAttributeStringUtil
//
//  Created by Jin on 14/12/17.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "NSMutableAttributedString+MutiAttributeSet.h"


#pragma mark MPAttributeStringModel
@implementation MPAttributeStringModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _contentString = @"";
        _font = [UIFont systemFontOfSize:13.0f];
        _color = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return self;
}

- (instancetype)initWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    self = [self init];
    if (self) {
        if (string && string.length > 0) {
            _contentString = string;
        }
        if (font) {
            _font = font;
        }
        if (color) {
            _color = color;
        }
    }
    return self;
}

- (void)setContentString:(NSString *)contentString {
    if (!contentString) {
        _contentString = @"";
    }
    _contentString = contentString;
}

@end

#pragma mark - NSMutableAttributedString (MutiAttributeSet)
@implementation NSMutableAttributedString (MutiAttributeSet)

#pragma mark initialization code
- (instancetype)initWithString:(NSString *)str font:(UIFont *)font fontColor:(UIColor *)fontColor {
    self = [self initWithString:str];
    if ([self notEmpty]) {
        [self addAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: fontColor} range:NSMakeRange(0, self.length)];
    }
    return self;
}

- (instancetype)initWithString:(NSString *)str font:(UIFont *)font fontColor:(UIColor *)fontColor lineSpacing:(float)lineSpacing textAlignment:(NSTextAlignment)textAlignment otherStyleAttribute:(NSMutableParagraphStyle *)style {
    self = [self initWithString:str font:font fontColor:fontColor];
    if ([self notEmpty]) {
        [self setlineSpacing:lineSpacing textAlignment:textAlignment otherStyleAttribute:style];
    }
    return self;
}

- (instancetype)initWithAttributeModels:(NSArray<MPAttributeStringModel *> *)attrModels {
    if (!attrModels || attrModels.count < 1) {
        return nil;
    }
    for (MPAttributeStringModel *stringModel in attrModels) {
        if (stringModel.contentString.length > 0) {
            if (![self notEmpty]) {
                self = [self initWithString:stringModel.contentString font:stringModel.font fontColor:stringModel.color];
            }
            else {
                [self appendString:stringModel.contentString font:stringModel.font fontColor:stringModel.color];
            }
        }
    }
    return self;
}

#pragma mark set methods
- (BOOL)notEmpty {
    return (self && self.length > 0);
}

- (NSMutableAttributedString *)setlineSpacing:(float)lineSpacing textAlignment:(NSTextAlignment)textAlignment otherStyleAttribute:(NSMutableParagraphStyle *)style {
    if ([self notEmpty]) {
        if (!style) {
            style = [[NSMutableParagraphStyle alloc] init];
        }
        style.lineSpacing = lineSpacing;//行距
        style.alignment = textAlignment;
        [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
    }
    return self;
}

- (NSMutableAttributedString *)appendString:(NSString *)str font:(UIFont *)font fontColor:(UIColor *)fontColor {
    if (!str || str.length < 1) {
        return self;
    }
    NSMutableAttributedString *appendAttrString = [[NSMutableAttributedString alloc] initWithString:str font:(UIFont *)font fontColor:fontColor];
    [self appendAttributedString:appendAttrString];
    return self;
}

@end
