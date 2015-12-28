//
//  HistoryTableViewCell.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/16.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "SGCLViewController.h"
#import "InsuranceReportController.h"

@interface HistoryTableViewCell ()<UIAlertViewDelegate>

@end

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//
- (IBAction)btnClicked:(id)sender {
    
    [self.delegate pushNextControllerWith:_state andNumber:_casenumber andAppcaseseno:_appcaseno andCasecarno:_casecarno andCasedate:_casedate andInscomCode:_inscomcode andCasetype:_casetype];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
