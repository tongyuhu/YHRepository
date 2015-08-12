//
//  SpecialViewController.m
//  day40_UI爱限免
//
//  Created by qianfeng on 15/7/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SpecialViewController.h"
#import "SpecialModel.h"
@interface SpecialViewController () <NSURLConnectionDataDelegate>
{
    UIImageView *_imageView;
    UITableView *_tableView;
    UIImageView *_editorImageView;
    UILabel *_editorWords;
    
    NSMutableArray *_dataList;
    NSMutableData *_receive;
    SpecialModel *_specialModel;
    NSURLConnection *_connection;
    
    
}
@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createDataList];
    
}

- (void)createDataList
{
    _dataList = [NSMutableArray array];
    _receive = [NSMutableData data];
//    NSString *urlString = @"http://iappfree.candou.com:8080/free/applications/503264290?currency=rmb";
    NSString *urlString = @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=1";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

- (void)createUI
{
    
}

#pragma mark -----NSURLConnectionDataDelegata----

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    NSLog(@"%@", response);
    [_receive setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receive appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result = [NSJSONSerialization JSONObjectWithData:_receive options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
