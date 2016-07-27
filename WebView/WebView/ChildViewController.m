//
//  ChildViewController.m
//  WebView
//
//  Created by Marlon David Ruiz Arroyave on 7/22/16.
//  Copyright © 2016 nextU. All rights reserved.
//

#import "ChildViewController.h"


@interface ChildViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

static NSString* urlString = @"http://test.stratalogica.com/NystromDigital/static/Flex/atlases/";

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.indexLabel.text = [NSString stringWithFormat:@"Screen #%ld", (long)self.index];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    self.path = [urlString stringByAppendingPathComponent:self.path];
    
    _webView.scrollView.scrollEnabled = NO;
    _webView.scrollView.bounces = NO;
    _webView.frame=self.view.bounds;
    
//    http://4k.com/wp-content/uploads/2014/06/4k-image-tiger-jumping.jpg
    
    NSURL *url = [NSURL URLWithString:self.path];
    NSURLSessionDataTask *dataTask;
    
    dataTask = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [_webView loadData:data MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:[[NSURL alloc] init]];//image/jpeg
    }];
    
//    dataTask = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        [_webView loadData:data MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:[[NSURL alloc] init]];
//    }];
    
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebviewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"loading %@", self.path);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];


//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.parentViewController.view setUserInteractionEnabled:YES];
//    });
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self.spinner stopAnimating];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.parentViewController.view setUserInteractionEnabled:YES];
//    });
    [self.webView reload];
    NSLog(@"error %@", error);
    
}


@end
