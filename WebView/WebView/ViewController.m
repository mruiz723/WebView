//
//  ViewController.m
//  WebView
//
//  Created by Marlon David Ruiz Arroyave on 7/21/16.
//  Copyright © 2016 nextU. All rights reserved.
//

#import "ChildViewController.h"
#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (assign, nonatomic) NSUInteger numberPages;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberPages = 32;
    // Do any additional setup after loading the view, typically from a nib.
//
    
    NSURL *url = [NSURL URLWithString:@"http://test.stratalogica.com/NystromDigital/atlasesiPad.html?atlasName=atlas_jumbo_x"];
    NSURLSessionDataTask *dataTask;
    
    dataTask = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [_webView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:url];
    }];
    
    [dataTask resume];

    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test.stratalogica.com/NystromDigital/static/Flex/atlases/atlas_gigante/atlas_gigante.pdf_1.jpg"]]];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://flexpaper.devaldi.com/zine/Monash_Magazine.jsp?rp=html5,flash"]]];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    NSLog(@"%@", webView.request.URL);
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    NSLog(@"%@", error.localizedDescription);
}

- (IBAction)pages:(id)sender {
    
    NSDictionary *options =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                forKey: UIPageViewControllerOptionSpineLocationKey];
    
    [self setupPageControllerWithOptions:options];
    
}

- (IBAction)twoPages:(id)sender {
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    [self setupPageControllerWithOptions:options];
}


- (ChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    ChildViewController *childViewController = [[ChildViewController alloc] initWithNibName:@"ChildViewController" bundle:nil];
    childViewController.index = index;
    
    NSString *title = @"atlas_gigante";
    
//    atlas_gigante/atlas_gigante.pdf_1.jpg
    
//    childViewController.path = [NSString stringWithFormat:@"%@/%@.pdf_%lu.jpg", title,title,(unsigned long)index];

    
//    /atlas_gigante_01.pdf
    
    NSString * indexString;
    if (index <= 9) {
        indexString = [NSString stringWithFormat:@"0%lu", index];
    }else{
        indexString = [NSString stringWithFormat:@"%lu", index];
    }
    
    childViewController.path = [NSString stringWithFormat:@"%@/%@_%@.pdf", title,title,indexString];
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ChildViewController *)viewController index];
    
    if (index == 1) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ChildViewController *)viewController index];
    
    index++;
    
    if (index == self.numberPages) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return self.numberPages;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 1;
}

# pragma mark - Utils

- (void)setupPageControllerWithOptions:(NSDictionary *)options {
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    self.pageController.dataSource = self;
    
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    ChildViewController *initialViewController = [self viewControllerAtIndex:1];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithObject:initialViewController];
    
    
    if([options[UIPageViewControllerOptionSpineLocationKey] integerValue] == UIPageViewControllerSpineLocationMid) {
        
        ChildViewController *secondViewController = [self viewControllerAtIndex:2];
        [viewControllers addObject:secondViewController];
        
    }
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}



@end
