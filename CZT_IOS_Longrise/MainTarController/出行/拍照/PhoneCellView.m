//
//  PhoneCellView.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/29.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "PhoneCellView.h"
#import "UIViewExt.h"

@implementation PhoneCellView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self _initView];
    return self;
}

-(void)_initView
{
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.backgroundColor = [UIColor yellowColor];
    imageView.top = 0;
    imageView.left = 0;
    imageView.width = self.width;
    imageView.height = self.height * 10 / 13;
    [self addSubview:imageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = @"标题";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    titleLabel.left = 0;
    titleLabel.top = imageView.bottom;
    titleLabel.width = imageView.width;
    titleLabel.height = self.height * 3 / 13;
    [self addSubview:titleLabel];
    
}

#pragma mark 设置标题
-(void)setTitle:(NSString *)title
{
    if(nil != titleLabel)
    {
        titleLabel.text = title;
    }
}

#pragma mark 设置图片
-(void)setImage:(UIImage *)image
{
    if(imageView != nil)
    {
        [imageView setImage:image];
    }
}

@end
