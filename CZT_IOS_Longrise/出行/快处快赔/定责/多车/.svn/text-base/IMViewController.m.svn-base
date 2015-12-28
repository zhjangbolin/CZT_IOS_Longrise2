//
//  IMViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/8.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "IMViewController.h"
#import "WordTableViewCell.h"
#import "VoiceTableViewCell.h"
#import "ImageTableViewCell.h"
#import "MessageFrame.h"
#import "Message.h"
#import "VoiceFrame.h"
#import "Voice.h"
#import "Photo.h"
#import "PhotoFrame.h"
#import "AFNetWorkService.h"
#import "UIViewExt.h"
#import "Util.h"
#import "Globle.h"
#import "NSString+NSStringMD5.h"
#import "UIImageView+WebCache.h"
#import "Mp3Recorder.h"
#import "IQKeyboardManager.h"
#import "CZT_IOS_Longrise.pch"


NSString * monitorIP = @"203.86.8.92:82";  //监听IP
//NSString * ServiceUrl = @"http://192.168.3.229:86/KCKP/restservices/kckpzcslrest/"; //通用字段
#define SPACE_CELL_HEIGHT 110

@interface IMViewController ()<Mp3RecorderDelegate,AVAudioPlayerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSMutableArray *dataArray;
    NSString *timeBefore; //记录按下语音按钮时的时间
    NSString *timeAfter;  //记录松开按钮时的时间
    NSString *voiceContext; //语音cell的内容
    NSString *backTxt;    //返回到的文本信息
    CGFloat keyBoard;     //键盘高度
    NSString *Base64imageString; //经过Base64编码的image字节数组字符串
    NSString *Base64VoiceString; //经过Base64编码的voice字节数组字符串
    UIImage *sendImage;   //要发送的图片
    NSString *voiceLength;  //语音时间长度
    int voiceSecond;       //语音秒数
    BOOL isbeginVoiceRecord;
    Mp3Recorder *MP3;
    NSMutableData *sendVoiceData;  //语音消息数据
    NSTimer *timer;  //计数器
    int timeCount;   //语音时间
}

@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *toolButton;
@property (weak, nonatomic) IBOutlet UILabel *warnLabel;
@property (weak, nonatomic) IBOutlet UILabel *overTimeLabel;


@end

@implementation IMViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self deleteMP3File];
    //开始监听
    [self initCurl];
    [self performSelectorInBackground:@selector(go) withObject:nil];
    [self configUI];
    [self requestData];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self deleteMP3File];
}

-(void)viewDidAppear:(BOOL)animated{
    
}



-(void)deleteMP3File{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager removeItemAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"mp3.caf"] error:nil])
    {
        NSLog(@"删除以前的mp3文件");
    }
    if ([fileManager removeItemAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.caf"] error:nil]) {
        NSLog(@"删除以前的tmp文件");
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self deleteMP3File];
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.enableAutoToolbar = YES;
    //界面消失初始化数据
//    isServer = NO;
//    isSuccess = NO;
    //销毁通知中心
    
   // [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self deleteMP3File];
    
}

-(void)dealloc{
    curl_easy_cleanup(_curl);
    [self deleteMP3File];
}

#pragma mark -
#pragma mark - 初始化curl及监听事件
-(void)initCurl
{
    [self deleteMP3File];
    curl_global_init(0L);
    _curl = curl_easy_init();
    // Some settings I recommend you always set:
    
    //设置http的验证方式  使用‘CURLAUTH_ANY‘将允许libcurl可以选择任何它所支持的验证方式
    
    curl_easy_setopt(_curl, CURLOPT_HTTPAUTH, CURLAUTH_ANY);	// support basic, digest, and NTLM authentication
    curl_easy_setopt(_curl, CURLOPT_NOSIGNAL, 1L);	// try not to use signals
    curl_easy_setopt(_curl, CURLOPT_USERAGENT, curl_version());	// set a default user agent
    // Things specific to this app:
    curl_easy_setopt(_curl, CURLOPT_VERBOSE, 1L);	// turn on verbose logging; your app doesn't need to do this except when debugging a connection
    curl_easy_setopt(_curl, CURLOPT_DEBUGDATA, self);
    curl_easy_setopt(_curl, CURLOPT_WRITEDATA, self);	// prevent libcurl from writing the data to stdout
}

