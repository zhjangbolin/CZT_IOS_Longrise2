//
//  CustomTextField.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/14.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
//自定义TextField  


//控制清除按钮的位置
//-(CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);
//}

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    
    return inset;
    
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

//控制左视图位置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
//    return inset;
//}

//控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    [[UIColororangeColor] setFill];
//    
//    [[selfplaceholder] drawInRect:rectwithFont:[UIFontsystemFontOfSize:20]];
//}
@end
