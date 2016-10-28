//
//  ViewController.m
//  MVVMTableView
//
//  Created by Alex on 2016/10/21.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CustomTableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;

@property (nonatomic, strong) HomeViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self.viewModel;
    self.tableView.delegate = self.viewModel;
    
    [self bindViewModel];
}

- (void)bindViewModel
{
    [self.viewModel requestData];
    [self.viewModel.siganl subscribeNext:^(id x) {
        NSLog(@"-------->%@",x);
        [self updateUI];
    }];
}

- (void)updateUI
{
    self.nameLbl.text = self.viewModel.name;
    self.phoneLbl.text = self.viewModel.phone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - lazy load
- (HomeViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc] init];
        _viewModel.tableView = self.tableView;
        _viewModel.superViewController = self;
        [_viewModel initTableViewRefresh];
    }
    return _viewModel;
}

@end
