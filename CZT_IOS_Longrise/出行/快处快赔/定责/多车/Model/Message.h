//
//  Message.h
//  jishitongxun
//
//  Created by 张博林 on 15/12/2.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MessageTypeMe = 0, //自己的消息
    MessageTypeOther = 1 //别人的消息
    
}MessageType;

@interface Message : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign)int isSucess;
@property (nonatomic, copy) NSString *longtime;

@property (nonatomic, copy) NSDictionary *dict;

@end
