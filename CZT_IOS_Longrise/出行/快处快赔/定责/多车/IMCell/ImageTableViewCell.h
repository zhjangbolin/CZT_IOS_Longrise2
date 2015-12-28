//
//  ImageTableViewCell.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/8.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoFrame;


@interface ImageTableViewCell : UITableViewCell

@property (nonatomic,strong)PhotoFrame *messageFrame;
@property (nonatomic,strong)UIActivityIndicatorView *indicator;

@end
