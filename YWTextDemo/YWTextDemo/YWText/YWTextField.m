//
//  YWTextField.m
//  YWText
//
//  Created by hyw on 2017/11/30.
//  Copyright © 2017年 hyw. All rights reserved.
//


#import "YWTextField.h"
#import "MBProgressHUD.h"
#define   msg(m)     [ShowViewTool MBProgressHUD:m Time:2]
@interface ShowViewTool : NSObject

@end
@implementation ShowViewTool

//提示:
+ (void)MBProgressHUD:(NSString *)text Time:(NSUInteger)time{
    UIView *view = [[UIApplication sharedApplication] windows].lastObject;
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.label.text = text;
    HUD.mode = MBProgressHUDModeText;
    
    [HUD showAnimated:YES];
  
    HUD.removeFromSuperViewOnHide = YES;
//    [HUD hide:NO afterDelay:showTime];
    [HUD hideAnimated:NO afterDelay:time];
   

  }
@end

#import "UIView+ext.h"
#import "NSString+YWText.h"


/** 屏幕尺寸参数 */
#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define Fix375 (SCREEN_WIDTH/ 375.0)/**当前设备对应375的比例*/
#define GBFix375(x)  ((int)((x) * Fix375))
/** 调色 */
#define RGB(r, g, b)	 [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]
/** 默认颜色 */
#define COMMON_DEFAULT_COLOR  RGB(59, 53, 65)
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

//密码最小位数8位
#define MIN_PASSWORD_COUNT 6
//密码最大位数20位
#define MAX_PASSWORD_COUNT 20
//验证码位数
#define CODE_COUNT   6

@interface YWTextField ()<UITextFieldDelegate>
@property (nonatomic,assign) RockTextFieldViewType type;
/** 线 */
@property (nonatomic,strong) UIView *lineView;
@end
@implementation YWTextField

- (instancetype)initWithFrame:(CGRect)frame type:(RockTextFieldViewType)aType{
    if ([super initWithFrame:frame]) {
        self.type = aType;
        self.isCheckContent = YES;
        [self setMianView];
    }
    return self;
}

+ (instancetype)getWithType:(RockTextFieldViewType)type{
    YWTextField *textField = [[self alloc]init];
    textField.type = type;
    textField.isCheckContent = YES;
    [textField setMianView];
    return textField;
}

+ (instancetype)getWihtTitleText:(NSString *)title placeholderTitle:(NSString *)placeholder withFrame:(CGRect)frame{
    YWTextField *textField = [[self alloc]init];
    textField.frame = frame;
    textField.type = RockTextFieldViewTypeDefault;
    textField.isCheckContent = YES;
    [textField extracted:title placeholder:placeholder];
    return textField;
}

- (void)extracted:(NSString *)mainTitle placeholder:(NSString *)placeholder {
    CGSize titleSize = [mainTitle zySizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(CGFLOAT_MAX, self.height) lineBreakMode:1];
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 0, titleSize.width, self.height)];
    self.titleLable.font = [UIFont systemFontOfSize:15];
    self.titleLable.textAlignment = NSTextAlignmentLeft;
    self.titleLable.textColor = COMMON_DEFAULT_COLOR;
    self.titleLable.text = mainTitle;
    
    
    if (self.type == RockTextFieldViewTypeRegisterVerifyCode) {
        self.mainTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(self.titleLable.mj_maxX + GBFix375(30), 0, self.width-self.titleLable.width - GBFix375(160), self.height)];
    }else{
        self.mainTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(self.titleLable.mj_maxX + GBFix375(20), 0, self.width-self.titleLable.width - GBFix375(80), self.height)];
    }
    
    if (self.type == RockTextFieldViewTypeNewPassword ||
        self.type ==RockTextFieldViewTypeOriginalPassword ||
        self.type ==RockTextFieldViewTypeLoginPassword ||
        self.type ==RockTextFieldViewTypeRegisterPassword ||
        self.type ==RockTextFieldViewTypeConfirmPassword) {
        self.mainTextFiled.keyboardType =UIKeyboardTypeASCIICapable;
        self.mainTextFiled.secureTextEntry = YES;
        self.mainTextFiled.delegate = self;
    }else if (self.type == RockTextFieldViewTypeEditEmail){
        self.mainTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
        self.mainTextFiled.secureTextEntry = NO;
    }else{
        self.mainTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        self.mainTextFiled.secureTextEntry = NO;
        self.mainTextFiled.delegate = self;
    }
    self.mainTextFiled.borderStyle = UITextBorderStyleNone;
    self.mainTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.mainTextFiled.font = [UIFont systemFontOfSize:15];
    self.mainTextFiled.textAlignment = NSTextAlignmentLeft;
    self.mainTextFiled.textColor = COMMON_DEFAULT_COLOR;
    self.mainTextFiled.placeholder = placeholder;
    
    [self addSubview:self.lineView];
    [self addSubview:self.titleLable];
    [self addSubview:self.mainTextFiled];
}

