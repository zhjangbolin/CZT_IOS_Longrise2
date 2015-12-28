//
//  UISelectCell.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/21.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+StringFrame.h"

@interface UISelectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
-(int)getHeightForStr:(NSString *)str width:(CGFloat)w;
@end