// this function is called in a separated thread, it gets called when receive msg from icomet server
//回调接口
size_t icomet_callback(char *ptr, size_t size, size_t nmemb, void *userdata)
{
    const size_t sizeInBytes = size*nmemb;
    NSData *data = [[NSData alloc] initWithBytes:ptr length:sizeInBytes];
    // NSString* s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // NSLog(@"返回结果:%@", s);
    
    //利用桥接将非OC对象转换成OC对象
    IMViewController *vc = (__bridge IMViewController *)userdata;
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
   // NSLog(@"推送dic=%@",dic);
    
    if ([dic[@"type"] isEqualToString:@"data"])
    {
        if (dic[@"content"]) {
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"content"]];
            NSData *data1= [str dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic1);
            if (dic1[@"msgdata"]) {
                NSString * type = dic1[@"msgdata"][@"messagetype"];
                NSLog(@"%@",type);
                  if ([type isEqualToString:@"0"]) {
//                  NSLog(@"%@",dic1[@"msgdata"][@"messageurl"]);
                    //接收到的是语音
                      NSString *voiceUrl = dic1[@"msgdata"][@"messageurl"];
                      NSString *voiceLength = dic1[@"msgdata"][@"voicelength"];
                    //  NSLog(@"%@",voiceUrl);
                      NSURL *myUrl = [NSURL URLWithString:voiceUrl];
                      NSData *mydata = [NSData dataWithContentsOfURL:myUrl];

                      NSMutableDictionary *voiceDic = [[NSMutableDictionary alloc]init];
                      [voiceDic setValue:mydata forKey:@"voice"];
                      [voiceDic setValue:voiceLength forKey:@"voicelength"];
                      
                      [vc setTextResult:voiceDic];
                      
                   }else if ([type isEqualToString:@"1"]){
                    //接收到的是图片
                    NSString *imgUrl = dic1[@"msgdata"][@"messageurl"];
                    NSLog(@"%@",imgUrl);
                    NSString *imageWidth = dic1[@"msgdata"][@"imagewide"];
                    NSString *imageHeight = dic1[@"msgdata"][@"imageheigth"];
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, (240/imageWidth.floatValue)*imageHeight.floatValue)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
                       NSMutableDictionary *imagedic = [[NSMutableDictionary alloc]init];
                       [imagedic setValue:imageView.image forKey:@"image"];
                       [vc setTextResult:imagedic];
                   }else if ([type isEqualToString:@"2"]){
                    //接收到的是文本消息
                    NSMutableDictionary *txtdic = [[NSMutableDictionary alloc]init];
                    [txtdic setValue:dic1[@"msgdata"][@"messagecontent"] forKey:@"content"];
                    [vc setTextResult:txtdic];
                }
            }
          
        }
        
    }else if ([dic[@"type"]isEqualToString:@"OK"]){
        
    }
    return sizeInBytes;
}

- (void)go
{
    [self performSelectorInBackground:@selector(startStreaming) withObject:nil];
}

-(void)startStreaming{
    //infoRoadName = @"1100002000201512061538062688490";
    NSLog(@"开始监听...");
    NSLog(@"%@",_infoRoadName);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/pushlet/stream?cname=%@&seq=0&token=null",monitorIP,_infoRoadName]];
    
    curl_easy_setopt(_curl, CURLOPT_URL, url.absoluteString.UTF8String);	// little warning: curl_easy_setopt() doesn't retain the memory passed into it, so if the memory used by calling url.absoluteString.UTF8String is freed before curl_easy_perform() is called, then it will crash. IOW, don't drain the autorelease pool before making the call
    
    curl_easy_setopt(_curl, CURLOPT_NOSIGNAL, 1L);  // try not to use signals
    curl_easy_setopt(_curl, CURLOPT_USERAGENT, curl_version()); // set a default user agent
    curl_easy_setopt(_curl, CURLOPT_WRITEFUNCTION, icomet_callback);
    curl_easy_perform(_curl);
    // curl_easy_cleanup(_curl);
}


