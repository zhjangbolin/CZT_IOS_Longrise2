//
//  InsuranceReportController.h
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface InsuranceReportController : PublicViewController

@property (weak, nonatomic) IBOutlet UIButton *reportCaseBtn;
@property (weak, nonatomic) IBOutlet UIButton *unReportCase;

@property (strong, nonatomic)NSMutableDictionary *historyCaseDict;
@end
