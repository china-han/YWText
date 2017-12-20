//
//  ViewController.m
//  YWTextDemo
//
//  Created by hyw on 2017/12/20.
//  Copyright © 2017年 hyw. All rights reserved.
//

#import "ViewController.h"
#import "YWTextField.h"
#import "UIView+ext.h"
/** 屏幕尺寸参数 */
#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
@interface ViewController ()

@end

@implementation ViewController
{
    UIColor *backGroundColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    backGroundColor = [UIColor redColor];
    //    self.view.backgroundColor = backGroundColor;
    YWTextField *textField = [[YWTextField alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeLoginAccount];
    textField.lineViewColor = [UIColor redColor];
    //    textField.textfiledColor = [UIColor blueColor];
    //    textField.titColor = [UIColor redColor];
    //    textField.titLableLeft = 60;
    //    textField.titLableRight =  50;
    //    textField.textFieldRight = 20;
    //     textField.lineViewWidth = 200;
    YWTextField *textField1 = [[YWTextField alloc]initWithFrame:CGRectMake(0, textField.mj_maxY+20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeRegisterPassword];
    textField1.lineViewColor = [UIColor blackColor];
    
    YWTextField *textField2 = [[YWTextField alloc]initWithFrame:CGRectMake(0, textField1.mj_maxY+20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeContactPhoneNumber];
    textField2.lineViewColor = [UIColor yellowColor];
    
    YWTextField *textField3 = [[YWTextField alloc]initWithFrame:CGRectMake(0, textField2.mj_maxY+20, SCREEN_WIDTH, 40) type:RockTextFieldViewTypeConfirmPassword];
    textField3.lineViewColor = [UIColor blueColor];
    
    
    [self.view addSubview:textField];
    [self.view addSubview:textField1];
    [self.view addSubview:textField2];
    [self.view addSubview:textField3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