-(void)setTextResult:(NSDictionary *)result{
    // NSLog(@"--------------%@",result);
    //回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        if (result != nil) {
            //增加数据源
            NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
            NSDate *date = [NSDate date];
            fmt.dateFormat = @"MM月dd日 hh:mm";
            NSString *time = [fmt stringFromDate:date];
            
            if ([[result allKeys] containsObject:@"content"]) {
                NSString *txt = [result objectForKey:@"content"];
                MessageFrame *mf = [[MessageFrame alloc] init];
                Message *msg = [[Message alloc] init];
                msg.content = txt;
                msg.time = time;
                msg.icon = @"picon05.png";
                msg.type = MessageTypeOther;
                msg.isSucess = 0;
                MessageFrame *lastMf = dataArray.lastObject;
                if (![msg.time isEqualToString:lastMf.message.time]) {
                    mf.showTime = YES;
                }
                mf.message = msg;
                [dataArray addObject:mf];
                
            }else if ([[result allKeys]containsObject:@"image"]){
                
                UIImage *getImage = [result objectForKey:@"image"];
                PhotoFrame *pf = [[PhotoFrame alloc]init];
                Photo *po = [[Photo alloc]init];
                po.content = getImage;
                po.time = time;
                po.icon = @"picon05.png";
                //    po.voicePath = fullPath;
                po.type = VoiceTypeOther;
                po.isSucess = 0;
                PhotoFrame *lastMf = dataArray.lastObject;
                if (![po.time isEqualToString:lastMf.message.time]) {
                    pf.showTime = YES;
                }
                pf.message = po;
                [dataArray addObject:pf];
                
            }else if ([[result allKeys]containsObject:@"voice"]){
                NSData *data = [result objectForKey:@"voice"];
                NSString *voicelength = [result objectForKey:@"voicelength"];
                NSString * content =[NSString stringWithFormat:@"%d\"",voicelength.intValue];
                VoiceFrame *vf = [[VoiceFrame alloc]init];
                Voice *vo = [[Voice alloc]init];
                vo.content = content;
                vo.time = time;
                vo.icon = @"picon05.png";
               // vo.voicePath = fullPath;
                vo.voice = [NSData dataWithData:data];
                vo.type = VoiceTypeOther;
                vo.isSucess = 0;
                
                VoiceFrame *lastMf = dataArray.lastObject;
                if (![vo.time isEqualToString:lastMf.message.time]) {
                    vf.showTime = YES;
                }
                vf.message = vo;
                [dataArray addObject:vf];
            }
            
            [_dispatchTableView reloadData];
            
            //滚动到当前行
            if (dataArray.count > 1) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
                [_dispatchTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            
        }
    });
}

#pragma mark -
#pragma mark - 发送文本信息
-(void)sendTextMessage:(NSString *)content andTime:(NSString *)time{
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    NSString *str = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [bean setValue:_infoRoadName forKey:@"appcaseno"];
    [bean setValue:_infoAccount forKey:@"account"];
    [bean setValue:@"2" forKey:@"messageorigin"];
    [bean setValue:str forKey:@"messagecontent"];
    [bean setValue:time forKey:@"messagedate"];
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmittextmessage",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        NSDictionary *dic = result;
        NSLog(@"%@",dic);
        NSLog(@"dic = %@",dic[@"redes"]);
        if (dic[@"redes"]) {
            NSString *restate = dic[@"restate"];
            for (int i = 0; i < dataArray.count; i++) {
                if([dataArray[i] isKindOfClass:[MessageFrame class]]){
                    MessageFrame *pf = dataArray[i];
                    if ([pf.message.longtime isEqualToString:bean[@"messagedate"]]) {
                        pf.message.isSucess = restate.intValue;
                        [_dispatchTableView reloadData];
                    }
                }
            }
        }
       
    }];
}

