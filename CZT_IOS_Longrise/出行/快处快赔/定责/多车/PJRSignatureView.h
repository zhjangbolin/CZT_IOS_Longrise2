//
//  PJRSignatureView.h
//  qianming
//
//  Created by 张博林 on 15/11/30.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJRSignatureView : UIView{

    CAShapeLayer *shapeLayer;
}
@property (nonatomic,strong)UILabel *lblSignature;
//返回的图片
- (UIImage *)getSignatureImage;
- (void)clearSignature;
@end
