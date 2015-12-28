//
//  UISelectCell.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/21.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "UISelectCell.h"

@implementation UISelectCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(int)getHeightForStr:(NSString *)str width:(CGFloat)w
{
    self.contentLabel.text = str;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    CGSize size = [self.contentLabel boundingRectWithSize:CGSizeMake(w, 0)];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.frame = CGRectMake(0, 0, size.width, size.height);
    return size.height;
}

@end
