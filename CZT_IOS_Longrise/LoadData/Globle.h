//
//  Globle.h
//  TBRJL
//
//  Created by 程三 on 15/6/13.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkService.h"

@interface Globle : NSObject

//登陆平台地址
@property(nonatomic,copy) NSString *serviceURL;
//维修平台的地址
@property(nonatomic,copy) NSString *wxSericeURL;
//基础平台地址
@property(nonatomic,copy) NSString *wxBaseServiceURL;
//升级平台地址
@property(nonatomic,copy)NSString *updateURL;
//登陆对象
@property(nonatomic,retain)NSDictionary *loginInfoDic;
//调用服务对象
@property(nonatomic,retain)AFNetWorkService *service;
//经度
@property(nonatomic,assign)float imagelon;
//纬度
@property(nonatomic,assign)float imagelat;
//事故地址
@property(nonatomic,copy) NSString *imageaddress;
//区域ID
@property(nonatomic,copy) NSString *areaid;
//外层的用户名和密码，该值时不变的
@property(nonatomic,copy) NSString *loadDataName;
@property(nonatomic,copy) NSString *loadDataPass;

//token
@property(nonatomic,copy)NSString *token;

+(Globle *)getInstance;


@end
