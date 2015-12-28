//
//  PJRSignatureView.m
//  qianming
//
//  Created by 张博林 on 15/11/30.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import "PJRSignatureView.h"

#define INITIAL_COLOR [UIColor blackColor]; // 签名颜色
#define FINAL_COLOR [UIColor blackColor];  //结束签名后的颜色
#define INITIAL_LABEL_TEXT @"请在此区域签名";

@implementation PJRSignatureView{
    UIBezierPath *beizerPath; //二次贝塞尔曲线
    UIImage *incrImage;  //绘制完后的签名
    CGPoint points[5];
    uint control;
}

// Create a View which contains Signature Label

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float lblHeight = 61;
        self.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:239/255.0 alpha:1];
        [self setMultipleTouchEnabled:NO];
        beizerPath = [UIBezierPath bezierPath];
        [beizerPath setLineWidth:2.0];
        lblSignature = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.5, self.frame.size.width/4, self.frame.size.width, lblHeight)];
        
        lblSignature.font = [UIFont fontWithName:@"HelveticaNeue" size:51];
        lblSignature.text = INITIAL_LABEL_TEXT;
        lblSignature.textColor = [UIColor colorWithRed:191/255.0 green:192/255.0 blue:191/255.0 alpha:1];
        lblSignature.textAlignment = NSTextAlignmentCenter;
       // lblSignature.backgroundColor = [UIColor redColor];
        lblSignature.alpha = 0.6;
        [self addSubview:lblSignature];
//        NSLog(@"%@",lblSignature);
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    [incrImage drawInRect:rect];
    [beizerPath stroke];
    
    //设置字体颜色
    UIColor *fillColor = INITIAL_COLOR;
    [fillColor setFill];
    UIColor *strokeColor = INITIAL_COLOR;
    [strokeColor setStroke];
    [beizerPath stroke];
}

#pragma mark - 触摸事件
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    if ([lblSignature superview]) {
        [lblSignature removeFromSuperview];
    }
    control = 0;
    UITouch *touch = [touches anyObject];
    points[0] = [touch locationInView:self];
    
    CGPoint startPoint = points[0];
    CGPoint endPoint = CGPointMake(startPoint.x + 1.5, startPoint.y
                                   + 2);
    
    [beizerPath moveToPoint:startPoint];
    [beizerPath addLineToPoint:endPoint];
}

-(void)touchesMoved:(NSSet*)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    control++;
    points[control] = touchPoint;  //储存上一个触摸坐标
    
    if (control == 4)
    {
        points[3] = CGPointMake((points[2].x + points[4].x)/2.0, (points[2].y + points[4].y)/2.0);
        
        [beizerPath moveToPoint:points[0]];
        [beizerPath addCurveToPoint:points[3] controlPoint1:points[1] controlPoint2:points[2]];
        
        [self setNeedsDisplay];
        
        points[0] = points[3];
        points[1] = points[4];
        control = 1;
    }
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event{
    [self drawBitmapImage];
    [self setNeedsDisplay];
    [beizerPath removeAllPoints];
    control = 0;
}

-(void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - 制作签名图
-(void)drawBitmapImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    if (!incrImage)
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor colorWithRed:235/255.0 green:236/255.0 blue:239/255.0 alpha:1] setFill];
        [rectpath fill];
    }
    [incrImage drawAtPoint:CGPointZero];
    
    //设置最后的签名字体颜色
    UIColor *strokeColor = FINAL_COLOR;
    [strokeColor setStroke];
    [beizerPath stroke];
    incrImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)clearSignature{
    incrImage = nil;
    [self addSubview:lblSignature];
    [self setNeedsDisplay];
}

#pragma mark - 获取签名图
-(UIImage *)getSignatureImage{
    if ([lblSignature superview]) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    //获取当前屏幕图像
    UIImage *signatureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return signatureImage;
}

@end


















