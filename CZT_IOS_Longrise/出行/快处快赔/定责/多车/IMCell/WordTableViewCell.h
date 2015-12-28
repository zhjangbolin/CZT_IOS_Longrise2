//
//  WordTableViewCell.h
//  jishitongxun
//
//  Created by 张博林 on 15/12/2.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageFrame;

@interface WordTableViewCell : UITableViewCell

@property (nonatomic,strong) MessageFrame *messageFrame;
@property (nonatomic,strong)UIButton *contentBtn;
@property (nonatomic,strong)UIActivityIndicatorView *indicator;

@end
