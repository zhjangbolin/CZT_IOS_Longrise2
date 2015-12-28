//
//  Photo.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/8.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Photo : NSObject
typedef enum{
    PhotoTypeMe = 0, //自己的消息
    PhotoTypeOther = 1 //别人的消息
    
}PhotoType;

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) UIImage *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *photoPath;
@property (nonatomic, assign) PhotoType type;
@property (nonatomic, assign)int isSucess;
@property (nonatomic, copy) NSString *longtime;

@property (nonatomic, copy) NSDictionary *dict;
@end
