//
//  HRDetailSectionZeroCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HRDetailSectionZeroCell.h"
#import "AppDelegate.h"
@implementation HRDetailSectionZeroCell

-(void)setUIWithInfo:(HRDetailDataModel *)model andData:(NSMutableArray *)dataArray{

    for (int i=1; i<=dataArray.count; i++) {
        
        if (i==1) {
            _serviceItemOne.text = dataArray[0];
        }
        else if (i==2){
            _serviceItemTwo.text = dataArray[1];
        }
        else if (i==3){
            _serviceItemThree.text = dataArray[2];
        }
        else{
            _serviceItemFour.text = dataArray[3];
        }
        
    }

    _mileageLab.text = [NSString stringWithFormat:@"%@公里",model.repairmile];
    _faultLab.text = model.faultdescript;
    _reasonLab.text = model.faultreason;
    _numberLab.text = model.workorderno;
    _guaranteeLab.text = [NSString stringWithFormat:@"%@天",model.securitydate];
    
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
