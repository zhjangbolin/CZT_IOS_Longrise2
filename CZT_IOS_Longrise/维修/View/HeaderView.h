//
//  HeaderView.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "DetailInfoModel.h"
@interface HeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;

-(void)setUIWithInfo:(DetailInfoModel *)model;
@end
