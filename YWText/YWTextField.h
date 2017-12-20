//
//  YWTextField.h
//  YWText
//
//  Created by hyw on 2017/11/30.
//  Copyright © 2017年 hyw. All rights reserved.
//

//@interface ShowViewTool : NSObject
//
//@end

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,RockTextFieldViewType) {
    RockTextFieldViewTypeOriginalPassword = 1, //原密码
    RockTextFieldViewTypeNewPassword,          //新密码
    RockTextFieldViewTypeConfirmPassword,      //确认密码
    RockTextFieldViewTypeNewPhoneNumber,       //新的手机号
    RockTextFieldViewTypeContactPhoneNumber,   //联系电话
    RockTextFieldViewTypeEditEmail,            //邮箱
    RockTextFieldViewTypeLoginAccount,         //账号
    RockTextFieldViewTypeLoginPassword,        //登陆密码
    RockTextFieldViewTypeRegisterPhoneNumber,  //手机号
    RockTextFieldViewTypeRegisterVerifyCode,   //验证码
    RockTextFieldViewTypeRegisterPassword,     //密码
};

typedef void(^BeginEditingCompletion)(UITextField *textField);
typedef void(^EndEditingCompletion)(UITextField *textField);
typedef void(^TextChangeCompletion)();

@interface YWTextField : UIView
/** 提示 */
@property (nonatomic,strong) UILabel *titleLable;
/** 输入框 */
@property (nonatomic,strong) UITextField *mainTextFiled;
/** 开始编辑调用方法 */
@property (nonatomic,copy) BeginEditingCompletion beginEditingCompletion;
/** 输入改变时调用方法 */
@property (nonatomic,copy) TextChangeCompletion textChangeCompletion;
/** 结束编辑调用方法 */
@property (nonatomic,copy) EndEditingCompletion endEditingCompletion;

/** 最小密码位数，默认6位 */
@property (nonatomic,assign) NSInteger minPassWordNum;
/** 最大密码位数，默认20位 */
@property (nonatomic,assign) NSInteger maxPassWordNum;
/** 提示文字颜色，默认黑色 */
@property (nonatomic,strong) UIColor *titColor;
/** 输入文字颜色，默认黑色 */
@property (nonatomic,strong) UIColor *textfiledColor;
/** 是否展示下划线 默认展示 */
@property (nonatomic,assign) BOOL *isShowLine;
/** 下划线颜色 默认白色*/
@property (nonatomic,strong) UIColor *lineViewColor;

/** 位置设置 如果从新设置位置最好下面三个都从新设置，以视图超出界面*/
/** 文字的左边距离 */ 
@property (nonatomic,assign) CGFloat titLableLeft;
/** 文字的右边距离，即到textFiled的距离 */
@property (nonatomic,assign) CGFloat titLableRight;
/** textFiled到右边的距离 */
@property (nonatomic,assign) CGFloat textFieldRight;

/** 线的宽度 */
@property (nonatomic,assign) CGFloat lineViewWidth;

/** 是否校验自动数据格式 默认校验*/
@property (nonatomic,assign) BOOL isCheckContent;

/** 
 * 初始化
 */
- (instancetype)initWithFrame:(CGRect)frame type:(RockTextFieldViewType)aType;
/**
 * 校验数据格式
 */
- (void)checkContent;

/** 
 *根据类别创建
 */
+ (instancetype)getWithType:(RockTextFieldViewType)type;

@end
