//
//  Voice.h
//  jishitongxun
//
//  Created by 张博林 on 15/12/3.
//  Copyright © 2015年 张博林. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum{
    VoiceTypeMe = 0, //自己的消息
    VoiceTypeOther = 1 //别人的消息
    
}VoiceType;

@interface Voice : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *voicePath;
@property (nonatomic, copy) NSData *voice;
@property (nonatomic, assign) VoiceType type;
@property (nonatomic, assign)int isSucess;
@property (nonatomic, copy) NSString *longtime;

@property (nonatomic, copy) NSDictionary *dict;
@end
