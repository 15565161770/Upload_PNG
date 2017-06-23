//
//  TWProgressView.m
//  UPLoad2.0
//
//  Created by Apple on 16/12/6.
//  Copyright © 2016年 仝兴伟. All rights reserved.
//

#import "TWProgressView.h"
#import "UIView+Extension.h"
#import "UILabel+Extension.h"

@interface TWProgressView()

@end
@implementation TWProgressView

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        self.contentView = contentView;
        self.contentView.y = 64;
        self.contentView.x = 8;
        self.contentView.width = self.width;
        self.contentView.height = self.height - 64;
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark -- 画圆
- (void)drawRect:(CGRect)rect{
    //设置圆弧的半径
    CGFloat radius = rect.size.width * 0.5;
    //设置圆弧的圆心
    CGPoint center = CGPointMake(radius, radius);
    //设置圆弧的开始的角度（弧度制）
    CGFloat startAngle = - M_PI_2;
    //设置圆弧的终止角度
    CGFloat endAngle = - M_PI_2 + 2 * M_PI * self.progress;
    //使用UIBezierPath类绘制圆弧
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius - 5 startAngle:startAngle endAngle:endAngle clockwise:YES];
    //将绘制的圆弧渲染到图层上（即显示出来）
    [path stroke];
}

#pragma mark -- 设置中间label
-(void)layoutSubviews {
    [super addSubview:self.centerLabel];
    self.centerLabel.textColor = [UIColor blackColor];
    self.centerLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.centerLabel];
}

-(UILabel *)centerLabel {
    if(!_centerLabel)
    {
        _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/2)];
        _centerLabel.center = CGPointMake(WIDTH/2, HEIGHT/2);
        _centerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLabel;
}

@end
