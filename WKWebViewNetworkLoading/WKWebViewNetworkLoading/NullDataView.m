//
//  NullDataView.m
//  WKWebViewNetworkLoading
//
//  Created by tq001 on 2019/5/16.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "NullDataView.h"

/**
 *  屏幕宽、高
 */
#define FSScreenW [UIScreen mainScreen].bounds.size.width
#define FSScreenH [UIScreen mainScreen].bounds.size.height

#define iconWH 60
#define labelW FSScreenW * 0.8
#define labelH 50

@implementation NullDataView
#pragma mark 懒加载
- (UIImageView *)icon {
    if (!_icon) {
        CGFloat x = FSScreenW / 2 - iconWH / 2;
        CGFloat y = FSScreenH / 2 - iconWH;
        CGRect frame = CGRectMake(x, y, iconWH, iconWH);
        _icon = [[UIImageView alloc] initWithFrame:frame];
        _icon.image = [UIImage imageNamed:@"nullDataIcon"];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        CGFloat x = FSScreenW / 2 - labelW / 2;
        CGFloat y = CGRectGetMaxY(self.icon.frame);
        CGRect frame = CGRectMake(x, y, labelW, labelH);
        _nameLabel = [[UILabel alloc] initWithFrame:frame];
        _nameLabel.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"暂无数据";
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加子视图
        [self addSubviews];
    }
    return self;
}

#pragma mark 设置UI界面
/**
 添加子视图
 */
- (void)addSubviews {
    //1、添加图标
    [self addSubview:self.icon];
    
    //2、添加Label
    [self addSubview:self.nameLabel];
    
}

@end
