//
//  MaintainViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "MaintainViewController.h"
#import "CZT_IOS_Longrise.pch"
#import "SGCLViewController.h"
#import "HMSegmentedControl.h"
#import "CWStarRateView.h"
#import "QYTableViewCell.h"
#import "WXTableViewCell.h"
#import "QYDetailViewController.h"
#import "AddCarViewController.h"
#import "MJRefresh.h"
#import "HealthRecordViewController.h"
#import "QYModel.h"
#import "WXModel.h"
#import "LoginViewController.h"
#import "QYSearchViewController.h"
#import "WXSearchViewController.h"
@interface MaintainViewController ()
<UIScrollViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
UIAlertViewDelegate,
LoginControllerClose>

{
    UITableView *qyTable;
    UITableView *wxTable;
    UISearchBar *qySearch;
    UISearchBar *wxSearch;
    NSMutableArray *qyDataArray;
    NSMutableArray *wxDataArray;
    
    NSInteger enterPrisePage;
    NSInteger carPage;
    NSMutableDictionary *enterpriseBean;
    NSMutableDictionary *carBean;
    
    QYModel *qyModel;
    WXModel *wxModel;
    
    UIView *wxBackView;
    UIView *qyBackView;
    
}

@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"WXviewDidLoad");
    self.view.backgroundColor = [UIColor whiteColor];
    qyDataArray = [NSMutableArray array];
    wxDataArray = [NSMutableArray array];
    enterpriseBean = [[NSMutableDictionary alloc]init];
    carBean = [[NSMutableDictionary alloc]init];
    enterPrisePage = 1;
    carPage = 1;
    
    [AppDelegate storyBoradAutoLay:self.view];
    self.title = @"维修";
    
    //设置导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = NavColor;
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    logoView.image = [UIImage imageNamed:@"sub_logo"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logoView];
    
    
    [self initScroll];
    
    [self initSegmentControl];
    
    if([Globle getInstance].loginInfoDic == nil){
        [self addWarmTip];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"本功能需要登录才能使用，请您登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self initTableView];
        [self loadEnterPriseData];
        [self loadCarData];
    }
    
}

#pragma mark - alertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        LoginViewController *loginVC = [LoginViewController new];
        loginVC.isShowController = false;
        loginVC.loginControllerClose = self;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

#pragma mark - 初始化segmentControl
-(void)initSegmentControl{

    _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    _segmentControl.sectionTitles = @[@"找企业",@"维修记录"];
    _segmentControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : NavColor};
    _segmentControl.selectionIndicatorColor = NavColor;
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorHeight = 2.0;
    [self.view addSubview:_segmentControl];
    
    __weak typeof(self) weakSelf = self;
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, weakSelf.view.frame.size.width, 220) animated:YES];
        
    }];
    
    
    qySearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth,30)];
    qySearch.placeholder = @"请输入关键字";
    qySearch.backgroundColor = [UIColor whiteColor];
    qySearch.searchBarStyle = UISearchBarStyleMinimal;
    qySearch.delegate = self;
    [_scrollView addSubview:qySearch];
    
    wxSearch = [[UISearchBar alloc]initWithFrame:CGRectMake(ScreenWidth, 5, ScreenWidth,30)];
    wxSearch.placeholder = @"请输入关键字";
    wxSearch.backgroundColor = [UIColor whiteColor];
    wxSearch.searchBarStyle = UISearchBarStyleMinimal;
    wxSearch.delegate = self;
    [_scrollView addSubview:wxSearch];
    
}

#pragma mark - 初始化scrollView
-(void)initScroll{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-146)];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight-146);
    self.scrollView.pagingEnabled = YES;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
}

#pragma mark - 增加登录提示
-(void)addWarmTip{
    
    for (int i=0; i<2; i++) {
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, ScreenWidth-30, 20)];
        lab.font = [UIFont systemFontOfSize:13];
        lab.text = @"您当前还未登录，没有办法获取数据噢~";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor darkGrayColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(lab.center.x-40, CGRectGetMaxY(lab.frame)+10, 80, 28);
        [btn setTitle:@"现在登录" forState:UIControlStateNormal];
        [btn setTitleColor:NavColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(jumpToLogin) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.font    = [UIFont systemFontOfSize:13];
        btn.layer.cornerRadius = 3;
        btn.layer.borderColor  = NavColor.CGColor;
        btn.layer.borderWidth  = 0.5;
        
        if (i==0) {
            qyBackView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, _scrollView.frame.size.height)];
            [qyBackView addSubview:lab];
            [qyBackView addSubview:btn];
        }
        else{
            wxBackView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, _scrollView.frame.size.height)];
            [wxBackView addSubview:lab];
            [wxBackView addSubview:btn];
        }
        [_scrollView addSubview:qyBackView];
        [_scrollView addSubview:wxBackView];
    }
    
}

