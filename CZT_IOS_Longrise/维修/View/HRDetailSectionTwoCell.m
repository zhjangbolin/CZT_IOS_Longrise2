//
//  HRDetailSectionTwoCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HRDetailSectionTwoCell.h"
#import "AppDelegate.h"

@implementation HRDetailSectionTwoCell

-(void)setUIWithInfo:(EvaluateModel *)model{
    _attitudeStar.scorePercent = [model.evaluateservice floatValue]/5;
    _qualityStar.scorePercent = [model.evaluatequality floatValue]/5;
    _efficiencyStar.scorePercent = [model.evaluateefficiency floatValue]/5;
    _environmentStar.scorePercent = [model.evaluateenvironment floatValue]/5;
    _evaluateLab.text = model.evaluatedetails;
    
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