#pragma mark -
#pragma mark - 上传语音文件
-(void)uploadVoice:(NSString *)time{
    NSString * encodedImageStr = [sendVoiceData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  // NSLog(@"--------------%@",encodedImageStr);
    //序列化
    encodedImageStr = [encodedImageStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    encodedImageStr = [NSString stringWithFormat:@"\"%@\"",encodedImageStr];
    
    //第一层请求获取url
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    [bean setValue:encodedImageStr forKey:@"filedata"];
    [bean setValue:@"2" forKey:@"filetype"];
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    //第二层请求上传语音
   
    NSMutableDictionary *bean1 = [[NSMutableDictionary alloc]init];
    [bean1 setValue:_infoRoadName forKey:@"appcaseno"];
     [bean1 setValue:_infoAccount forKey:@"account"];
  //  [bean1 setValue:@"18907172640" forKey:@"account"];
    [bean1 setValue:@0 forKey:@"messagetype"];
    [bean1 setValue:@"mp3" forKey:@"resourcetype"];
    [bean1 setValue:@2 forKey:@"messageorigin"];
    [bean1 setValue:[NSString stringWithFormat:@"%lf",voiceLength.floatValue/60] forKey:@"messagebig"];
    [bean1 setValue:nil forKey:@"imagewide"];
    [bean1 setValue:nil forKey:@"imageheigth"];
    [bean1 setValue:voiceLength forKey:@"voicelength"];
    [bean1 setValue:time forKey:@"messagedate"];
    [bean1 setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean1 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/kckpAppUploadFile",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        NSDictionary *dic = result;
        NSLog(@"%@",dic);
        if ([dic[@"restate"] isEqualToString:@"1"]) {
            return ;
        }
        if (dic[@"data"]){
            NSString *strurl = dic[@"data"][@"fileurl"];
             [bean1 setValue:strurl forKey:@"messageurl"];
            [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitvoicemessage",kckpzcslrest] params:bean1 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
                NSDictionary *dic1 = result;
                NSLog(@"%@",dic1[@"redes"]);
                NSString *restate = dic1[@"restate"];
                for (int i = 0; i < dataArray.count; i++) {
                    if([dataArray[i] isKindOfClass:[VoiceFrame class]]){
                        VoiceFrame *pf = dataArray[i];
                        if ([pf.message.longtime isEqualToString:bean1[@"messagedate"]]) {
                            pf.message.isSucess = restate.intValue;
                            [_dispatchTableView reloadData];
                            
                        }
                    }
                }
            }];
        }
    }];
}

