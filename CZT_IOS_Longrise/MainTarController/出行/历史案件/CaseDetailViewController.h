//
//  CaseDetailViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/17.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicViewController.h"

@interface CaseDetailViewController : PublicViewController
@property (nonatomic,assign)int casetype;
@property (nonatomic,copy)NSString *casehaptime;
@property (nonatomic,copy)NSString *accidentplace;
@property (nonatomic,copy)NSString * casenumber; //系统案件编号
@property (nonatomic,copy)NSString * appphone;  //报案手机号
@property (nonatomic,copy)NSString * casecarno; //车牌号
@property (nonatomic,copy)NSString * casedate;  //报案时间
@property (nonatomic,copy)NSString * insreporttel; //保险公司报案电话
@end
