//
//  SectionTwoViewCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "SectionTwoViewCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
@implementation SectionTwoViewCell

-(void)setUIWithInfo:(EvaluateResultModel *)model{
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.userphoto]];
    self.nameLab.text = model.showname;
    self.timestamp.text = model.evaluatetime;
    if ([model.evaluatetotle integerValue] == 1) {
        self.evaluate.image = [UIImage imageNamed:@"hao"];
    }
    else if ([model.evaluatetotle integerValue] == 2){
        self.evaluate.image = [UIImage imageNamed:@"zhong"];
    }
    else{
       self.evaluate.image = [UIImage imageNamed:@"cha"];
    }
    self.content.text = model.evaluatetotledetails;
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
