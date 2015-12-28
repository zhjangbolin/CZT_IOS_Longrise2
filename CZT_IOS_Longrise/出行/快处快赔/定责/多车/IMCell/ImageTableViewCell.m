//
//  ImageTableViewCell.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/8.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "Photo.h"
#import "PhotoFrame.h"
#import "UIImage+Resize.h"

@interface ImageTableViewCell ()
@property (nonatomic,strong)UIButton *timeBtn;
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UIButton *contentBtn;
@end

@implementation ImageTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        [_contentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_contentBtn];
        
        // 4、初始化菊花
        _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_indicator];
    }
    
    return self;
}

-(void)setMessageFrame:(PhotoFrame *)messageFrame{
    _messageFrame = messageFrame;
    Photo *message = _messageFrame.message;
    
    // 1、设置时间
    [_timeBtn setTitle:message.time forState:UIControlStateNormal];
    
    _timeBtn.frame = _messageFrame.timeF;
    
    // 2、设置头像
    _iconView.image = [UIImage imageNamed:message.icon];
    _iconView.frame = _messageFrame.iconF;
    
    // 3、设置内容
    _contentBtn.userInteractionEnabled = NO;
    _contentBtn.layer.masksToBounds = YES;
   // _contentBtn.layer.cornerRadius = 100;
    
    
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(ContentTop, ContentLeft + 18                  , ContentBottom - 8, ContentRight);
    _contentBtn.frame = _messageFrame.contentF;
    
    if (message.type == PhotoTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(ContentTop, ContentRight - 18, ContentBottom - 8, ContentLeft);
    }
    message.content = [message.content cutImageWithRadius:8];
    [_contentBtn setImage:message.content forState:UIControlStateNormal];
    UIImage *normal = [[UIImage alloc]init];
    //    UIImage *focused = [[UIImage alloc]init];
    if (message.type == PhotoTypeMe) {
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
