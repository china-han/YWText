# HYText
一款简易的注册登陆用textfield,可以一行代码搞定注册登陆，支持样式调整，支持自动或手动校验手机，邮箱密码等

只需要一行代码即可构建登陆的按钮和输入框
首先导入把YWText拉到自己的项目中
其次导入头文件
#import "YWTextField.h"
然后在自己需要的地方一行代码显示相要的内容

YWTextField *textField = [[YWTextField alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeLoginAccount];

