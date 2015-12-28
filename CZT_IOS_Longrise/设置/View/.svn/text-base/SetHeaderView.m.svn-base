//
//  SetHeaderView.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "SetHeaderView.h"
#import "AppDelegate.h"
@implementation SetHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(25, 20, 60, 60)];
        _icon.image = [UIImage imageNamed:@"icon07"];
        [self addSubview:_icon];
        
        _cellPhone = [[UIImageView alloc]initWithFrame:CGRectMake(102, 56, 15, 15)];
        _cellPhone.image = [UIImage imageNamed:@"icon23"];
        [self addSubview:_cellPhone];
        
//        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(287, 47, 17, 20)];
//        _arrow.image = [UIImage imageNamed:@"public_go"];
//        [self addSubview:_icon];
        
        _userName = [[UILabel alloc]initWithFrame:CGRectMake(102, 25, 51, 21)];
        _userName.font = [UIFont systemFontOfSize:13];
        _userName.textColor = [UIColor whiteColor];
        _userName.text = @"未登录";
        [self addSubview:_userName];
        
        _phoneNum = [[UILabel alloc]initWithFrame:CGRectMake(120, 53, 80, 21)];
        _phoneNum.font = [UIFont systemFontOfSize:13];
        _phoneNum.textColor = [UIColor whiteColor];
        [self addSubview:_phoneNum];
        
        [AppDelegate storyBoradAutoLay:self];
        
    }
    return self;
}


@end
