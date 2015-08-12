//
//  ApplicationsViewController.m
//  day40_UI爱限免
//
//  Created by qianfeng on 15/7/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ApplicationsViewController.h"

@interface ApplicationsViewController ()
{
    NSMutableArray *_dataList;
    NSMutableData *_receive;
    NSURLConnection *_connection;
}
@end

@implementation ApplicationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
}

- (void)createData
{
    _dataList = [NSMutableArray array];
    _receive = [NSMutableData data];
    NSString *urlString = [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/%@?currency=rmb!", _appID];
    NSLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

#pragma mark ----NSURlConnectionDatadelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receive setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receive appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result = [NSJSONSerialization JSONObjectWithData:_receive options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",result);
    
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
