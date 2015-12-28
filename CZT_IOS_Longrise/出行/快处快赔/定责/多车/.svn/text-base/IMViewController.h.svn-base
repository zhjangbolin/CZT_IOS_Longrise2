//
//  IMViewController.h
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/8.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "curl.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface IMViewController : UIViewController{
    //连接对象
    CURL *_curl;
   
}

@property (nonatomic, strong) NSMutableDictionary *msgDic;
@property (weak, nonatomic) IBOutlet UITableView *dispatchTableView;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UITextField *messageField;


@property (weak, nonatomic) IBOutlet UIButton *startVoice;
@property (weak, nonatomic) IBOutlet UIButton *speakBtn;
@property (nonatomic, copy)NSString *infoRoadName;  //移动报案号
@property (nonatomic, copy)NSString *infoAccount;   //发消息帐号
@property (nonatomic, copy)NSString *user;          //用户来源

@end
