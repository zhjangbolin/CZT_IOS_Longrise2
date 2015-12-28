//
//  AccidentPhotoViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "AccidentPhotoViewController.h"
#import "Globle.h"
#import "UIImageView+WebCache.h"
#import <Masonry.h>
#import "AccidentPhotoTableViewCell.h"
#import "CZT_IOS_Longrise.pch"
#import "FVCustomAlertView.h"
#import "SJAvatarBrowser.h"

@interface AccidentPhotoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    FVCustomAlertView * alertView;
}

@property (nonatomic,strong)NSMutableArray *dataList;

@property (weak, nonatomic) IBOutlet UITableView *PhotoTableView;
@end

@implementation AccidentPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
        //self.isShowController = true;
    }
    return self;
}

#pragma mark -
#pragma mark - 配置UI
-(void)configUI{
    self.title = @"事故影像";
    [_PhotoTableView registerNib:[UINib nibWithNibName:@"AccidentPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"accidentCell"];
    alertView = [[FVCustomAlertView alloc]init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:alertView];
}

#pragma mark -
#pragma mark - 数据请求
-(void)requestData{
    _dataList = [NSMutableArray array];
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
   // [bean setObject:@"110101201512180009" forKey:@"casenumber"];
     [bean setObject:_casenumber forKey:@"casenumber"];
    //[bean setObject:@"15071440127" forKey:@"appphone"];
    [bean setObject:_appphone forKey:@"appphone"];
    [bean setObject:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setObject:[Globle getInstance].loadDataPass forKey:@"password"];
   // NSString *ServiceUrl = @"http://192.168.3.229:86/KCKP/restservices/kckpzcslrest/";
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat: @"%@/zdsearchcasedetailinfo",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        NSDictionary *dic = result;
        if ([dic[@"restate"]isEqualToString:@"0"]) {
            if (dic[@"data"]) {
               // NSLog(@"%@",dic[@"data"]);
                if (nil!=dic[@"data"][@"accidentimagelist"]) {
                    //  NSLog(@"--------------------------------%@",dic[@"data"][@"accidentimagelist"]);
                    @try {
                        NSArray *accidentimagelist = dic[@"data"][@"accidentimagelist"];
                        for (NSDictionary *dic1 in accidentimagelist) {
                            [_dataList addObject:dic1];
                        }
                      //  NSLog(@"%@",dic[@"data"][@"accidentimagelist"]);
                        [_PhotoTableView reloadData];
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                   
                }
                
            }else{
                NSLog(@"%@",dic[@"redes"]);
            }
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"加载失败，请确认网络是否开启！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            NSLog(@"请求数据失败");
            NSLog(@"%@",dic[@"redes"]);
        }
        [alertView dismiss];
    }];
}

#pragma mark - 
#pragma mark - tableView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccidentPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accidentCell" forIndexPath:indexPath];
    NSDictionary *dic = _dataList[indexPath.row];
    [cell.carPhotoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imageurl"]]placeholderImage:[UIImage imageNamed:@"beijing_ico05"]];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(magnifyImage:)];
//    [cell.carPhotoImageView addGestureRecognizer:tap];
    cell.photoLocationLabel.text = dic[@"imagetypename"];
    return cell;
}

//- (void)magnifyImage:(UITapGestureRecognizer *)tap
//{
//    NSLog(@"1111111111");
//    [SJAvatarBrowser showImage:(UIImageView *)tap.view];//调用方法
//}

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
