//
//  insuranceViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "insuranceViewController.h"

@interface insuranceViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *insuranceTime;
@property (weak, nonatomic) IBOutlet UILabel *insuranceNumber;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIView *telView;


@end

@implementation insuranceViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    _insuranceTime.text = _casedate;
    _insuranceNumber.text = _insreporttel;
    _timeView.layer.masksToBounds = YES;
    _telView.layer.masksToBounds = YES;
    _timeView.layer.cornerRadius = 5;
    _telView.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)telephoneClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"你要拨打%@吗",_insreporttel] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_insreporttel]]];
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
