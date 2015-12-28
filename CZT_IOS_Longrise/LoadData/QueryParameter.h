//
//  QueryParameter.h
//  TBRJL
//
//  Created by 程三 on 15/6/7.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryParameter : NSObject

@property(nonatomic,copy)NSString *javaClass;
@property(nonatomic,retain)NSNumber *sqlType;
@property(nonatomic,retain)NSNumber *flag;
@property(nonatomic,copy)NSString *skipExpression;
@property(nonatomic,retain)id value;
@property(nonatomic,retain)NSNumber *type;
@property(nonatomic,copy)NSString *group;
@property(nonatomic,copy)NSString *name;

-(NSDictionary *)getDicOfObject;
@end
