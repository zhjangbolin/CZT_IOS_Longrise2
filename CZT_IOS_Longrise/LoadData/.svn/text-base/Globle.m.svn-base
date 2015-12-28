//
//  Globle.m
//  TBRJL
//
//  Created by 程三 on 15/6/13.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "Globle.h"
#import "AppDelegate.h"

static Globle *globle;
@implementation Globle

-(id)init
{
    self = [super init];
    if(self)
    {
        _service = [[AFNetWorkService alloc] init];
    }
    
    return  self;
}

+(Globle *)getInstance
{
    //加锁
    @synchronized(self)
    {
        if(globle == nil)
        {
            globle = [[[self class] alloc] init];
        }
    }
    return globle;
}
@end
