//
//  AccidentPhotoTableViewCell.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccidentPhotoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *carPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoLocationLabel;
@property (weak, nonatomic) IBOutlet UIView *photoView;

@end
