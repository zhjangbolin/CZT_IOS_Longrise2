//
//  ViewController.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstGuideViewController.h"
#import "SecondViewController.h"
#import "GuidePageViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
//@property (strong, nonatomic) NSArray *pageTitles;
//@property (strong, nonatomic) NSArray *pageImages;

@end
