//
//  PhotoFrame.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/8.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PhotoFrame.h"
#import "Photo.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation PhotoFrame
-(void)setMessage:(Photo *)message{
    _message = message;
    
    // 计算时间的位置
    if (_showTime){
        
        CGFloat timeY = kMargin;
        CGSize timeSize = [_message.time sizeWithAttributes:@{NSFontAttributeName:kTimeFont}];
        //NSLog(@"----%@", NSStringFromCGSize(timeSize));
        CGFloat timeX = (SCREEN_WIDTH - timeSize.width)/2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + kTimeMarginW, timeSize.height + kTimeMarginH);
    }
    
    //计算头像位置
    CGFloat iconX = kMargin;
    //如果是自己发的消息，头像在右边
    if (_message.type == PhotoTypeMe) {
        iconX = SCREEN_WIDTH - kMargin - kIconWH;
    }
    
    CGFloat iconY = CGRectGetMaxY(_timeF) + kMargin;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    //计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
    CGFloat contentY = iconY;
    CGSize contentSize = _message.content.size;
    
    if (_message.type == PhotoTypeMe) {
        contentX = iconX - kMargin - contentSize.width - ContentLeft - ContentRight - 5;
    }
    
    _contentF = CGRectMake(contentX, contentY, contentSize.width + ContentLeft + ContentRight, contentSize.height);
    
    // 4、计算高度
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_iconF))  + kMargin;
}


@end
