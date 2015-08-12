//
//  ITTTableView.m
//  iTotemFrame
//
//  Created by itotem on 14-10-24.
//  Copyright (c) 2014年 Lisa. All rights reserved.
//

#import "ITTTableView.h"

@implementation ITTTableView

-(void)awakeFromNib{
    [self setupRefresh];
    self.startNum = 0;
}
//-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
//{
//    if (self = [super initWithFrame:frame style:style]) {
//        [self setupRefresh];
//        self.startNum = 0;
//    }
//    return self;
//}
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//    
//        [self setupRefresh];
//        self.startNum = 0;
//    }
//    return self;
//}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    __weak ITTTableView *weakSelf = self;
    
    // 隐藏当前的上拉刷新控件    
    [self addLegendHeaderWithRefreshingBlock: ^{
        [weakSelf headerRereshing];
    }];
    
    [self addLegendFooterWithRefreshingBlock:^{
        [weakSelf footerRereshing];
    }];
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    if (self.ittDelegate && [self.ittDelegate respondsToSelector:@selector(pullTableViewDIdTriggerRefresh:)])
    {
        [self.ittDelegate pullTableViewDIdTriggerRefresh:self];
    }
}

- (void)footerRereshing
{
    
    NSLog(@"----------");
    
    if (self.ittDelegate && [self.ittDelegate respondsToSelector:@selector(pullTableViewDIdTriggerLoadMore:)])
    {
        [self.ittDelegate pullTableViewDIdTriggerLoadMore:self];
    }
}



-(void)endNetTable
{
    [self.header endRefreshing];
    [self.footer endRefreshing];
}

- (void) hidenFootView{

    [self.footer setStateHidden:YES];
}


@end
