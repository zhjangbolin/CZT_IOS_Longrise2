//
//  InfoViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoSectionOneCell.h"
#import "InfoSectionTwoCell.h"
#import "CZT_IOS_Longrise.pch"
#import "PersonInfoModel.h"
#import "UIImageView+WebCache.h"
@interface InfoViewController ()
<UITableViewDataSource,
UITableViewDelegate>
{
    UITableView *table;
    NSArray *sectionTitleOne;
    NSArray *sectionTitleTwo;
    NSArray *iconAry;
    
    PersonInfoDataModel *dataModel;
}
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人信息";
    sectionTitleOne = @[@"头像",@"昵称",@"真实姓名",@"驾驶证号"];
    sectionTitleTwo = @[@"手机",@"微信",@"QQ",@"微博"];
    iconAry = @[@"icon17",@"icon18",@"icon19",@"icon20"];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:table];
    
    
    [table registerNib:[UINib nibWithNibName:@"InfoSectionOneCell" bundle:nil] forCellReuseIdentifier:@"InfoSectionOneCell"];
    
    [table registerNib:[UINib nibWithNibName:@"InfoSectionTwoCell" bundle:nil] forCellReuseIdentifier:@"InfoSectionTwoCell"];
    
    [self loadPersonInfoData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载个人信息
-(void)loadPersonInfoData{
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
    NSString *userflag = [userdic objectForKey:@"userflag"];
    [bean setValue:userflag forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];

    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,baseapp];
    
    [[Globle getInstance].service requestWithServiceIP:url  ServiceName:@"appsearchpersoninfo" params:bean httpMethod:@"POST"resultIsDictionary:YES completeBlock:^(id result) {
        
        if (nil != result) {
            
            NSLog(@"个人信息%@",[Util objectToJson:result]);
            PersonInfoModel *model = [[PersonInfoModel alloc]initWithString:[Util objectToJson:result] error:nil];
            dataModel = model.data;
            
            [table reloadData];
            
        }
        
    }];

    
}

#pragma mark - tableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        InfoSectionOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoSectionOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLab.text = sectionTitleOne[indexPath.row];
        if (indexPath.row == 0) {
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-60, 2, 50, 50)];
//            imageV.image = [UIImage imageNamed:@"icon07"];
            [imageV sd_setImageWithURL:[NSURL URLWithString:dataModel.photo]];
            [cell.contentView addSubview:imageV];
            cell.rightLab.hidden = YES;
        }
        else if (indexPath.row == 1){
            cell.rightLab.text = _name;
        }
        else if (indexPath.row == 2){
            cell.rightLab.text = dataModel.showname;
        }
        else{
            cell.rightLab.text = dataModel.cardno;
        }
        
        return cell;
    }
    else{
        InfoSectionTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoSectionTwoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = sectionTitleTwo[indexPath.row];
        cell.icon.image = [UIImage imageNamed:iconAry[indexPath.row]];
        if (indexPath.row == 0) {
            cell.rightLab.textColor = [UIColor blackColor];
            cell.rightLab.text = _phoneNum;
        }
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return 60;
        
    }
    else return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.000001;
    }
    else return 30;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"账号绑定";
    }
    
    else return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }
    else{
        
    }
    
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
