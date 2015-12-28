//
//  WordTableViewCell.m
//  jishitongxun
//
//  Created by 张博林 on 15/12/2.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import "WordTableViewCell.h"
#import "Message.h"
#import "MessageFrame.h"

@interface WordTableViewCell ()
@property (nonatomic,strong)UIButton *timeBtn;
@property (nonatomic,strong)UIImageView *iconView;

@end

@implementation WordTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell的背景色必须先设置为clearColor,否则tableView的背景会被遮住
        self.backgroundColor = [UIColor clearColor];
        
        // 1、创建时间按钮
        _timeBtn = [[UIButton alloc] init];
        [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = kTimeFont;
        _timeBtn.enabled = NO;
        [_timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_timeBtn];
        
        // 2、创建头像
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        
        // 3、创建内容
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _contentBtn.titleLabel.font = kContentFont;
        _contentBtn.titleLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_contentBtn];
        
        // 4、初始化菊花
        _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_indicator];
    }
    return self;
}

-(void)setMessageFrame:(MessageFrame *)messageFrame{
    _messageFrame = messageFrame;
    Message *message = _messageFrame.message;
    
    // 1、设置时间
    [_timeBtn setTitle:message.time forState:UIControlStateNormal];
    
    _timeBtn.frame = _messageFrame.timeF;
    
    // 2、设置头像
    _iconView.image = [UIImage imageNamed:message.icon];
    _iconView.frame = _messageFrame.iconF;
    
    // 3、设置内容
    _contentBtn.userInteractionEnabled = NO;
    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft + 10, kContentBottom, kContentRight);
    _contentBtn.frame = _messageFrame.contentF;
    
    if (message.type == MessageTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight - 13, kContentBottom, kContentLeft);
    }
    UIImage *normal = [[UIImage alloc]init];
//    UIImage *focused = [[UIImage alloc]init];
    if (message.type == MessageTypeMe) {
        normal = [UIImage imageNamed:@"picon06.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        _indicator.center = CGPointMake(_messageFrame.contentF.origin.x - 10, _messageFrame.contentF.origin.y + _messageFrame.contentF.size.height/2);
        [_indicator startAnimating];

    }else{
        
        normal = [UIImage imageNamed:@"picon07.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
    }
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
   // [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
   
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
