//
//  UISelectListView.m
//  UISelectListViewDemo
//
//  Created by 程三 on 15/12/3.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "UISelectListView.h"

@implementation UISelectListView

#pragma mark 构造：view为当前控制的self.view
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        show = false;
        dropWidth = 0;
        [self _initView];
    }
    return self;
}

#pragma mark 初始化UI
-(void)_initView
{
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    contentLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 30, self.frame.size.height)];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    
    iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 25, (self.frame.size.height-20)/2, 20, 20)];
    [self addSubview:iconImage];
}

#pragma mark 设置图标
-(void)setIcon:(UIImage *)image
{
    if(nil == image || iconImage == nil)
    {
        return;
    }
    
    iconImage.image = image;
}

#pragma mark 添加Item内容
-(void)addItem:(NSDictionary *)dic forKey:(NSString *)key
{
    titleKey = key;
    if(nil == array)
    {
        array = [[NSMutableArray alloc] init];
    }
    
    [array addObject:dic];
}

#pragma mark 选中的下标值
-(void)setSelectIndex:(int)index
{
    if(nil == titleKey || [@"" isEqualToString:titleKey])
    {
        return;
    }
    
    if(array != nil &&  array.count > selectIndex)
    {
        NSDictionary *dic = [array objectAtIndex:index];
        if(nil != dic)
        {
            NSString *str = [dic objectForKey:titleKey];
            contentLabel.text = str;
        }
    }
}

#pragma mark 点击回调函数
-(void)onClick:(UIButton *)btn
{
    if(self.currentView == nil)
    {
        return;
    }
    
    if(bodyView == nil)
    {
        bodyView = [UIButton buttonWithType:UIButtonTypeCustom];
        bodyView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        bodyView.alpha = 0.5;
        bodyView.backgroundColor = [UIColor blackColor];
        [bodyView addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        table = [[UITableView alloc] initWithFrame:CGRectZero];
        table.backgroundColor = [UIColor whiteColor];
        table.delegate = self;
        table.dataSource = self;
        //table.layer.borderWidth = 1;
        //table.layer.borderColor = [UIColor grayColor].CGColor;
        //table.layer.masksToBounds = YES;
        
    }
    
    
    if(show)
    {
        if([bodyView superview])
        {
            [bodyView removeFromSuperview];
        }
        if([table superview])
        {
            [table removeFromSuperview];
        }
    }
    else
    {
        int tableViewWidth = self.frame.size.width;
        if(dropWidth > self.frame.size.width)
        {
            tableViewWidth = dropWidth;
        }
        int tableViewHeight = 200;
        
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        CGRect rect=[self convertRect: self.bounds toView:window];
        
        //设置tableView的位置
        if([UIScreen mainScreen].bounds.size.height - (rect.origin.y + self.frame.size.height) < 200)
        {
            table.frame = CGRectMake(rect.origin.x, [UIScreen mainScreen].bounds.size.height - 200, tableViewWidth, tableViewHeight);
        }
        else
        {
            table.frame = CGRectMake(rect.origin.x, rect.origin.y + self.frame.size.height, tableViewWidth, tableViewHeight);
        }
        
        [self.currentView.window addSubview:bodyView];
        [self.currentView.window addSubview:table];
        
        
    }
    
    show = !show;
}

#pragma mark 设置是否可以切换
-(void)setCanEdit:(BOOL)b
{
    if(nil != iconImage)
    {
        iconImage.hidden = !b;
    }
    
    self.enabled = b;
}

#pragma mark 设置下拉UI的宽度
-(void)setDropWidth:(int)width
{
    dropWidth = width;
}


#pragma mark 添加数组，数组里面的对象只能是字典
-(void)addArray:(NSArray *)myArray forKey:(NSString *)key
{
    titleKey = key;
    if(nil == array)
    {
        array = [[NSMutableArray alloc] init];
    }
    
    [array addObjectsFromArray:myArray];
}

#pragma mark 设置显示字体大小
-(void)setShowLabelSize:(UIFont *)font
{
    if(nil == font)
    {
        return;
    }
    if(nil != contentLabel)
    {
        contentLabel.font = font;
    }
}

#pragma mark 设置显示字体的颜色
-(void)setShowLabelColor:(UIColor *)color
{
    if(nil == color)
    {
        return;
    }
    if(nil != contentLabel)
    {
        contentLabel.textColor = color;
    }
}

#pragma mark UITableView 代理回调函数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(nil != array)
    {
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *identify = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
//    }
    static NSString *identify = @"cell";
    UISelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UISelectCell" owner:self options:nil] lastObject];
    }
    
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    if(nil != dic && nil != titleKey)
    {
        cell.contentLabel.text = [dic objectForKey:titleKey];
    }
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    if(nil != dic)
    {
        contentLabel.text = [dic objectForKey:titleKey];
    }
    [self onClick:bodyView];
    if(self.delegate != nil)
    {
        [self.delegate selectListView:self index:indexPath.row content:dic];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UISelectCell *cell = (UISelectCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    NSString *str = [dic objectForKey:titleKey];
    if(nil != cell && nil != str)
    {
        int height = [cell getHeightForStr:str width:tableView.frame.size.width];
        if(height > 40)
        {
            return height + 1;
        }
    }
    return 40;

}

@end