#pragma mark -
#pragma mark - 上传图片
-(void)uploadPhotoWithTime:(NSString *)time andImageBig:(CGFloat)imageBig{

    //第一层请求获取url
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    [bean setValue:Base64imageString forKey:@"filedata"];
    [bean setValue:@"1" forKey:@"filetype"];
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    //第二层请求上传图片
    CGSize imageSize = sendImage.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    NSMutableDictionary *bean1 = [[NSMutableDictionary alloc]init];
    [bean1 setValue:_infoRoadName forKey:@"appcaseno"];
    [bean1 setValue:_infoAccount forKey:@"account"];
    [bean1 setValue:@1 forKey:@"messagetype"];
    [bean1 setValue:@"jpg" forKey:@"resourcetype"];
    [bean1 setValue:@2 forKey:@"messageorigin"];
    [bean1 setValue:[NSString stringWithFormat:@"%lf",imageBig] forKey:@"messagebig"];
    [bean1 setValue:[NSString stringWithFormat:@"%lf",imageWidth] forKey:@"imagewide"];
    [bean1 setValue:[NSString stringWithFormat:@"%lf",imageHeight] forKey:@"imageheigth"];
    [bean1 setValue:nil forKey:@"voicelength"];
    [bean1 setValue:time forKey:@"messagedate"];
    [bean1 setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean1 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/kckpAppUploadFile",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        NSDictionary *dic = result;
        NSLog(@"%@",dic);
        if ([dic[@"restate"] isEqualToString:@"1"]) {
            return;
        }
        if (dic[@"data"][@"fileurl"]) {
            NSString *strurl = dic[@"data"][@"fileurl"];
            [bean1 setValue:strurl forKey:@"messageurl"];
            [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitvoicemessage",kckpzcslrest] params:bean1 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
                NSDictionary *dic1 = result;
               // NSLog(@"%@",dic1[@"restate"]);
                NSString *restate = dic1[@"restate"];
                for (int i = 0; i < dataArray.count; i++) {
                    if([dataArray[i] isKindOfClass:[PhotoFrame class]]){
                        PhotoFrame *pf = dataArray[i];
                        if ([pf.message.longtime isEqualToString:bean1[@"messagedate"]]) {
                            pf.message.isSucess = restate.intValue;
                            [_dispatchTableView reloadData];
                            
                        }
                    }
                }
            }];
            
        }else{
            NSLog(@"%@",dic[@"redes"]);
        }
    }];
}

#pragma mark -
#pragma mark - 数据请求
-(void)requestData{
    //添加一个空cell
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content = nil;
    msg.time = nil;
    msg.icon = nil;
   // msg.type = MessageTypeMe;
    mf.message = msg;
    mf.contentF = CGRectMake(self.view.bounds.size.width, 0, 0, 0);
    dataArray = [NSMutableArray array];
    [dataArray addObject:mf];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _messageField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _messageField.leftViewMode = UITextFieldViewModeAlways;
    
}

#pragma mark -
#pragma mark - 键盘处理
-(void)keyBoardWillShow:(NSNotification *)note{
      CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
      keyBoard = - rect.size.height;
//    [UIView animateWithDuration:0.2 animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, -5);
//    }];
    
    //  CGFloat ty = - rect.size.height;
    
}

-(void)keyBoardWillHide:(NSNotification *)note{
    _sendMessageButton.hidden = YES;
    _toolButton.hidden = NO;
//    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//        self.view.transform = CGAffineTransformIdentity;
//    }];
//    [UIView animateWithDuration:0.2 animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, 5);
//    }];
}

#pragma mark -
#pragma mark - 给数据源增加Message内容
- (void)addMessageWithContent:(NSString *)content time:(NSString *)time longtime:(NSString *)longtime{
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content = content;
    msg.time = time;
    msg.icon = @"picon04.png";
    msg.type = MessageTypeMe;
    msg.isSucess = 1;
    msg.longtime = longtime;
    MessageFrame *lastMf = dataArray.lastObject;
    if (![msg.time isEqualToString:lastMf.message.time]) {
        mf.showTime = YES;
    }
    mf.message = msg;
    [dataArray addObject:mf];
}

#pragma mark -
#pragma mark - 给数据源增加Voice内容
-(void)addVoiceWithContent:(NSString *)content time:(NSString *)time longtime:(NSString *)longtime{
    VoiceFrame *vf = [[VoiceFrame alloc]init];
    Voice *vo = [[Voice alloc]init];
    vo.content = content;
    vo.time = time;
    vo.icon = @"picon04.png";
    vo.voice = sendVoiceData;
    vo.type = VoiceTypeMe;
    vo.isSucess = 1;
    vo.longtime = longtime;
    
    VoiceFrame *lastMf = dataArray.lastObject;
    if (![vo.time isEqualToString:lastMf.message.time]) {
        vf.showTime = YES;
    }
    vf.message = vo;
    [dataArray addObject:vf];
}

