//
//  UISelectListView.h
//  UISelectListViewDemo
//
//  Created by 程三 on 15/12/3.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISelectCell.h"

@class UISelectListView;

@protocol UISelectListViewDelegate <NSObject>

@required

-(void)selectListView:(UISelectListView *)selectListView index:(NSUInteger)index content:(NSDictionary *)dic;

@end

@interface UISelectListView : UIButton<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    UIButton *bodyView;
    UILabel  *contentLabel;
    UIImageView  *iconImage;
    NSMutableArray *array;
    int      selectIndex;
    BOOL     show;
    int      dropWidth;
    NSString *titleKey;
}

@property(nonatomic,assign) id<UISelectListViewDelegate> delegate;
@property(nonatomic,retain)UIView *currentView;

#pragma mark 选中的下标值
-(void)setSelectIndex:(int)selectIndex;

#pragma mark 添加Item内容
-(void)addItem:(NSDictionary *)dic forKey:(NSString *)key;

#pragma mark 设置图标
-(void)setIcon:(UIImage *)image;

#pragma mark 设置下拉UI的宽度
-(void)setDropWidth:(int)width;

#pragma mark 设置是否可以切换
-(void)setCanEdit:(BOOL)b;

#pragma mark 添加数组，数组里面的对象只能是字典
-(void)addArray:(NSArray *)myArray forKey:(NSString *)key;

#pragma mark 设置显示字体的颜色
-(void)setShowLabelColor:(UIColor *)color;

#pragma mark 设置显示字体大小
-(void)setShowLabelSize:(UIFont *)font;

#pragma mark 设置选中内容的显示方式
-(void)setContentTextAlignment:(int)textAlignment;

@end
