//
//  OneCarViewController.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "PhoneViewController.h"
#import "TakePhotoViewController.h"
#import "Util.h"

@interface OneCarViewController : PhoneViewController<TakePhotoViewControllerDelegate>
{
    //临时按钮对象
    UIButton *tempBtn;
    //临时照片对象
    UIImage *tempImage;
    //照片类型
    int shoottype;
}
@property (weak, nonatomic) IBOutlet UIButton *imageBtn1;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn2;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn3;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn4;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end
