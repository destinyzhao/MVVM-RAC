//
//  CustomTableView.h
//  MVVMTableView
//
//  Created by Alex on 2016/10/21.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderRefreshBlock)(NSInteger pageNum);
typedef void(^FooterRefreshBlock)(NSInteger pageNum);

@interface CustomTableView : UITableView

@property (copy, nonatomic) HeaderRefreshBlock headerRefreshBlock;
@property (copy, nonatomic) FooterRefreshBlock footerRefreshBlock;

@end
