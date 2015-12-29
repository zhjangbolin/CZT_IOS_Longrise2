//
//  ChangePassViewController.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "PublicViewController.h"
@interface ChangePassViewController : PublicViewController
@property (weak, nonatomic) IBOutlet CustomTextField *oldPassField;
@property (weak, nonatomic) IBOutlet CustomTextField *passNewField;
@property (weak, nonatomic) IBOutlet CustomTextField *repeatNewField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end
