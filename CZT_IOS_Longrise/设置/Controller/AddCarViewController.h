//
//  AddCarViewController.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/10.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PublicViewController.h"
#import "CustomTextField.h"
#import "UISelectListView.h"
@interface AddCarViewController : PublicViewController
@property (weak, nonatomic) IBOutlet UIView *carTypeBackView;
@property (weak, nonatomic) IBOutlet UIView *carNoSelectBackView;
@property (weak, nonatomic) IBOutlet UIView *insSelectBackView;
@property (weak, nonatomic) IBOutlet UITextField *carNum;

@property (weak, nonatomic) IBOutlet CustomTextField *vinCode;
@property (weak, nonatomic) IBOutlet CustomTextField *engineNum;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end
