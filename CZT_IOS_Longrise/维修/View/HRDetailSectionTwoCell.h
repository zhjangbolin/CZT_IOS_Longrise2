//
//  HRDetailSectionTwoCell.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "EvaluateModel.h"

@interface HRDetailSectionTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CWStarRateView *attitudeStar;
@property (weak, nonatomic) IBOutlet CWStarRateView *qualityStar;
@property (weak, nonatomic) IBOutlet CWStarRateView *efficiencyStar;
@property (weak, nonatomic) IBOutlet CWStarRateView *priceStar;
@property (weak, nonatomic) IBOutlet CWStarRateView *environmentStar;

@property (weak, nonatomic) IBOutlet UILabel *evaluateLab;

@property (weak, nonatomic) IBOutlet UIImageView *imgOne;



-(void)setUIWithInfo:(EvaluateModel *)model;
@end
