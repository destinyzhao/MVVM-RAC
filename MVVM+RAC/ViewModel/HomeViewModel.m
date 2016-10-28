//
//  HomeViewModel.m
//  MVVMTableView
//
//  Created by Alex on 2016/10/21.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "HomeViewModel.h"
#import "CustomCell.h"
#import "TestModel.h"
#import "DetailViewController.h"

#define viewControllerInStoryBoard(vcID, sbName) [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcID]

@implementation HomeViewModel

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -
#pragma mark - 初始化TableView 刷新
- (void)initTableViewRefresh
{
    __weak __block typeof(self) selfBlock = self;
    
    self.tableView.headerRefreshBlock = ^(NSInteger pageNum){
        NSLog(@"------>pageNum:%zd",pageNum);
        [selfBlock.dataArray removeAllObjects];
        [selfBlock requestData];
    };
    
    self.tableView.footerRefreshBlock = ^(NSInteger pageNum){
        NSLog(@"------>pageNum:%zd",pageNum);
        [selfBlock requestData];
    };
}

#pragma mark -
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableViewDidSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

#pragma mark -
#pragma mark - 获取Cell
- (CustomCell *)getCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:self options:nil]firstObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row < self.dataArray.count) {
        TestModel *model = self.dataArray[indexPath.row];
        cell.titleLbl.text = model.title;
    }
    
    return cell;
}

#pragma mark -
#pragma mark - Tableview Cell 选中
- (void)tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = viewControllerInStoryBoard(@"DetailViewControllerSb", @"Main");
    [self.superViewController.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -
#pragma mark - 网络请求
- (void)requestData
{
    NSInteger count = 20;
    
    for (int i = 0; i<count; i++) {
        TestModel *model = [TestModel new];
        model.title = [NSString stringWithFormat:@"%@这是一款商品这是一款商品这是一款商品",@(i)];
        
        [self.dataArray addObject:model];
    }
    
    [self setNameAndPhone];
    
    [self.tableView reloadData];

    NSString *successStr = @"updateUi";
     
    _siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:successStr];
        [subscriber sendCompleted];
        
        return nil;
    }];

}

- (void)setNameAndPhone
{
    self.name = @"Alex";
    self.phone = @"13888888888";
}

@end
