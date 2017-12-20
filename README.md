# HYText
一款简易的注册登陆用textfield,可以一行代码搞定注册登陆，支持样式调整，支持自动或手动校验手机，邮箱密码等

只需要一行代码即可构建登陆的按钮和输入框
------------------------------------
`首先`把TWText拉到自己的项目中
`其次`导入头文件

``` Objict-C
#import "YWTextField.h"
```

`然后`在自己需要的地方一行代码显示相要的内容

``` Objict-C
  YWTextField *textField = [[YWTextField alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeLoginAccount];
```
`其次`改框架支持自己改变位置，以及自己决定是否自动校验等效果

`最后`附上简单的代码及效果

``` Objict-C
YWTextField *textField = [[YWTextField alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeLoginAccount];
textField.lineViewColor = [UIColor redColor];
//    textField.textfiledColor = [UIColor blueColor];
//    textField.titColor = [UIColor redColor];
//    textField.titLableLeft = 60;
//    textField.titLableRight =  50;
//    textField.textFieldRight = 20;
//     textField.lineViewWidth = 200;
YWTextField *textField1 = [[YWTextField alloc]initWithFrame:CGRectMake(0, textField.mj_maxY+20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeRegisterPassword];
textField.lineViewColor = [UIColor blackColor];

YWTextField *textField2 = [[YWTextField alloc]initWithFrame:CGRectMake(0, textField1.mj_maxY+20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeContactPhoneNumber];
textField.lineViewColor = [UIColor yellowColor];

YWTextField *textField3 = [[YWTextField alloc]initWithFrame:CGRectMake(0, textField2.mj_maxY+20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeConfirmPassword];
textField.lineViewColor = [UIColor blueColor];


[self.view addSubview:textField];
[self.view addSubview:textField1];
[self.view addSubview:textField2];
[self.view addSubview:textField3];
```
效果
---
![](https://github.com/china-han/YWText/raw/master/Snip20171220_1.png) 