#pragma mark - 跳转到登陆页
-(void)jumpToLogin{

    LoginViewController *vc = [LoginViewController new];
    vc.title = @"增加车辆";
    vc.isShowController = false;
    vc.loginControllerClose = self;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 登陆页代理方法
-(void)LoginControllerClose:(UIViewController *)viewController success:(BOOL)b{
    
    if (b) {
        [wxBackView removeFromSuperview];
        [qyBackView removeFromSuperview];
        [self initTableView];
        [self loadEnterPriseData];
        [self loadCarData];
    }

}

#pragma mark - 初始化tableView
-(void)initTableView{
    
    qyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(qySearch.frame)+5, ScreenWidth, _scrollView.frame.size.height-qySearch.frame.size.height-13) style:UITableViewStyleGrouped];
    qyTable.delegate = self;
    qyTable.dataSource = self;
    [_scrollView addSubview:qyTable];
    UINib *nib1 = [UINib nibWithNibName:@"QYTableViewCell" bundle:nil];
    [qyTable registerNib:nib1 forCellReuseIdentifier:@"QYTableViewCell"];
    
    qyTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshEnterPriseData];
        [qyTable.mj_header endRefreshing];
        
    }];
    
    qyTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [self loadMoreEnterPriseData];
        [qyTable.mj_footer endRefreshing];
        
    }];
    
    
    wxTable = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, CGRectGetMaxY(wxSearch.frame)+5, ScreenWidth, _scrollView.frame.size.height-wxSearch.frame.size.height-8) style:UITableViewStyleGrouped];
    wxTable.delegate = self;
    wxTable.dataSource = self;
    [_scrollView addSubview:wxTable];
    UINib *nib2 = [UINib nibWithNibName:@"WXTableViewCell" bundle:nil];
    [wxTable registerNib:nib2 forCellReuseIdentifier:@"WXTableViewCell"];
    
    wxTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshCarData];
        [wxTable.mj_header endRefreshing];
        
    }];
    
    wxTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreCarData];
        [wxTable.mj_footer endRefreshing];
    }];
    
}

#pragma mark - 查询企业列表

-(void)loadEnterPriseData{

//    NSLog(@"[areaid -> %@ ",[Globle getInstance].areaid);
    [enterpriseBean setValue:@"420100000000000000" forKey:@"areaid"];
    [enterpriseBean setValue:@"" forKey:@"companyname"];//留空
    [enterpriseBean setValue:[NSNumber numberWithInteger:enterPrisePage] forKey:@"pagenum"];
    [enterpriseBean setValue:@"5" forKey:@"pagesize"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载";
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appsearchfixcompany" params:enterpriseBean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        if (nil != result) {
            NSString *json = [Util objectToJson:result];
            NSLog(@"企业数据%@",json);
            qyModel = [[QYModel alloc]initWithString:json error:nil];
            [qyDataArray addObjectsFromArray:qyModel.data];
            [qyTable reloadData];
        }
    } ];
}

#pragma mark - 刷新企业数据
-(void)refreshEnterPriseData{
    
    [qyDataArray removeAllObjects];
    [qyTable reloadData];
    enterPrisePage = 1;
    [enterpriseBean setValue:[NSNumber numberWithInteger:enterPrisePage] forKey:@"pagenum"];
    [self loadEnterPriseData];
}

#pragma mark - 加载更多企业数据
-(void)loadMoreEnterPriseData{
    
    enterPrisePage ++;
    if (enterPrisePage>4) {
        qyTable.mj_footer.hidden = YES;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"没有更多数据啦";
        [hud hide:YES afterDelay:2.0];
    }
    else{
        [enterpriseBean setValue:[NSNumber numberWithInteger:enterPrisePage] forKey:@"pagenum"];
        [self loadEnterPriseData];
    }
}

