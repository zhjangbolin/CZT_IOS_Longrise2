//
//  PhoneCellView.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/29.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneCellView : UIButton
{
    //图片和标题的高度暂定为10:3
    UIImageView *imageView;
    UILabel  *titleLabel;
}

-(void)setTitle:(NSString *)title;
-(void)setImage:(UIImage *)image;
@end
