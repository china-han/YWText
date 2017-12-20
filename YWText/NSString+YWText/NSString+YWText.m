//
//  NSString+YWText.m
//  YWText
//
//  Created by hyw on 2017/12/1.
//  Copyright © 2017年 hyw. All rights reserved.
//

#import "NSString+YWText.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YWText)

- (CGSize)zySizeWithFont:(UIFont *)strFont constrainedToSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize size = CGSizeMake(0.0, 0.0);
    if (!self) {
        return size;
    }
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 1.0;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    //    [style setLineSpacing:AutoSize(14)];
    [style setLineSpacing:9];
    size = [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{ NSFontAttributeName : strFont ,
                                         NSParagraphStyleAttributeName: style }
                              context:context].size;
    return size;
}

#pragma mark -- 是否包含空格
- (BOOL)hasSpace{
    
    NSRange spaceRange = [self rangeOfString:@" "];
    if (spaceRange.location != NSNotFound) {
        
        return YES;
    }
    else {
        
        return NO;
    }
}

#pragma mark - 验证邮箱
- (BOOL)isEmail {
    return [NSString isEmail:self];
}

+ (BOOL)isEmail:(NSString *_Nonnull)email {
    NSString *emailRegEx = @"^[a-zA-Z0-9.!#$%&'*+/"
    @"=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-"
    @"Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-"
    @"Z0-9])?)*$";
    
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

#pragma mark -- 正则判断电话号码
- (BOOL)isPhoneNumber
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

@end
