//
//  CustomTableView.m
//  MVVMTableView
//
//  Created by Alex on 2016/10/21.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "CustomTableView.h"
#import "MJRefresh.h"

@interface CustomTableView ()

@property (assign, nonatomic) NSInteger pageNum;

@end

@implementation CustomTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSetting];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self initSetting];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting
{
    [self setUpMJRefresh];
}

#pragma mark -
#pragma mark - 初始化MJRefresh
- (void)setUpMJRefresh
{
    __weak UITableView *tableView = self;
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = NO;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 0;
        if (self.headerRefreshBlock) {
            self.headerRefreshBlock(self.pageNum);
        }
        // 结束刷新
        [tableView.mj_header endRefreshing];
    }];
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.pageNum += 1;
        if (self.footerRefreshBlock) {
            self.footerRefreshBlock(self.pageNum);
        }
        // 结束刷新
        [tableView.mj_footer endRefreshing];
    }];
}

#pragma mark -
#pragma mark - 重新 reload
- (void)reloadData
{
    [super reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSInteger count = 0;
        NSInteger secCount = [self numberOfSections];
        for (NSInteger i=0; i<secCount; i++) {
            count += [self numberOfRowsInSection:i];
        }
        
        self.backgroundView.hidden = (count != 0);
    });
}

@end
