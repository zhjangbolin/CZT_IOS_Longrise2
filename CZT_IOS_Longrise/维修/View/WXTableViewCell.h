//
//  WXTableViewCell.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/9.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

@protocol WXTableViewCellDelegate <NSObject>

-(void)pushToNextViewControllerWith:(NSString *)carNo;

@end

@interface WXTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *license;
@property (weak, nonatomic) IBOutlet UILabel *carColor;
@property (weak, nonatomic) IBOutlet UILabel *carType;
@property (weak, nonatomic) IBOutlet UILabel *carModel;
@property (weak, nonatomic) IBOutlet UILabel *carUseage;
@property (weak, nonatomic) IBOutlet UIButton *checkHealth;
@property (copy, nonatomic) NSString *CellCarNo;
@property (assign,nonatomic) id <WXTableViewCellDelegate> delegate;

-(void)setUIWithInfo:(CarModel *)model;
@end
