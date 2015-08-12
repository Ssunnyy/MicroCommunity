//
//  ITTTableView.h
//  iTotemFrame
//
//  Created by itotem on 14-10-24.
//  Copyright (c) 2014年 Lisa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@class ITTTableView;



@protocol ITTTableViewDelegate <NSObject>

@optional

/**
 *  触发时，刷新--- 在执行这个代理方法  请求数据结束之后 需要手动调用endNetTable
 *
 *  @param ittTableView
 */
-(void)pullTableViewDIdTriggerRefresh:(ITTTableView *)ittTableView;

/**
 *  触发时加载更多    请求数据结束之后  需要手动调用 endNetTable
 *
 *  @param ittTableView
 */
-(void)pullTableViewDIdTriggerLoadMore:(ITTTableView *)ittTableView;


@end

@interface ITTTableView : UITableView

@property(nonatomic,strong)id<ITTTableViewDelegate>ittDelegate;

@property(nonatomic,assign)NSInteger startNum;//开始请求的 数据是第几条
@property(nonatomic,assign)NSInteger nowNum;//一次请求结束完，目前的数据条数
//  添加刷新
- (void)setupRefresh;
- (void) endNetTable;
- (void) hidenFootView;

@end
