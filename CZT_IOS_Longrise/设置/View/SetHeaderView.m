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
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 60, 60)];
        _icon.image = [UIImage imageNamed:@"icon07"];
        [self addSubview:_icon];
        
        _cellPhone = [[UIImageView alloc]initWithFrame:CGRectMake(82, 71, 15, 15)];
        _cellPhone.image = [UIImage imageNamed:@"icon23"];
        [self addSubview:_cellPhone];
        
//        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(287, 47, 17, 20)];
//        _arrow.image = [UIImage imageNamed:@"public_go"];
//        [self addSubview:_icon];
        
        _notLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _notLoginBtn.frame = CGRectMake(75, 53, 51, 20);
        [_notLoginBtn setTitle:@"请登录" forState:UIControlStateNormal];
        [_notLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _notLoginBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _notLoginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_notLoginBtn];
        
        _userName = [[UILabel alloc]initWithFrame:CGRectMake(82, 40, 200, 21)];
        _userName.font = [UIFont systemFontOfSize:13];
        _userName.textColor = [UIColor whiteColor];
       // _userName.text = @"请登录";
        [self addSubview:_userName];
        
        _phoneNum = [[UILabel alloc]initWithFrame:CGRectMake(100, 68, 80, 21)];
        _phoneNum.font = [UIFont systemFontOfSize:13];
        _phoneNum.textColor = [UIColor whiteColor];
        [self addSubview:_phoneNum];
        
        
        
        [AppDelegate storyBoradAutoLay:self];
        
    }
    return self;
}


@end