#pragma mark -
#pragma mark - 给数据源增加photo内容
-(void)addPhotoWithContent:(UIImage *)content time:(NSString *)time longtime:(NSString *)longtime{
    PhotoFrame *pf = [[PhotoFrame alloc]init];
    Photo *po = [[Photo alloc]init];
    po.content = content;
    po.time = time;
    po.icon = @"picon04.png";
//    po.voicePath = fullPath;
    po.type = VoiceTypeMe;
    po.longtime = longtime;
    PhotoFrame *lastMf = dataArray.lastObject;
    po.isSucess = 1;
    if (![po.time isEqualToString:lastMf.message.time]) {
        pf.showTime = YES;
    }
    pf.message = po;
    [dataArray addObject:pf];
    
}

#pragma mark -
#pragma mark - 配置UI
-(void)configUI{
    
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.enableAutoToolbar = NO;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    label.text = @"指导定责";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = label;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:37/255.0 green:159/255.0 blue:233/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _messageField.layer.masksToBounds = YES;
    _messageField.layer.cornerRadius = 7;
    _messageField.layer.borderColor = [UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1].CGColor;
    _messageField.layer.borderWidth = 0.8;
    
    _sendMessageButton.layer.masksToBounds = YES;
    _sendMessageButton.layer.cornerRadius = 3;
    _speakBtn.layer.masksToBounds = YES;
    _speakBtn.layer.cornerRadius = 7;
    
}


#pragma mark -
#pragma mark - button点击事件
- (IBAction)sendMessage:(id)sender {
    [self textFieldShouldReturn:_messageField];
}

- (IBAction)toolClickedDown:(id)sender {
    CGRect frame = _toolView.frame;
    CGRect tableViewFrame = _dispatchTableView.frame;
    NSLog(@"%lf",frame.origin.y);
    NSLog(@"%lf",[UIScreen mainScreen].bounds.size.height);
    if (([UIScreen mainScreen].bounds.size.height-frame.origin.y)<=170) {
        frame.origin.y -= 115;
        tableViewFrame.origin.y -= 115;
        
        [UIView animateWithDuration:0.2 animations:^{
            _toolView.frame = frame;
            _dispatchTableView.frame = tableViewFrame;
        }];
    }else if(([UIScreen mainScreen].bounds.size.height-frame.origin.y)>170){
        frame.origin.y += 115;
        tableViewFrame.origin.y += 115;
        [UIView animateWithDuration:0.2 animations:^{
            _toolView.frame = frame;
            _dispatchTableView.frame = tableViewFrame;
        }];
    }
}


- (IBAction)startVoice:(id)sender {
    if (_messageField.hidden) { //输入框隐藏，按住说话按钮显示
        _messageField.hidden = NO;
        _speakBtn.hidden = YES;
      //  [_messageField becomeFirstResponder];
    }else{ //输入框处于显示状态，按住说话按钮处于隐藏状态
        _messageField.hidden = YES;
        _speakBtn.hidden = NO;
        [_messageField resignFirstResponder];
    }
    
}

//按下语音按钮
- (IBAction)clickedDown:(id)sender {
    //初始化MP3
    timeCount = 0; //语音计时器
    _speakBtn.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:1];
    [_speakBtn setTitle:@"拖出取消录音" forState:UIControlStateHighlighted];
    MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
    [MP3 startRecord];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"mm/ss";
    timeBefore = [fmt stringFromDate:date];
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
}

