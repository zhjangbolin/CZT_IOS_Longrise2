//
//  Message.m
//  jishitongxun
//
//  Created by 张博林 on 15/12/2.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import "Message.h"

@implementation Message
-(void)setDict:(NSDictionary *)dict{
    _dict  = dict;
    
    self.icon = dict[@"icon"];
    self.content = dict[@"content"];
    self.time = dict[@"time"];
    self.type = [dict[@"type"]intValue];
    self.isSucess = [dict[@"isSucess"]intValue];
    self.longtime = dict[@"longtime"];
}

@end
