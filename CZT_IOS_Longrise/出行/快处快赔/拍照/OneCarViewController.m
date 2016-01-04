//
//  OneCarViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "OneCarViewController.h"

@interface OneCarViewController ()

@end

@implementation OneCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initView];
}

#pragma mark 初始化UI
-(void)_initView
{
    //添加监听
    [self.imageBtn1 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn2 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn3 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBtn4 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.finishBtn.layer.cornerRadius = 5;
    [self.finishBtn setBackgroundColor:[UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1]];
    [self.finishBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark 单击回调函数
-(void)onClick:(UIButton *)btn
{
    if(btn == self.finishBtn)
    {
        //判断照片是否拍摄完成(0:未完成，1:完成)
        long tag = 0;
        tag = self.imageBtn1.tag;
        if(tag != 1)
        {
            [self showNoticeAboutImage];
            return;
        }
        tag = 0;
        
        tag = self.imageBtn2.tag;
        if(tag != 1)
        {
            [self showNoticeAboutImage];
            return;
        }
        tag = 0;
        
        tag = self.imageBtn3.tag;
        if(tag != 1)
        {
            [self showNoticeAboutImage];
            return;
        }
        tag = 0;

        
        NSMutableDictionary *finishDic = [[NSMutableDictionary alloc] init];
        [finishDic setObject:self.appcaseno forKey:@"appcaseno"];
        NSDictionary *userinfo = [[Globle getInstance].loginInfoDic objectForKey:@"userinfo"];
        if(nil != userinfo)
        {
            [finishDic setValue:[userinfo objectForKey:@"mobilephone"] forKey:@"appphone"];
        }
        [finishDic setObject:[Globle getInstance].loadDataName forKey:@"username"];
        [finishDic setObject:[Globle getInstance].loadDataPass forKey:@"password"];
        
        [self zdsubmitcaseimageisover:finishDic];
        return;
    }
    tempBtn = btn;
    tempBtn.tag =1;
    
    
    /*照片类型	Int	4	1、正前方
     2、正后方
     3、碰撞部位
     4、车辆近景
     5、本方车辆全景
     6、本方车辆碰撞部位
     7、对方车辆全景
     8、对方车辆碰撞部位
     9、其它；
     */
    if(btn == self.imageBtn1)
    {
        shoottype = 1;
    }
    else if(btn == self.imageBtn2)
    {
        shoottype = 2;
    }
    else if(btn == self.imageBtn3)
    {
        shoottype = 6;
    }
    else if(btn == self.imageBtn4)
    {
        shoottype = 9;
    }
    [self takePhone2:shoottype];
}

- (void)takePhone2:(int)photoType
{
    //遵守协议
    TakePhotoViewController *cameraVc = [[TakePhotoViewController alloc] init];
    cameraVc.delegate = self;
    if(photoType == 1)
    {
        cameraVc.stringFromLast = @"侧前方";
        cameraVc.imageFromLast = [UIImage imageNamed:@"car_one_font"];
    }
    else if(photoType == 2)
    {
        cameraVc.stringFromLast = @"侧后方";
        cameraVc.imageFromLast = [UIImage imageNamed:@"car_one_behind"];
    }
    else if(photoType == 6)
    {
        cameraVc.stringFromLast = @"碰撞部位";
        cameraVc.imageFromLast = [UIImage imageNamed:@"car_one_zhuang"];
    }
    else if(photoType == 9)
    {
        cameraVc.stringFromLast = @"其它现场照片";
        cameraVc.imageFromLast = nil;
    }
    
    //cameraVc.passPickImage = [UIImage imageNamed:@"photo1"];
    UINavigationController *cameraNavigationController = [[UINavigationController alloc] initWithRootViewController:cameraVc];
    cameraNavigationController.navigationBarHidden = YES;
    [self presentViewController:cameraNavigationController animated:YES completion:nil];
}

#pragma mark 自定义相机回调方法
-(void)takeTheCamera:(UIImage *)image
{
    if(nil == tempBtn || image == nil)
    {
        return;
    }
    
    //进行缩放图片
//    CGSize imgSize = image.size;
//    float height = imgSize.width*(640/imgSize.height);
    
    tempImage = [Util originImage:image scaleToSize:CGSizeMake(640,480)];
    [tempBtn setBackgroundImage:tempImage forState:UIControlStateNormal];
    
    //提交照片
    [self zdsubmitcaseimageinfor];
}

#pragma mark 上传图片
-(void)zdsubmitcaseimageinfor
{
    if(nil == tempImage)
    {
        return;
    }
    
    NSData *_data = UIImageJPEGRepresentation(tempImage, 0.9);
    NSString * encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    encodedImageStr = [encodedImageStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    encodedImageStr = [NSString stringWithFormat:@"\"%@\"",encodedImageStr];
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //移动报案号
    [dic setValue:self.appcaseno forKey:@"appcaseno"];
    //经度
    [dic setValue:[[NSNumber alloc] initWithFloat:[Globle getInstance].imagelon] forKey:@"imagelon"];
    //纬度
    [dic setValue:[[NSNumber alloc] initWithFloat:[Globle getInstance].imagelat] forKey:@"imagelat"];
    //地址描述	String
    [dic setValue:[Globle getInstance].imageaddress forKey:@"imageaddress"];
    //经过序列化的字节数组字符串
    [dic setValue:encodedImageStr forKey:@"imageurl"];
    //图片大小(单位是K)	String
    [dic setValue:[Util getImageBig:tempImage] forKey:@"imagebig"];
    //图片的宽
    [dic setValue:[[NSNumber alloc] initWithInt:tempImage.size.width] forKey:@"imagewide"];
    //图片的高
    [dic setValue:[[NSNumber alloc] initWithInt:tempImage.size.height] forKey:@"imageheigth"];
    NSDictionary *userinfo = [[Globle getInstance].loginInfoDic objectForKey:@"userinfo"];
    //报案手机号
    [dic setValue:[userinfo objectForKey:@"mobilephone"] forKey:@"casetelephoe"];
    //拍摄类型	String		1,定责图片 2定损图片
    [dic setValue:[[NSNumber alloc] initWithInt:1] forKey:@"shoottype"];
    /*照片类型	Int	4	1、正前方
     2、正后方
     3、碰撞部位
     4、车辆近景
     5、本方车辆全景
     6、本方车辆碰撞部位
     7、对方车辆全景
     8、对方车辆碰撞部位
     9、其它；
     */
    [dic setValue:[[NSNumber alloc] initWithInt:shoottype] forKey:@"imagetype"];
    //拍照时间	String	19	格式：YYYY-MM-DD HH:MM:SS(24小时)
    [dic setValue:[Util getCurrentTimeByFormal:@"yyyy-MM-dd HH:mm:ss"] forKey:@"imagedate"];
    //区域	String	18	报案所在的区域精确到区级
    [dic setValue:[Globle getInstance].areaid forKey:@"areaid"];
    //用户名
    [dic setValue:[Globle getInstance].loadDataName forKey:@"username"];
    //密码
    [dic setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    [self sendPhoneInfo:dic];
    
}
@end