-(void)timerRun{
    timeCount++;
    if (timeCount>=120) {
        [MP3 stopRecord];
        [timer invalidate];
        timer = nil;
        
        [UIView animateWithDuration:0.5 animations:^{
            _overTimeLabel.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                _overTimeLabel.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
        }];
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        NSDate *date = [NSDate date];
        fmt.dateFormat = @"YYYY-MM-DD HH:MM:SS";
        NSString *sendTime = [fmt stringFromDate:date];
        NSString *context = @"2'";
        [self uploadVoice:sendTime];
        fmt.dateFormat = @"MM月dd日 hh:mm";
        NSString *time = [fmt stringFromDate:date];
        [self addVoiceWithContent:context time:time longtime:sendTime];
        [_dispatchTableView reloadData];
        //滚动到当前行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
        [_dispatchTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}


//松开语音按钮
- (IBAction)clickedUpInside:(id)sender {
    if (timeCount >= 120) {
        return;
    }
    [MP3 stopRecord];
    [timer invalidate];
    timer = nil;
    _speakBtn.backgroundColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"mm/ss";
    timeAfter = [fmt stringFromDate:date];
    
    fmt.dateFormat = @"YYYY-MM-DD HH:MM:SS";
    NSString *sendTime = [fmt stringFromDate:date];
    NSString *context = [self getVoiceTime];
    [self uploadVoice:sendTime];
    
    fmt.dateFormat = @"MM月dd日 hh:mm";
    NSString *time = [fmt stringFromDate:date];
    
    [self addVoiceWithContent:context time:time longtime:sendTime];
    [_dispatchTableView reloadData];
    
    //滚动到当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
    [_dispatchTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (IBAction)cancelRecord:(id)sender {
    [MP3 cancelRecord];
    [timer invalidate];
    timer = nil;
      _speakBtn.backgroundColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
    
}
- (IBAction)remindDargEnter:(id)sender {
   // NSLog(@"11111");
}
- (IBAction)remindDargExit:(id)sender {
  //  NSLog(@"222222");
   
}

- (IBAction)photo:(id)sender {
   // [_messageField resignFirstResponder];
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)camera:(id)sender {
   // [_messageField resignFirstResponder];
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];

}

- (IBAction)map:(id)sender {
    
}

#pragma mark -
#pragma mark - 获取语音的总共时间
-(NSString *)getVoiceTime{
    NSArray *array1 = [timeBefore componentsSeparatedByString:@"/"];
    NSArray *array2 = [timeAfter componentsSeparatedByString:@"/"];
    NSString *mstr1 = array1[0];
    NSString *sstr1 = array1[1];
    NSString *mstr2 = array2[0];
    NSString *sstr2 = array2[1];
    
    NSInteger minute = mstr2.integerValue - mstr1.integerValue;
    NSInteger second = 0;
    if ((sstr2.integerValue - sstr1.integerValue) >= 0) {
        second = sstr2.integerValue - sstr1.integerValue;
    }else{
        second = sstr2.integerValue - sstr1.integerValue + 60;
        minute--;
    }
    if (minute>0) {
        voiceContext = [NSString stringWithFormat:@"%ld'%ld\"",minute,second];
        voiceLength = [NSString stringWithFormat:@"%lf",(minute*60+second)/60.0];
    }else{
        voiceContext = [NSString stringWithFormat:@"%ld\"",second];
        voiceLength = [NSString stringWithFormat:@"%lf",second/60.0];
    }
    return voiceContext;
}




#pragma mark -
#pragma mark - 语音cell代理方法
-(void)playWithUrl:(NSString *)voicePath{
//    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(dispatchQueue, ^{
//        NSURL *url = [NSURL fileURLWithPath:voicePath];
//        AVAudioPlayer * player1 = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
//        player1.delegate = self;
//        player1.volume = 1.0;
//        player1.numberOfLoops = -1;
//        [player1 prepareToPlay];
//        [player1 play];
//    });
//    NSLog(@"%@",voicePath);
   
}

#pragma mark -
#pragma mark - imagePicker反馈代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage * avatar = info[UIImagePickerControllerOriginalImage];
    CGSize imagesize = avatar.size;
    imagesize.height = avatar.size.height/(avatar.size.width/(240*([UIScreen mainScreen].bounds.size.width/375.0)));
    imagesize.width = 240*([UIScreen mainScreen].bounds.size.width/375.0);
    avatar = [self imageWithImage:avatar scaledToSize:imagesize];
    picker.delegate = self;
    NSData *imageData = UIImageJPEGRepresentation(avatar, 0.9);
    CGFloat length = [imageData length]/1024.0;
    NSString * encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //序列化
    encodedImageStr = [encodedImageStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    encodedImageStr = [NSString stringWithFormat:@"\"%@\"",encodedImageStr];
    Base64imageString = encodedImageStr;
    sendImage = avatar;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM月dd日 hh:mm";
    NSString *sendTime = [fmt stringFromDate:date];
    fmt.dateFormat = @"YYYY-MM-DD HH:MM:SS";
    NSString *time = [fmt stringFromDate:date];
    
    [self addPhotoWithContent:avatar time:sendTime longtime:time];
    [_dispatchTableView reloadData];
    //滚动到当前行
    if (dataArray.count > 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
        [_dispatchTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    [self uploadPhotoWithTime:time andImageBig:length];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//图片缩放
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark -
#pragma mark - tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdetify1 = @"WordTableViewCell";
    static NSString *reuseIdetify2 = @"VoiceTableViewCell";
    static NSString *reuseIdetify3 = @"ImageTableViewCell";
    WordTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:reuseIdetify1];
    VoiceTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuseIdetify2];
    ImageTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:reuseIdetify3];
    
    if([dataArray[indexPath.row] isKindOfClass:[MessageFrame class]]){
        if (cell1 == nil) {
            cell1 = [[WordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify1];
        }
        //设置数据
        cell1.messageFrame = dataArray[indexPath.row];
        if (cell1.messageFrame.message.isSucess == 0) {
            [cell1.indicator stopAnimating];
        }
        return cell1;
        
    }else if ([dataArray[indexPath.row] isKindOfClass:[VoiceFrame class]]){
        if (cell2 == nil) {
            cell2 = [[VoiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify2];
        }
        //设置数据
        cell2.messageFrame = dataArray[indexPath.row];
        if (cell2.messageFrame.message.isSucess == 0) {
            [cell2.indicator stopAnimating];
        }
      
        return cell2;
    }else if ([dataArray[indexPath.row] isKindOfClass:[PhotoFrame class]]){
        if (cell3 == nil) {
            cell3 = [[ImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify3];
        }
        cell3.messageFrame = dataArray[indexPath.row];
        if (cell3.messageFrame.message.isSucess == 0) {
            [cell3.indicator stopAnimating];
        }
       
        return cell3;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return -keyBoard + SPACE_CELL_HEIGHT;
    }else{
        return [dataArray[indexPath.row]cellHeight];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark - textField代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _sendMessageButton.hidden = NO;
    _toolButton.hidden = YES;
//    [UIView animateWithDuration:0.2 animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, -5);
//    }];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //增加数据源
    if (textField.text.length > 0 && textField.text.length < 200) {
        NSString *content = textField.text;
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        NSDate *date = [NSDate date];
        fmt.dateFormat = @"MM月dd日 hh:mm";
        NSString *time = [fmt stringFromDate:date];
        
        fmt.dateFormat = @"YYYY-MM-DD HH:MM:SS";
        NSString *time1 = [fmt stringFromDate:date];
        //NSLog(@"%@",time);
       // [self pushStreaming:textField.text];
        [self addMessageWithContent:content time:time longtime:time1];
        [_dispatchTableView reloadData];
        
        //滚动到当前行
        if (dataArray.count>1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
            [_dispatchTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        //给服务器发送消息
        [self sendTextMessage:content andTime:time1];
        
    }else if(textField.text.length >= 200){
        [UIView animateWithDuration:0.5 animations:^{
            _warnLabel.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                _warnLabel.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
        }];
        
    }
    
    //清空textField
    _messageField.text = nil;
    return YES;
}


#pragma mark -
#pragma mark - MP3RecorderDelegate

-(void)beginConvert{
  //  NSLog(@"11111");
}

-(void)endConvertWithData:(NSData *)voiceData{
  //  NSLog(@"-------------------------------------------------111");
    sendVoiceData = [NSMutableData dataWithData:voiceData];
}

-(void)failRecord{
    
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
