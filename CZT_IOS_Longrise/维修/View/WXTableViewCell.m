//
//  WXTableViewCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/9.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "WXTableViewCell.h"
#import "AppDelegate.h"

@implementation WXTableViewCell

-(void)setUIWithInfo:(CarModel *)model{
    
    self.license.text = model.carno;
    self.carUseage.text = model.usertype;
    self.carModel.text = model.brandtype;
    self.carType.text = model.cartype;
    
}

#pragma mark -
#pragma mark - 健康档案点击事件
- (IBAction)btnClicked:(id)sender {
    [_delegate pushToNextViewControllerWith:_CellCarNo];
}


- (void)awakeFromNib {
    // Initialization code
    [AppDelegate storyBoradAutoLay:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