#pragma mark - 查询车辆维修记录
-(void)loadCarData{
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
    NSString *userflag = [userdic objectForKey:@"userflag"];
    NSString *areaid = [Globle getInstance].areaid;
    
    [carBean setValue:@"huxl" forKey:@"userflag"];
    [carBean setValue:token forKey:@"token"];
    [carBean setValue:[NSNumber numberWithInteger:carPage] forKey:@"pagenum"];
    [carBean setValue:@"5" forKey:@"pagesize"];
    [carBean setValue:@"" forKey:@"carno"];
    [carBean setValue:areaid forKey:@"areaid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    
    NSLog(@"carBean%@",carBean);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载";
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appsearchrepairrecordlist" params:carBean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        NSLog(@"result%@",result);
        if (nil != result) {
            NSString *json = [Util objectToJson:result];
            NSLog(@"车辆数据%@",json);
            wxModel= [[WXModel alloc]initWithString:json error:nil];
            NSLog(@"车辆模型个数%ld",wxModel.data.count);
            [wxDataArray addObjectsFromArray:wxModel.data];
            [wxTable reloadData];
        }
    } ];
}

#pragma mark - 刷新车辆维修记录
-(void)refreshCarData{
    
    [wxDataArray removeAllObjects];
    [wxTable reloadData];
    carPage = 1;
    [carBean setValue:[NSNumber numberWithInteger:carPage] forKey:@"pagenum"];
    [self loadCarData];
}

#pragma mark - 加载更多车辆维修记录
-(void)loadMoreCarData{

    carPage ++;
    if (carPage>4) {
        wxTable.mj_footer.hidden = YES;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"没有更多数据啦";
        [hud hide:YES afterDelay:2.0];
    }
    else{
        [carBean setValue:[NSNumber numberWithInteger:carPage] forKey:@"pagenum"];
        [self loadCarData];
    }
}



#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - searchBar Delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
   
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    NSLog(@"searchText -> %@",searchText);
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    if (searchBar == qySearch) {
        NSLog(@"开始搜索企业");
        QYSearchViewController *qyVC = [QYSearchViewController new];
        qyVC.qyDataArray = [NSMutableArray arrayWithArray:qyDataArray];
        qyVC.searchString = qySearch.text;
        [self.navigationController pushViewController:qyVC animated:YES];
        [qySearch resignFirstResponder];
    }
    else{
        NSLog(@"开始搜索维修");
        WXSearchViewController *wxVC = [WXSearchViewController new];
        wxVC.wxDataArray = [NSMutableArray arrayWithArray:wxDataArray];
        wxVC.searchString = wxSearch.text;
        [self.navigationController pushViewController:wxVC animated:YES];
        [wxSearch resignFirstResponder];
    }
}


#pragma mark - scrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //对scroll进行判断，避免误操作
    if (scrollView == _scrollView) {
        NSInteger scrollPage = scrollView.contentOffset.x/ScreenWidth;
        [self.segmentControl setSelectedSegmentIndex:scrollPage animated:YES];

    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [wxSearch resignFirstResponder];
    [qySearch resignFirstResponder];
}

#pragma mark - tableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == qyTable) {
        return 1;
    }
    else{
        return wxDataArray.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == qyTable) {
        return qyDataArray.count;
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == qyTable) {
        
        QYTableViewCell *cell = (QYTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QYTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ResultModel *model = qyDataArray[indexPath.row];
        [cell setUIWithInfo:model];
        return cell;
        
    }
    else{
        
        WXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WXTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.checkHealth.userInteractionEnabled = NO;
        CarModel *carModel = wxDataArray[indexPath.section];
        [cell setUIWithInfo:carModel];
        return cell;
        
    }
}

//补全分割线
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell  respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == qyTable) {
        return 110*SCALE;
    }
    else{
        return 130*SCALE;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == wxTable) {
        return 0.000001;
    }
    else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == wxTable) {
        return 10;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == qyTable) {
        QYDetailViewController *vc = [QYDetailViewController new];
        ResultModel *model = qyDataArray[indexPath.row];
        /**
         *  正向传值，将需要的值传到QYDetailViewController
         */
        vc.title = model.name;
        vc.companyId = model.Id;
        vc.areaId = model.areaid;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        HealthRecordViewController *vc = [HealthRecordViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
