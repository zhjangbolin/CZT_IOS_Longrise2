//
//  QYSearchViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "QYSearchViewController.h"
#import "QYDetailViewController.h"
#import "QYTableViewCell.h"
#import "ResultModel.h"
@interface QYSearchViewController ()
<UISearchBarDelegate,
UITableViewDataSource,
UITableViewDelegate>
{
    UITableView *searchTable;
    NSMutableArray *qySearchData;
    UISearchBar *qySearch;
}
@end

@implementation QYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"找企业";
    self.view.backgroundColor = [UIColor whiteColor];
    qySearchData = [NSMutableArray array];
    
    qySearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth,30)];
    qySearch.placeholder = @"请输入关键字";
    qySearch.text = self.searchString;
    qySearch.backgroundColor = [UIColor whiteColor];
    qySearch.searchBarStyle = UISearchBarStyleMinimal;
    qySearch.delegate = self;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:qySearch];
    [self.view addSubview:backView];

    searchTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    searchTable.delegate = self;
    searchTable.dataSource = self;
    searchTable.tableHeaderView = backView;
    [self.view addSubview:searchTable];
    
    [searchTable registerNib:[UINib nibWithNibName:@"QYTableViewCell" bundle:nil] forCellReuseIdentifier:@"QYTableViewCell"];
    
    for (ResultModel *model in self.qyDataArray) {
        
        if ([model.name rangeOfString:self.searchString].length != 0) {
            [qySearchData addObject:model];
        }
    }
    [searchTable reloadData];
}

#pragma mark - searchBar Delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [qySearchData removeAllObjects];
    for (ResultModel *model in self.qyDataArray) {
       
        if ([model.name rangeOfString:searchBar.text].length != 0) {
            [qySearchData addObject:model];
             NSLog(@"model.name%@",model.name);
        }
    }
    [searchTable reloadData];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return qySearchData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QYTableViewCell"];
    ResultModel *model = qySearchData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setUIWithInfo:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110*SCALE;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QYDetailViewController *vc = [QYDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [qySearch resignFirstResponder];
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
