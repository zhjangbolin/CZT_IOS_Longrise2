//
//  PhotoFrame.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/8.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kMargin 10 //间隔
#define kIconWH 40 //头像宽高
#define kContentW 180 //内容宽度

#define kTimeMarginW 15 //时间文本与边框间隔宽度方向
#define kTimeMarginH 10 //时间文本与边框间隔高度方向

#define ContentTop 5 //文本内容与按钮上边缘间隔
#define ContentLeft 10 //文本内容与按钮左边缘间隔
#define ContentBottom 15 //文本内容与按钮下边缘间隔
#define ContentRight 15 //文本内容与按钮右边缘间隔

#define kTimeFont [UIFont systemFontOfSize:12] //时间字体

@class Photo;

@interface PhotoFrame : NSObject
@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect contentF;

@property (nonatomic, assign, readonly) CGFloat cellHeight; //cell高度

@property (nonatomic, strong) Photo *message;

@property (nonatomic, assign) BOOL showTime;
@end
