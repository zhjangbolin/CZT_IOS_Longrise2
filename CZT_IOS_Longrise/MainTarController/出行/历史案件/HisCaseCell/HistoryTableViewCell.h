//
//  HistoryTableViewCell.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/16.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellPush <NSObject>

-(void)pushNextControllerWith:(int)caseState andNumber:(NSString *)casenumber andAppcaseseno:(NSString *)appcaseno andCasecarno:(NSString *)casecarno andCasedate:(NSString *)casedate andInscomCode:(NSString *)inscomcode andCasetype:(int)casetype;

@end

@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *caseType;
@property (weak, nonatomic) IBOutlet UILabel *caseState;
@property (weak, nonatomic) IBOutlet UILabel *caseHapTime;
@property (weak, nonatomic) IBOutlet UIButton *caseHandleState;
@property (nonatomic,assign)int state;
@property (nonatomic,copy)NSString *appcaseno;
@property (nonatomic,copy)NSString *casecarno;
@property (nonatomic,copy)NSString *casenumber;
@property (nonatomic,copy)NSString *casedate;
@property (nonatomic,copy)NSString *inscomcode;
@property (nonatomic,assign)int casetype;
@property (nonatomic,assign) id<CellPush>delegate;

@end
