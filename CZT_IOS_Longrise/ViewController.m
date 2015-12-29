//
//  ViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create the data model
    //_pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
    //_pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    GuidePageViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}


- (GuidePageViewController *)viewControllerAtIndex:(NSUInteger)index
{
//    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
//        return nil;
//    }
    
    if (index >= 2)
    {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    GuidePageViewController *pageContentViewController = nil;
    switch (index) {
        case 0:
        {
            pageContentViewController = [[FirstGuideViewController alloc] init];
            break;
        }
        case 1:
        {
            pageContentViewController = [[SecondViewController alloc] init];
             break;
        }
    }
    
    if(nil != pageContentViewController)
    {
        pageContentViewController.pageIndex = index;
    }
    
    return pageContentViewController;
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((GuidePageViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
//    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    NSUInteger index = ((GuidePageViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
//    if (index == [self.pageTitles count]) {
//        return nil;
//    }
    if (index == 2)
    {
        return nil;
    }

    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    //return [self.pageTitles count];
    return 2;

}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
