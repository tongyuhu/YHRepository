//
//  ApplicationsViewController.h
//  day40_UI爱限免
//
//  Created by qianfeng on 15/7/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationsViewController : UIViewController <NSURLConnectionDataDelegate>
@property (nonatomic, copy) NSString *appID;
@end
