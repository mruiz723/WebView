//
//  ChildViewController.h
//  WebView
//
//  Created by Marlon David Ruiz Arroyave on 7/22/16.
//  Copyright © 2016 nextU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (strong, nonatomic) NSString *path;

@end
