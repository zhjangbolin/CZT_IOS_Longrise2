//
//  HRDetailHeaderView.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HRDetailHeaderView.h"
#import "AppDelegate.h"

@implementation HRDetailHeaderView


-(void)awakeFromNib{
    
     [AppDelegate storyBoradAutoLay:self];
}

-(void)setUIWithInfo:(HRDataModel *)model{

    _storeName.text = model.company;
    _addressLab.text = model.companyaddress;
//    _typeLab.text = model.repairtype;
    _priceLab.text = model.moneytotal;
    _timeStamp.text = model.repairdate;

}




@end
