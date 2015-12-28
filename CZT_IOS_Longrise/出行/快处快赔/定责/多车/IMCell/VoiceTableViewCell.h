//
//  VoiceTableViewCell.h
//  jishitongxun
//
//  Created by 张博林 on 15/12/3.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VoiceFrame;

@interface VoiceTableViewCell : UITableViewCell

@property (nonatomic,strong) VoiceFrame *messageFrame;

@property (nonatomic,strong)UIActivityIndicatorView *indicator;

@end
