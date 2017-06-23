//
//  HMStatusToolbar.h
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//  封装底部的工具条

#import <UIKit/UIKit.h>
typedef enum {
    HMComposeToolbarleft, // 转发
    HMComposeToolbarButtonTypemodel, // 点赞
    HMComposeToolbarButtonTyperight // 评论
} HMComposeToolbarButtonType;

@class HMStatusToolbar;
@protocol HMStatusToolbarDelegate <NSObject>

@optional
- (void)composeTool:(HMStatusToolbar *)toolbar didClickedButton:(HMComposeToolbarButtonType)buttonType;

@end
@interface HMStatusToolbar : UIImageView
@property (nonatomic, weak) id<HMStatusToolbarDelegate> delegate;

@end
