//
//  VerSectionOneCell.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/15.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerSectionOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectState;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UILabel *optionsLab;
@property (nonatomic,assign)int state; //记录是否在选中状态 0 - 未选中  1 - 选中

@end
