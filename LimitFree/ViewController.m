//
//  LimitedViewController.m
//  day40_UI爱限免
//
//  Created by qianfeng on 15/7/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "ApplicationsViewController.h"

@interface ViewController ()
{
    UITableView *_tableView;
    UISearchController *_searchController;
    NSMutableArray *_dataList;
    NSURLConnection *_connection;
    NSMutableData *_receiveData;
    NSMutableArray *_searchList;
    NSArray *_urlList;
    NSMutableArray *_ImageData;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger index = self.tabBarController.selectedIndex;
    [self createDataListWithindex:index];
    
    [self createUI];
    
    
}

- (void)createDataListWithindex:(NSInteger)index
{
    _urlList = @[@"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=1",@"http://iappfree.candou.com:8080/free/applications/free?currency=rmb&page=1",@"http://iappfree.candou.com:8080/free/applications/sales?currency=rmb&page=1",@"",@"http://open.candou.com/mobile/hot/page/1"];
    
    _dataList = [NSMutableArray array];
    _receiveData = [NSMutableData data];
    _searchList = [NSMutableArray array];
    _ImageData = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:[_urlList objectAtIndex:index]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *categaryButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleDone target:self action:@selector(categaryButtonItemClicked)];
    self.navigationItem.leftBarButtonItem = categaryButtonItem;
    
    UIBarButtonItem *systomButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(systomButtonItemClicked)];
    self.navigationItem.rightBarButtonItem = systomButtonItem;
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation = YES;
    
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 44);
    _searchController.searchBar.frame = rect;
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;
    _tableView.tableHeaderView = _searchController.searchBar;
}

- (void)categaryButtonItemClicked
{
    
}

- (void)systomButtonItemClicked
{
    
}

#pragma mark -----UISearchResultUpdate----

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [_searchList removeAllObjects];
    NSString *str = _searchController.searchBar.text;
    for (NSDictionary *dict in _dataList) {
        NSString *name = [dict objectForKey:@"name"];
        if ([name containsString:str]) {
            [_searchList addObject:dict];
        }
    }
    
    [_tableView reloadData];
}

#pragma mark ---UITableViewDataSource--

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_searchController.active) {
        return _searchList.count;
    }
    return _dataList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dict = nil;
    if (_searchController.active) {
        dict = [_searchList objectAtIndex:indexPath.row];
    }
    else
    {
        dict = [_dataList objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [dict objectForKey:@"name"];
    cell.detailTextLabel.text = [dict objectForKey:@"lastPrice"];
    cell.appID = [dict objectForKey:@"applicationId"];
//    NSString *str =cell.appID;
    
    
    NSMutableData *data = [_ImageData objectAtIndex:indexPath.row];
    
    
    UIImage *image = [[UIImage alloc] initWithData:data];
    cell.imageView.image = image;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [cell addGestureRecognizer:tap];
    
    return cell;
}

- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    TableViewCell *cell = (TableViewCell *)tap.view;
    ApplicationsViewController *appVC = [[ApplicationsViewController alloc] init];
    appVC.appID = cell.appID;
    [self.navigationController pushViewController:appVC animated:YES];
}

//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 44;
//}

#pragma mark -----NSURLConnectionDataDelegate-----
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receiveData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result = [NSJSONSerialization JSONObjectWithData:_receiveData options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@", result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        _dataList = [result objectForKey:@"applications"];
        for (NSDictionary *dict in _dataList) {
            NSURL *url = [NSURL URLWithString:[dict objectForKey:@"iconUrl"]];
            NSMutableData *data = [[NSMutableData alloc] initWithContentsOfURL:url];
            [_ImageData addObject:data];
        }
        
    }
    else if ([result isKindOfClass:[NSArray class]])
    {
        
    }
    
    
    [_tableView reloadData];
}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----UISearchBarDelegate----

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    return YES;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchController.searchBar resignFirstResponder];
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