- (void)setMianView{
    self.backgroundColor = [UIColor whiteColor];
    NSString *mainTitle = @"";
    NSString *placeholder = @"";
    
    if (self.type == RockTextFieldViewTypeOriginalPassword) {
        mainTitle = @"旧密码";
        placeholder = @"请输入旧密码";
        
        
    }else if (self.type == RockTextFieldViewTypeNewPassword){
        
        mainTitle = @"新密码";
        placeholder = @"请输入6-20位密码";
        
    } else if (self.type == RockTextFieldViewTypeConfirmPassword) {
        
        mainTitle = @"确认密码";
        placeholder = @"请输入确认密码";
        
    } else if (self.type == RockTextFieldViewTypeNewPhoneNumber){
        
        mainTitle = @"手机号码";
        placeholder = @"请输入手机号码";
        
    } else if (self.type == RockTextFieldViewTypeContactPhoneNumber) {
        
        mainTitle = @"联系电话";
        placeholder = @"选填，便于我们联系你";
        
    } else if (self.type == RockTextFieldViewTypeEditEmail) {
        
        mainTitle = @"邮箱";
        placeholder = @"请输入您的邮箱";
        
    } else if (self.type == RockTextFieldViewTypeLoginAccount) {
        
        mainTitle = @"账号";
        placeholder = @"请输入手机号";
        
    } else if (self.type == RockTextFieldViewTypeLoginPassword) {
        
        mainTitle = @"密码";
        placeholder = @"请输入登录密码";
        
    }else if (self.type == RockTextFieldViewTypeRegisterPhoneNumber) {
        
        mainTitle = @"手机号";
        placeholder = @"输入手机号";
        
    }else if (self.type == RockTextFieldViewTypeRegisterVerifyCode) {
        
        mainTitle = @"验证码";
        placeholder = @"输入验证码";
        
    }else if (self.type == RockTextFieldViewTypeRegisterPassword) {
        
        mainTitle = @"密码";
        placeholder = @"请输入6-20位密码";
        
    }
            
    [self extracted:mainTitle placeholder:placeholder];
    
    
}

- (BOOL)totalCheck{
    
    if ([self.mainTextFiled.text hasSpace]) {
        
        switch (self.type) {
            case RockTextFieldViewTypeOriginalPassword:
            {
                
                msg(@"旧密码不能含有空格");
            }
                break;
            case RockTextFieldViewTypeNewPassword:
            {
                msg(@"新密码不能含有空格");
            }
                break;
            case RockTextFieldViewTypeConfirmPassword:
            {
                msg(@"新密码不能含有空格");
            }
                break;
            case RockTextFieldViewTypeNewPhoneNumber:
            {
                msg(@"手机号码不能含有空格");
            }
                break;
            case RockTextFieldViewTypeLoginAccount:
            {
                msg(@"手机号不能含有空格");
            }
                break;
            case RockTextFieldViewTypeLoginPassword:
            {
                msg(@"密码不能含有空格");
            }
                break;
            case RockTextFieldViewTypeRegisterPhoneNumber:
            {
                msg(@"手机号码不能有空格");
            }
                break;
            case RockTextFieldViewTypeRegisterVerifyCode:
            {
                msg(@"验证码不能有空格");
            }
                break;
            case RockTextFieldViewTypeRegisterPassword:
            {
                msg(@"密码不能有空格");
            }
                break;
            default:
                break;
        }
        
        return NO;
    }else
    {
        if (self.type == RockTextFieldViewTypeOriginalPassword) {
            
            if ([self.mainTextFiled.text length] < self.minPassWordNum || [self.mainTextFiled.text length] > self.maxPassWordNum) {
                NSString *mas = [NSString stringWithFormat:@"请输入%ld-%ld位旧密码",self.minPassWordNum,self.maxPassWordNum];
                msg(mas);
                
                return NO;
            }
            
        }else if (self.type == RockTextFieldViewTypeNewPassword ||
                  self.type == RockTextFieldViewTypeRegisterPassword){
            
            if ([self.mainTextFiled.text length] < self.minPassWordNum || [self.mainTextFiled.text length] > self.maxPassWordNum) {
                NSString *mas = [NSString stringWithFormat:@"请输入%ld-%ld位新密码",self.minPassWordNum,self.maxPassWordNum];
                msg(mas);
                
                return NO;
            }
            
        }else if (self.type == RockTextFieldViewTypeNewPhoneNumber ||
                  self.type == RockTextFieldViewTypeRegisterPhoneNumber ||
                  self.type == RockTextFieldViewTypeLoginAccount){
            
            if (![self.mainTextFiled.text isPhoneNumber]) {
                
                msg(@"请输入正确格式手机号码");
                
                return NO;
            }
        }else if (self.type == RockTextFieldViewTypeRegisterVerifyCode) {
            
            if ([self.mainTextFiled.text length] > CODE_COUNT) {
                
                msg(@"请输入正确格式的验证码");
                
                return NO;
            }
        }else if (self.type == RockTextFieldViewTypeRegisterPassword ||
                  self.type == RockTextFieldViewTypeLoginPassword
                  ){
            if ([self.mainTextFiled.text length] < self.minPassWordNum || [self.mainTextFiled.text length] > self.maxPassWordNum) {
                NSString *mas = [NSString stringWithFormat:@"请输入%ld-%ld位密码",self.minPassWordNum,self.maxPassWordNum];
                msg(mas);
                
                return NO;
             }
        }else if (self.type == RockTextFieldViewTypeEditEmail){
            if (![self.mainTextFiled.text isEmail]) {
                msg(@"请输入正确格式邮箱");
                
                return NO;
            }
        }else if (self.type == RockTextFieldViewTypeContactPhoneNumber){
            msg(@"请输入正确格式联系电话");
            
            return NO;
        }
    }
    
    return YES;
}

