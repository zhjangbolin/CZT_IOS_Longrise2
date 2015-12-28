//
//  Voice.m
//  jishitongxun
//
//  Created by 张博林 on 15/12/3.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import "Voice.h"

@implementation Voice
-(void)setDict:(NSDictionary *)dict{
    _dict  = dict;
    
    self.icon = dict[@"icon"];
    self.content = dict[@"content"];
    self.time = dict[@"time"];
    self.voicePath = dict[@"voicePath"];
    self.voice = dict[@"voice"];
    self.type = [dict[@"type"]intValue];
    self.isSucess = [dict[@"isSucess"]intValue];
    self.longtime = dict[@"longtime"];
}

@end
