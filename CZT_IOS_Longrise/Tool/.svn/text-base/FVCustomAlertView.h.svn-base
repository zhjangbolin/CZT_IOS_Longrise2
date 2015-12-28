//
//  FVCustomAlertView.h
//  CustomAlertView
//
//  Created by 程三 on 15/7/24.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FVCustomAlertView;
@protocol CustomAlertViewDelegate <NSObject>
@optional
-(void)customAlertViewDismiss:(FVCustomAlertView *)customAlertView;
@end

@interface FVCustomAlertView : UIView

@property(nonatomic,retain) id<CustomAlertViewDelegate> customAlertViewDelegate;

-(void)showAlertWithonView:(UIView *)view
                     Width:(int)width
                    height:(int)height
               contentView:(UIView *)contentView
             cancelOnTouch:(BOOL)cancel
                  Duration:(int)duration;

-(void)dismiss;

@end
