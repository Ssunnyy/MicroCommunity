//
//  MCProductCityChooseController.m
//  MicroCommunity
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCProductCityChooseController.h"

#import "RATreeView.h"
#import "RADataObject.h"
#import "MCCityTableViewCell.h"
#import "MCAutoSizeLab.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MCProductCityChooseController ()<RATreeViewDelegate, RATreeViewDataSource>

{
    NSArray *provinces, *cities, *areas;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) id expanded;
@property (weak, nonatomic) RATreeView *treeView;
@property (nonatomic, strong) MCAutoSizeLab *headView;

@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation MCProductCityChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpdata];
    
    [self setUpTreeView];
    
    [self setNavigationBarStatus];
    
    [self setUpHeadView];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  设置treeView
 */
- (void) setUpTreeView {

    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    
    for (int i = 0; i < 3; i ++) {
        
        NSArray *citys = [[provinces objectAtIndex:i] objectForKey:@"cities"];
        NSMutableArray *cityArray = [NSMutableArray array];
        
        for (int j = 0 ; j < cities.count; j ++) {
            RADataObject *data = [RADataObject dataObjectWithName:[[citys objectAtIndex:j] objectForKey:@"city"] children:nil];
            [cityArray addObject:data];
        }
        RADataObject *dataState = [RADataObject dataObjectWithName:[[provinces objectAtIndex:i] objectForKey:@"state"] children:cityArray];
        [dataArray addObject:dataState];
    }
    
    
    self.data = dataArray;
    
    RATreeView *treeView = [[RATreeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.separatorStyle = RATreeViewCellSeparatorStyleNone;
    
    [treeView reloadData];
    
    [treeView setBackgroundColor:UIColorFromRGB(0xF7F7F7)];
    
    self.treeView = treeView;
    [self.bgView addSubview:treeView];

    
}
/**
 *  headView
 */
- (void) setUpHeadView {
    
    __weak MCProductCityChooseController *weak = self;
    
    _headView = [[MCAutoSizeLab alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    _treeView.treeHeaderView = _headView;
    
    _headView.ciytTagClickBlock = ^(NSUInteger index){
        
        [weak.selectArray removeObjectAtIndex:index];
    };
}

- (void) refershHadView:(NSArray *) array{

    [_headView setHotViewWithArray:array andSampleLabelFont:13 height:18];
    _headView.frameheight = _headView.currenHeight;
    _treeView.treeHeaderView = _headView;
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:@"商品发布"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"完成" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}
/**
 *  初始化数据
 */

- (void) setUpdata {
    
    _selectArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TreeView Delegate methods
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 63;
}

- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 3 * treeNodeInfo.treeDepthLevel;
}

- (BOOL)treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return YES;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel
{
    if ([item isEqual:self.expanded]) {
        return YES;
    }
    return NO;
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    
    static NSString *cellId = @"MCCityTableViewCellIdentifier";
    MCCityTableViewCell *cell = [treeView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MCCityTableViewCell" owner:self options:nil]lastObject];
    }
    [cell configCillWithCity:item];
    switch (treeNodeInfo.treeDepthLevel) {
        case 0:
        {
            cell.btnLeftWidth.constant = 0;
            [cell hidenLine:NO];
        }
            break;
        case 1:
        {
            cell.btnLeftWidth.constant = 40;
            [cell hidenLine:YES];
        }
            break;
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (treeNodeInfo.treeDepthLevel == 0) {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.data count];
    }
    RADataObject *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    return [data.children objectAtIndex:index];
}


- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo {
    
    MCCityTableViewCell *cell = (MCCityTableViewCell *)[treeView cellForItem:item];
    switch (treeNodeInfo.treeDepthLevel) {
        case 0:
            cell.chooseSelect.selected = !treeNodeInfo.isExpanded;
            cell.jiantouBtn.selected = !treeNodeInfo.isExpanded;
            break;
        case 1:
            
        {
            cell.chooseSelect.selected = !cell.chooseSelect.selected;
            if (cell.chooseSelect.selected) {
                if (![_selectArray containsObject:item]) {
                    [_selectArray addObject:item];
                    [self refershHadView:_selectArray];
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)rightBarButtonClick:(UIButton *)button {

    if (_delegate && [_delegate respondsToSelector:@selector(chooseCitys:)]) {
        [_delegate chooseCitys:_selectArray];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
