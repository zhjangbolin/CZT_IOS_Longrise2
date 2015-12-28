//
//  AccidentPhotoTableViewCell.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "AccidentPhotoTableViewCell.h"
#import "SJAvatarBrowser.h"

@implementation AccidentPhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _photoView.layer.masksToBounds = YES;
    _photoView.layer.cornerRadius = 5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(magnifyImage:)];
    [self.carPhotoImageView addGestureRecognizer:tap];
}

- (void)magnifyImage:(UITapGestureRecognizer *)tap
{
    [SJAvatarBrowser showImage:self.carPhotoImageView];//调用方法
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
