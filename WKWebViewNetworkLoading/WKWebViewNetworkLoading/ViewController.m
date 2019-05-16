//
//  ViewController.m
//  WKWebViewNetworkLoading
//
//  Created by tq001 on 2019/5/16.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "ViewController.h"
#import "NullDataView.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate, WKNavigationDelegate>
/**
 WKWebView
 */
@property (strong, nonatomic) WKWebView *wbView;
/**
 没有数据展示的视图
 */
@property (strong, nonatomic) NullDataView *nullView;
/**
 用来判断是否加载完成
 */
@property(nonatomic,assign)BOOL network;
@end

@implementation ViewController
#pragma mark 懒加载
- (NullDataView *)nullView {
    if (!_nullView) {
        _nullView = [[NullDataView alloc] initWithFrame:self.view.bounds];
    }
    return _nullView;
}

- (WKWebView *)wbView {
    if (!_wbView) {
        WKWebViewConfiguration *cf = [[WKWebViewConfiguration alloc] init];
        _wbView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:cf];
        _wbView.UIDelegate = self;
        _wbView.navigationDelegate = self;
    }
    return _wbView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.wbView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *qt = [NSURLRequest requestWithURL:url];
    [self.wbView loadRequest:qt];
    
    __weak typeof(self)weakSelf = self;
    //耗时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.network == NO) {
            //如果5秒过后未加载成功，在这里可以取消转圈圈的第三方控件，这里就不做演示了，但是显示空视图还是可以的。
            self.wbView.hidden = YES;
            self.nullView.hidden = NO;
        }
    });
    
    //添加子视图
    [self addSubviews];
    
}

/**
 添加子视图
 */
- (void)addSubviews {
    //子视图到父类视图
    [self.view addSubview:self.wbView];
    [self.view addSubview:self.nullView];
    
    //第一次加载，隐藏空视图，显示wbView
    self.nullView.hidden = YES;
    self.wbView.hidden = NO;
}

#pragma mark WKUIDelegate, WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //加载WKWebView的时候，在这里可以弄一个转圈圈的第三方控件，这里就不做演示了
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //加载WKWebView失败的时候，在这里可以取消转圈圈的第三方控件，这里就不做演示了
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //加载WKWebView完成的时候，在这里可以取消转圈圈的第三方控件，这里就不做演示了
    
    //这里配合延时执行 模拟 加载延时  在规定的时间没有加载完成 就是加载失败
    self.network=YES;
}



@end
