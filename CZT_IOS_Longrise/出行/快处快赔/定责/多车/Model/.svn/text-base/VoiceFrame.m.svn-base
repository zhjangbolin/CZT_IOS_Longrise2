//
//  VoiceFrame.m
//  jishitongxun
//
//  Created by 张博林 on 15/12/3.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import "VoiceFrame.h"
#import "Voice.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation VoiceFrame
-(void)setMessage:(Voice *)message{
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
    if (_message.type == VoiceTypeMe) {
        iconX = SCREEN_WIDTH - kMargin - kIconWH;
    }
    
    CGFloat iconY = CGRectGetMaxY(_timeF) + kMargin;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    //计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
    CGFloat contentY = iconY;
    CGSize contentSize = [_message.content boundingRectWithSize:CGSizeMake(kContentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kContentFont} context:nil].size;
    
    if (_message.type == VoiceTypeMe) {
        contentX = iconX - kMargin - contentSize.width - VContentLeft - kContentRight - 35;
    }
    
    _contentF = CGRectMake(contentX, contentY, contentSize.width + VContentLeft + kContentRight+30, contentSize.height + kContentTop + kContentBottom);
    
    // 4、计算高度
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_iconF))  + kMargin;
}

@end
