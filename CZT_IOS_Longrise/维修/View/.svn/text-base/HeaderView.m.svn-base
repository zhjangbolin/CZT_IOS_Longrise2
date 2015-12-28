//
//  HeaderView.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HeaderView.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setUIWithInfo:(DetailInfoModel *)model{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.lcipcompanyphoto]];
    self.nameLab.text = model.name;
    self.addressLab.text = model.address;
    
}

-(void)awakeFromNib{
    [AppDelegate storyBoradAutoLay:self];
    [self.addressBtn setImage:[UIImage imageNamed:@"icon22"] forState:UIControlStateNormal];
    [self.callBtn setImage:[UIImage imageNamed:@"icon03"] forState:UIControlStateNormal];
}

@end
