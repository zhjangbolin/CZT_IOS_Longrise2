//
//  HistoryModel.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/16.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject
@property (nonatomic,assign)int casetype;
@property (nonatomic,assign)int state;
@property (nonatomic,copy)NSString *casecarno;
@property (nonatomic,copy)NSString *casenumber;
@property (nonatomic,copy)NSString *appcaseno;
@property (nonatomic,copy)NSString *inscomcode;
@property (nonatomic,copy)NSString *inscompany;
@property (nonatomic,copy)NSString *instel;
@property (nonatomic,copy)NSString *casedate;
@property (nonatomic,copy)NSString *casehaptime;
@property (nonatomic,copy)NSString *accidentplace;
@property (nonatomic,copy)NSString *insreporttel;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
