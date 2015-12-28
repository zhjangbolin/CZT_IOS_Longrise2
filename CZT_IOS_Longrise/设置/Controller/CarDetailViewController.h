//
//  CarDetailViewController.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/15.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarDetailViewController <NSObject>
@required
-(void)CarDetailViewControllerClose:(UIViewController *)viewController success:(BOOL)b;
@end

@interface CarDetailViewController : UIViewController

@property(nonatomic,assign)BOOL isShowController;
@property(nonatomic,copy)NSString *controllerName;
@property (nonatomic, assign)   id <CarDetailViewController> loginControllerClose;


@property (nonatomic, copy) NSString *Id;
@end
