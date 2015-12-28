//
//  HealthRecordCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HealthRecordCell.h"
#import "AppDelegate.h"
#import "HRDataModel.h"
@implementation HealthRecordCell

-(void)setUIWithInfo:(HRDataModel *)model{

    _storeName.text = model.company;
    _addressLab.text = model.companyaddress;
//    _typeLab.text = model.repairtype;
    _priceLab.text = model.moneytotal;
    _timeStamp.text = model.repairdate;
    
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
