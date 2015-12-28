//
//  SearchParameters.h
//  TBRJL
//
//  Created by 程三 on 15/6/9.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchParameters : NSObject

@property(nonatomic,retain)NSNumber       *pageNum;
@property(nonatomic,retain)NSNumber       *pageSize;
@property(nonatomic,retain)NSNumber       *pageCount;
@property(nonatomic,copy)NSString         *name;//模型名
@property(nonatomic,copy)NSString         *order;//排序字段
@property(nonatomic,copy)NSString         *name2;
@property(nonatomic,retain)NSMutableArray *extend;
@property(nonatomic,retain)NSMutableArray *parameters;//查询参数数组
@property(nonatomic,retain)NSMutableArray *fields;//查询字段数组
@property(nonatomic,copy)NSString         *fillCodeValue;//是否返回对应代码表的值
@property(nonatomic,copy)NSString         *fillCNMetaData;
@property(nonatomic,copy)NSString         *returnCodeValue;
@property(nonatomic,copy)NSString         *toCount;
@property(nonatomic,copy)NSString         *getCodeValue;
@property(nonatomic,copy)NSString         *extendQuery;
@property(nonatomic,retain)NSMutableArray *groups;
@property(nonatomic,retain)NSMutableArray *pks;
@property(nonatomic,retain)NSNumber       *cloudAppID;
@property(nonatomic,copy)NSString         *distinct;
@property(nonatomic,copy)NSString         *queryDebug;


-(void)addParameter:(NSString *)name value:(id)object flag:(int)flag;
-(void)addFieldName:(NSString *)fieldName;
-(NSString *)getStringOfObject;
@end
