//
//  HRDetailSectionZeroCell.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRDetailDataModel.h"

@interface HRDetailSectionZeroCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serviceItemOne;//服务项目
@property (weak, nonatomic) IBOutlet UILabel *serviceItemTwo;
@property (weak, nonatomic) IBOutlet UILabel *serviceItemThree;
@property (weak, nonatomic) IBOutlet UILabel *serviceItemFour;

@property (weak, nonatomic) IBOutlet UILabel *mileageLab;//里程
@property (weak, nonatomic) IBOutlet UILabel *faultLab;//故障描述
@property (weak, nonatomic) IBOutlet UILabel *reasonLab;//故障原因
@property (weak, nonatomic) IBOutlet UILabel *numberLab;//结算编号
@property (weak, nonatomic) IBOutlet UILabel *guaranteeLab;//质保日期


-(void)setUIWithInfo:(HRDetailDataModel *)model andData:(NSMutableArray *)dataArray;
@end