/**
 * textField delegate
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.beginEditingCompletion) {
        self.beginEditingCompletion(textField);
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.endEditingCompletion) {
        self.endEditingCompletion(textField);
    }else{
        if (self.isCheckContent) {
            [self checkContent];
        }
    }
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //只允许输入大小写字母和数字
    // invertedSet方法是取反字符。所以cs的值为:除了ALPHANUM里的字符,其余的任何字符都是cs
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
        // 将str按cs分割成数组(既然能分割,说明cs是str的子集,并且cs中的字符不会在str中出现,相当于str中删除了这些字符),最后将数组按照@""分割成字符串
     NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
     return [string isEqualToString:filtered];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.mainTextFiled resignFirstResponder];
     return YES;
}

- (void)textChange:(NSNotification *)notify{
    if (self.textChangeCompletion) {
        self.textChangeCompletion();
    }
    
}

#pragma mark -- 输入结束校验
- (void)checkContent{
    
    [self totalCheck];
}
#pragma mark - set方法设置数据

- (void)setTitColor:(UIColor *)titColor{
    _titColor = titColor;
    self.titleLable.textColor = titColor;
}

- (void)setTextfiledColor:(UIColor *)textfiledColor{
    _textfiledColor = textfiledColor;
    self.mainTextFiled.textColor = textfiledColor;
}

- (void)setIsShowLine:(BOOL *)isShowLine{
    _isShowLine = isShowLine;
    self.lineView.hidden = !isShowLine;
}

- (void)setLineViewColor:(UIColor *)lineViewColor{
    _lineViewColor = lineViewColor;
    self.lineView.backgroundColor = lineViewColor;
}

- (void)setTitLableLeft:(CGFloat)titLableLeft{
    _titLableLeft = titLableLeft;
    self.titleLable.mj_x = titLableLeft;
}

- (void)setTitLableRight:(CGFloat)titLableRight{
    _titLableRight = titLableRight;
    self.mainTextFiled.mj_x = self.titleLable.mj_maxX+titLableRight;
}

- (void)setTextFieldRight:(CGFloat)textFieldRight{
    _textFieldRight = textFieldRight;
    self.mainTextFiled.width = SCREEN_WIDTH - self.mainTextFiled.mj_x - textFieldRight;
}

- (void)setLineViewWidth:(CGFloat)lineViewWidth{
    _lineViewWidth = lineViewWidth;
    self.lineView.mj_x = (SCREEN_WIDTH-lineViewWidth)/2;
    self.lineView.mj_w = lineViewWidth;
}
#pragma mark - 懒加载数据
- (NSInteger)minPassWordNum{
    if (!_minPassWordNum) {
        _minPassWordNum = MIN_PASSWORD_COUNT;
    }
    return _minPassWordNum;
}

- (NSInteger)maxPassWordNum{
    if (!_maxPassWordNum) {
        _maxPassWordNum = MAX_PASSWORD_COUNT;
    }
    return MAX_PASSWORD_COUNT;
}

- (UIView *)lineView{
    if (!_lineView ) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(GBFix375(20), self.height, SCREEN_WIDTH-GBFix375(40), 1)];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

@end




