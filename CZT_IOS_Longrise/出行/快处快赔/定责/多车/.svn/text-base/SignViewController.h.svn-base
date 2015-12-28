//
//  SignViewController.h
//  qianming
//
//  Created by 张博林 on 15/12/5.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJRSignatureView.h"

@protocol SignViewControllerDelegate <NSObject>

-(void)passSignImage:(UIImage *)signImage;

@end

@interface SignViewController : UIViewController{
    PJRSignatureView *signatureView;
}
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (weak, nonatomic) IBOutlet UIButton *resignButton;

@property (weak, nonatomic) id<SignViewControllerDelegate> delegate;
@end
