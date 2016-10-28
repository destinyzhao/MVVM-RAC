//
//  HomeViewModel.h
//  MVVMTableView
//
//  Created by Alex on 2016/10/21.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomTableView.h"

@interface HomeViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) CustomTableView *tableView;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIViewController *superViewController;
@property (strong, nonatomic) RACSignal *siganl ;

- (void)requestData;
- (void)initTableViewRefresh;

@end
