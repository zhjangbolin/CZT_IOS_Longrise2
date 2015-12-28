//
//  WXSearchViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "WXSearchViewController.h"
#import "WXTableViewCell.h"
#import "CarModel.h"
#import "HealthRecordViewController.h"
@interface WXSearchViewController ()
<UISearchBarDelegate,
UITableViewDataSource,
UITableViewDelegate>
{
    UITableView *searchTable;
    NSMutableArray *wxSearchData;
    UISearchBar *wxSearch;
}
@end

@implementation WXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"查找维修记录";
    self.view.backgroundColor = [UIColor whiteColor];
    wxSearchData = [NSMutableArray array];
    
    wxSearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth,30)];
    wxSearch.placeholder = @"请输入关键字";
    wxSearch.text = self.searchString;
    wxSearch.backgroundColor = [UIColor whiteColor];
    wxSearch.searchBarStyle = UISearchBarStyleMinimal;
    wxSearch.delegate = self;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:wxSearch];
    [self.view addSubview:backView];
    
    searchTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    searchTable.delegate = self;
    searchTable.dataSource = self;
    searchTable.tableHeaderView = backView;
    [self.view addSubview:searchTable];
    
    
    [searchTable registerNib:[UINib nibWithNibName:@"WXTableViewCell" bundle:nil] forCellReuseIdentifier:@"WXTableViewCell"];
    
    for (CarModel *model in self.wxDataArray) {
        
        if ([model.carno rangeOfString:self.searchString].length != 0) {
            [wxSearchData addObject:model];
//            NSLog(@"model.carno%@",model.carno);
        }
    }
    [searchTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchBar Delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [wxSearchData removeAllObjects];
    for (CarModel *model in self.wxDataArray) {
        
        if ([model.carno rangeOfString:searchBar.text].length != 0) {
            [wxSearchData addObject:model];
            NSLog(@"model.carno%@",model.carno);
        }
    }
    [searchTable reloadData];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return wxSearchData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WXTableViewCell"];
    CarModel *model = wxSearchData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.checkHealth.userInteractionEnabled = NO;
    [cell setUIWithInfo:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130*SCALE;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HealthRecordViewController *vc = [HealthRecordViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [wxSearch resignFirstResponder];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
