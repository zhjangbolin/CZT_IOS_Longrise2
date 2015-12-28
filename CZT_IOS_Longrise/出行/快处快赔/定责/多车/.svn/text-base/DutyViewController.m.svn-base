//
//  DutyViewController.m
//  Test
//
//  Created by 张博林 on 15/12/14.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import "DutyViewController.h"
#import "ViewController.h"
#import "Globle.h"
#import "AFNetWorkService.h"
#import "ControversialController.h"


@interface DutyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *giveUpGuideButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *noGiveUpView;

@property (weak, nonatomic) IBOutlet UIView *giveUpWarnView;
@property (weak, nonatomic) IBOutlet UIButton *noGiveUpButton;
@property (weak, nonatomic) IBOutlet UIButton *giveupButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (nonatomic,copy) NSString *caseCarNo;
@property (nonatomic,copy) NSString *dutyType;
//责任类型数组
@property (strong, nonatomic) NSArray *dutyData;

@property (weak, nonatomic) IBOutlet UIView *bacView;


@end

extern NSString * monitorIP;  //监听IP
//NSString *name1 = @"110000002000"; //用户名
//NSString *pass1 = @"F11351A8B0D7483AEBCE6CBD7679F33A"; //密码

@implementation DutyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"指导定责";
    [self initCurl];
    [self go];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark - 初始化curl及监听事件
-(void)initCurl
{
   
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

- (void)go
{
    [self performSelectorInBackground:@selector(startStreaming) withObject:nil];
}

-(void)startStreaming{
  //  NSString * infoRoadName = @"2015110160003333302656534";
    NSLog(@"开始监听...");
  //  NSLog(@"%@",_infoRoadName);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/pushlet/stream?cname=%@&seq=0&token=null",monitorIP,_appcaseno]];
    
    curl_easy_setopt(_curl, CURLOPT_URL, url.absoluteString.UTF8String);	// little warning: curl_easy_setopt() doesn't retain the memory passed into it, so if the memory used by calling url.absoluteString.UTF8String is freed before curl_easy_perform() is called, then it will crash. IOW, don't drain the autorelease pool before making the call
    
    curl_easy_setopt(_curl, CURLOPT_NOSIGNAL, 1L);  // try not to use signals
    curl_easy_setopt(_curl, CURLOPT_USERAGENT, curl_version()); // set a default user agent
    curl_easy_setopt(_curl, CURLOPT_WRITEFUNCTION, icomet_callback1);
    curl_easy_perform(_curl);
    // curl_easy_cleanup(_curl);
}


-(void)dealloc{
    curl_easy_cleanup(_curl);
}

size_t icomet_callback1(char *ptr, size_t size, size_t nmemb, void *userdata)
{
    const size_t sizeInBytes = size*nmemb;
    NSData *data = [[NSData alloc] initWithBytes:ptr length:sizeInBytes];
    
    //利用桥接将非OC对象转换成OC对象
    DutyViewController *vc = (__bridge DutyViewController *)userdata;
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"idc === %@",dic);
    
    if ([dic[@"type"] isEqualToString:@"data"])
    {
        if (dic[@"content"]) {
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"content"]];
            NSData *data1= [str dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic1);
            if (dic1[@"msgdata"]) {
                NSString * type = dic1[@"msgtype"];
                if ([type isEqualToString:@"2"]) {
                    NSArray *arr = dic1[@"msgdata"][@"dutylist"];
                    NSLog(@"%@",arr);
                    NSMutableDictionary *dicArr = [NSMutableDictionary dictionary];
                    [dicArr setValue:arr forKey:@"resultsArr"];
                    [vc getResults:dicArr];
                }
                }
            }
        }
//    if ([dic[@"content"] isEqualToString:@"2"])
//    {
//
//        NSDictionary *dic1 = dic[@"msgdata"];
//        NSArray *arr = dic1[@"dutylist"];
//        NSDictionary *dic2 = arr[0];
//        vc.dutyData = arr;
//        vc.caseCarNo = dic2[@"caseCarNo"];  // 案件车牌号
//        vc.dutyType = dic2[@"dutyType"];    // 责任类型  0-全责 1-无责 2-同责

    return sizeInBytes;
}

-(void)getResults:(NSDictionary *)result{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationController.navigationBar.alpha = 0.5;
        self.dutyData = result[@"resultsArr"];
        _bacView.hidden = NO;
        _noGiveUpView.hidden = NO;
        _sureButton.hidden = NO;
        _imageView.hidden = YES;
        _backgroundImageView.hidden = YES;
        _giveUpGuideButton.hidden = YES;
    });
    
}

- (IBAction)giveUp:(id)sender {

    self.navigationController.navigationBar.alpha = 0.5;
    _imageView.hidden = YES;
    _giveUpGuideButton.hidden = YES;
    _backgroundImageView.hidden = YES;
    _giveUpWarnView.hidden = NO;
    _noGiveUpButton.hidden = NO;
    _giveupButton.hidden = NO;
     _bacView.hidden = NO;
    
}

- (IBAction)noGiveUp:(id)sender {
    
    self.navigationController.navigationBar.alpha = 1.0;
    _imageView.hidden = NO;
    _backgroundImageView.hidden = NO;
    _giveUpGuideButton.hidden = NO;
    _giveUpWarnView.hidden = YES;
    _noGiveUpButton.hidden = YES;
    _giveupButton.hidden = YES;
    _bacView.hidden = YES;
    
}

- (IBAction)giveUpGuide:(id)sender {
    self.navigationController.navigationBar.alpha = 1.0;
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"YYYY-MM-DD HH:MM:SS";
    NSString *time = [fmt stringFromDate:date];
    
    
     NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    [bean setValue:_appcaseno forKey:@"appcaseno"];
    [bean setValue:_phoneNumber forKey:@"appphone"];
    [bean setValue:@"1" forKey:@"casestate"];
    [bean setValue:time forKey:@"statedate"];
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitcanel",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        NSDictionary *dic = result;
        NSString *restate = dic[@"restate"];
      //  NSLog(@"%@",dic);
        if ([restate isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            NSLog(@"%@",dic[@"redes"]);
        }
    }];
  
}

- (IBAction)resultSure:(id)sender {
    self.navigationController.navigationBar.alpha = 1.0;
    _noGiveUpView.hidden = YES;
    _giveUpWarnView.hidden = YES;
    _sureButton.hidden = YES;
    _imageView.hidden = NO;
     _backgroundImageView.hidden = NO;
    _giveUpGuideButton.hidden = NO;
    _bacView.hidden = YES;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Controversial" bundle:nil];
    ControversialController *controVC = [storyboard instantiateViewControllerWithIdentifier:@"controversialID"];
    controVC.hidesBottomBarWhenPushed = YES;
    controVC.dutyData = self.dutyData;
    controVC.usInfoDict = self.usInfoDict;
    controVC.otherInfoDict = self.otherInfoDict;
    controVC.thirdInfoDict = self.thirdInfoDict;
    controVC.dataSource = self.dataSource;
    controVC.describeData = self.describeData;
    controVC.appcaseno = self.appcaseno;
    controVC.describeString = self.describeString;
    controVC.usCompanyCode = self.usCompanyCode;
    controVC.otherCompanyCode = self.otherCompanyCode;
    controVC.thirdCompanyCode = self.thirdCompanyCode;
    [self.navigationController pushViewController:controVC animated:YES];
    
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
