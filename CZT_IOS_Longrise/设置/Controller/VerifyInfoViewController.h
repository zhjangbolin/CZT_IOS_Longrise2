//
//  VerifyInfoViewController.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/14.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicViewController.h"

@interface VerifyInfoViewController : PublicViewController
@property (nonatomic, copy)NSString *carNumber;
@property (nonatomic, copy)NSString *VINCode;
@property (nonatomic, copy)NSString *engineNumber;

@end
