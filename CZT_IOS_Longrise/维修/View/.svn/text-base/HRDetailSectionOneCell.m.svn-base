//
//  HRDetailSectionOneCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HRDetailSectionOneCell.h"
#import "AppDelegate.h"

@implementation HRDetailSectionOneCell

-(void)setUIWithInfo:(HRDetailDataModel *)model{

    _materialFee.text = model.materialsum;
    _workingHoursFee.text = model.mlaborsum;
    _othersFee.text = model.otherexpsum;
    _totalLab.text = model.moneytotal;
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
