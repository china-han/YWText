//
//  UIView+ext.h
//  WECAST
//
//  Created by 张芳涛 on 2016/11/20.
//  Copyright © 2016年 张芳涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ext)
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat left;
@property(nonatomic,assign)CGFloat right;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign)CGFloat top;
@property(nonatomic,assign)CGFloat bottom;



@property (assign, nonatomic) CGFloat mj_x;
@property (assign, nonatomic) CGFloat mj_y;
@property (assign, nonatomic) CGFloat mj_w;
@property (assign, nonatomic) CGFloat mj_h;
@property (assign, nonatomic) CGSize mj_size;
@property (assign, nonatomic) CGPoint mj_origin;
@property (assign, nonatomic) CGFloat mj_maxY;
@property (assign, nonatomic) CGFloat mj_maxX;


-(void)roundRect;
-(void)roundRect:(int)radius;
-(void)seporatorBar;
/**
 *  扩充按钮的可点击区域
 *
 *  @param top    在button的frame的基础上往上扩充的距离
 *  @param right  在button的frame的基础上往右扩充的距离
 *  @param bottom 在button的frame的基础上往下扩充的距离
 *  @param left   在button的frame的基础上往左扩充的距离
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
