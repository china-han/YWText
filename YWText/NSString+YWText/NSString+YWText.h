//
//  NSString+YWText.h
//  YWText
//
//  Created by hyw on 2017/12/1.
//  Copyright © 2017年 hyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (YWText)

/**
 *计算文字的宽高
 */
- (CGSize)zySizeWithFont:(UIFont * _Nonnull)strFont constrainedToSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode;
/**
 *是否包含空格
 */
- (BOOL)hasSpace;
/**
 *验证邮箱
 */
- (BOOL)isEmail;
/**
 *验证手机号
 */
- (BOOL)isPhoneNumber;
@end
