//
//  TakePhotoViewController.m
//  TestPhotocaputure
//
//  Created by 张博林 on 15/12/21.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import "TakePhotoViewController.h"

@interface TakePhotoViewController ()
@property (nonatomic,assign)int state; //闪光灯状态
@property (nonatomic,strong)UIImage *photoImage; //照片
@property (weak, nonatomic) IBOutlet UIImageView *warnImageView; //提醒图片
@property (weak, nonatomic) IBOutlet UILabel *warnLabel; //提醒label
@property (weak, nonatomic) IBOutlet UIView *stadicView;


@end

@implementation TakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSession];
    [self setUpCameraLayer];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark - 相机初始化
- (void) initialSession
{
    //这个方法的执行我放在init方法里了
    self.session = [[AVCaptureSession alloc] init];
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:nil];
    //[self fronCamera]方法会返回一个AVCaptureDevice对象，因为我初始化时是采用前摄像头，所以这么写，具体的实现方法后面会介绍
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    _backButton.transform=CGAffineTransformMakeRotation(M_PI/2);
    _takePhotoButton.transform=CGAffineTransformMakeRotation(M_PI/2);
    _autoButton.transform=CGAffineTransformMakeRotation(M_PI/2);
    _warnLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    _stadicView.transform = CGAffineTransformMakeRotation(M_PI/2);
   // _stringFromLast = @"mageji";
   // _imageFromLast = [UIImage imageNamed:@"beijing_ico05"];
    if (_stringFromLast!=nil) {
        _warnLabel.text = _stringFromLast;
    }
    if (_imageFromLast!=nil) {
        [_warnImageView setImage:[self tranFormImage:_imageFromLast rotation:UIImageOrientationRight]];
    }else{
        _warnImageView.image = nil;
    }
    _state = 0;
}


- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

//设置摄像头前置还是后置
- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

//使用照相机
- (void) setUpCameraLayer
{
    //    if (_cameraAvaible == NO) return;
    
    if (self.previewLayer == nil) {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        UIView * view = self.cameraShowView;
        CALayer * viewLayer = [view layer];
        [viewLayer setMasksToBounds:YES];
        
        CGRect bounds = [view bounds];
        [self.previewLayer setFrame:bounds];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
        
        [viewLayer insertSublayer:self.previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.session) {
        [self.session startRunning];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    if (self.session) {
        [self.session stopRunning];
    }
    [self closeFlashlight];
}

//返回上一页面
- (IBAction)backToLast:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self closeFlashlight];
}

//照相
- (IBAction)takePhoto:(id)sender {
    [self shutterCamera];
}

//开启或关闭闪光灯
- (IBAction)flashLight:(id)sender {
    if (_state%2==0) {
        [self openFlashlight];
        [_autoButton setImage:[UIImage imageNamed:@"phone_icon01"] forState:UIControlStateNormal];
    }else{
        [self closeFlashlight];
        [_autoButton setImage:[UIImage imageNamed:@"phone_icon02"] forState:UIControlStateNormal];
    }
    _state++;
}

//拍照并获取照片
- (void) shutterCamera
{
    AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        _photoImage = [UIImage imageWithData:imageData];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.cameraShowView.bounds];
        [imageView setImage:_photoImage];
        [self.cameraShowView addSubview:imageView];
       // NSLog(@"image size = %@",NSStringFromCGSize(image.size));
        
        _imageFromLast = nil;
        //响应代理方法并跳转至之前的界面
        if (self.delegate&&[_delegate respondsToSelector:@selector(takeTheCamera:)]) {
            [_delegate takeTheCamera:[self tranFormImage:_photoImage rotation:UIImageOrientationUp]];
        }
        [self performSelector:@selector(backToLastViewController) withObject:nil afterDelay:1];
    }];
}

-(void)backToLastViewController{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开关闪关灯
-(void)openFlashlight
{
    [self turnOnLed];
}

-(void)closeFlashlight
{
    [self turnOffLed];
}


-(void)turnOffLed {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setFlashMode:AVCaptureFlashModeOff];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

-(void)turnOnLed {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setFlashMode:AVCaptureFlashModeOn];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
}

//旋转UIImage
- (UIImage *)tranFormImage:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
