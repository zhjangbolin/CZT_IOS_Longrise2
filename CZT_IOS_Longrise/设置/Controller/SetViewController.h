//
//  SetViewController.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "BaseViewController.h"
#import "PublicViewController.h"

@interface SetViewController : PublicViewController<UITableViewDelegate,UITableViewDataSource>

{

}

@property (strong, nonatomic) UITableView *hometabView;
@property (strong, nonatomic) NSArray *dataSource;
@end
