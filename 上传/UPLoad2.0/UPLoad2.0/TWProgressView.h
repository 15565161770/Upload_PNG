//
//  TWProgressView.h
//  UPLoad2.0
//
//  Created by Apple on 16/12/6.
//  Copyright © 2016年 仝兴伟. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
@interface TWProgressView : UIView

@property (nonatomic, assign)CGFloat progress;
@property (nonatomic, strong) UILabel *centerLabel; /**< 记录进度的Label*/
@property (nonatomic, strong) UIView *contentView; /** 用于最底层的遮盖*/

@end
