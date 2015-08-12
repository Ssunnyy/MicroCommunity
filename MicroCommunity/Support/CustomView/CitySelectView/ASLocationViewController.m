//
//  ASLocationViewController.m
//  ITotem
//
//  Created by qiuyan on 15-4-3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASLocationViewController.h"
#import "YXChooseCityHeadView.h"
#import "ASCityCell.h"
#import "pinyin.h"


@interface ASLocationViewController ()<SearchBarViewDelegate>
{
    BOOL isSearch;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YXChooseCityHeadView *headView;

/**
 *  最初的数组
 */
@property (nonatomic, strong) NSMutableArray *dataArr;
// 显示在右侧的# A--Z
@property (nonatomic, strong) NSMutableArray *showArr;
/**
 *  按字母排序好的数组
 */
@property (nonatomic, strong) NSMutableArray *orderArr;

/**
 *  section title
 */
@property (nonatomic, strong) NSMutableArray *listHeadArr;

/**
 *  搜索的数组
 */
@property (nonatomic, strong) NSMutableArray *searchArr;

@property (nonatomic, strong) NSMutableArray *searchHeadArr;

@end

@implementation ASLocationViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self setNavBarStatus];
    [self setTableHeadView];
    [self setUpData];
}

/**
 *  设置导航的样式
 */
- (void)setNavBarStatus
{
    [AppDelegate HideTabBar];
    [self setNavigationBarTitle:@"筛选"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_icon_.png")];
}

- (void)setTableHeadView
{
    self.headView = [[YXChooseCityHeadView alloc] init];
    self.headView.searchView.searchDelegate = self;
    if (iPhone6Plus) {
        self.headView.frameheight = 76;
    }else if(iPhone6){
        self.headView.frameheight = 58;
    }else{
        self.headView.frameheight = 56;
    }
    self.tableView.tableHeaderView = self.headView;
}

- (void)setUpData
{
    _dataArr = [[NSMutableArray alloc] init];
    _orderArr = [[NSMutableArray alloc] init];
    _listHeadArr = [[NSMutableArray alloc] init];
    _searchArr = [[NSMutableArray alloc] init];
    _searchHeadArr = [[NSMutableArray alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
    
    NSArray *arr =[NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *lowdic in arr) {
        ASCityModel *model = [[ASCityModel alloc] initWithDataDic:lowdic];
        model.cityCn = [lowdic objectForKey:@"citycn"];
        model.cityCode = [lowdic objectForKey:@"id"];
        [_dataArr addObject:model];
    }
    _orderArr = [self getChineseStringArr:_dataArr];
    
    ASCityModel *model = [[ASCityModel alloc] init];
    model.cityCn = [USER_DEFAULT objectForKey:@"CURRENTCITY"];
    model.cityCode = [USER_DEFAULT objectForKey:@"CURRENTCITYID"];
    NSArray *arrLocation = [NSArray arrayWithObject:model];
    [_orderArr insertObject:arrLocation atIndex:0];
    
    _showArr = [[NSMutableArray alloc] init];
    for (char i = 'A'; i <= 'Z'; i++) {
        [_showArr addObject:[NSString stringWithFormat:@"%c",i]];
    }
}

#pragma mark --- serchBardelegate

-(void)searchBarView:(SearchBarView *)searchBarView inputCompleted:(NSString *)searchText
{
    
    if (searchText.length != 0) {
        isSearch = YES;
        NSArray *tmparr;
        NSPredicate * chinesePredicate = [NSPredicate predicateWithFormat:@"self.cityCn CONTAINS[cd]%@",searchText];
        
        tmparr=[_dataArr filteredArrayUsingPredicate:chinesePredicate];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:tmparr];
        self.searchArr = [self getChineseStringArr:tempArr];
    }else{
        isSearch = NO;
    }
    [_tableView reloadData];
}

-(void) searchBarViewdidClearText:(SearchBarView *)searchBarView
{
    isSearch = NO;
    [_tableView reloadData];
}

#pragma mark -- tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch) {
        return [[self.searchArr objectAtIndex:section] count];
    }else{
        return [[self.orderArr objectAtIndex:section] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isSearch) {
        return [self.searchArr count];
    }else{
        return [self.orderArr count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (isSearch) {
        return [_listHeadArr objectAtIndex:section];
    }else{

        return [_listHeadArr objectAtIndex:section];
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.showArr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *cellIdentifier = @"cellIdentifier";
    ASCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ASCityCell" owner:self options:nil] lastObject];
    }
    if (isSearch) {
        [cell setContentCell:[[self.searchArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    }else{
        [cell setContentCell:[[self.orderArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        if (indexPath.section == 0) {
            [cell setLocationimgShow];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //    NSLog(@"%@",[[self.orderArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    
    if (_delegate && [_delegate respondsToSelector:@selector(getLocation:)]) {
        if (isSearch) {
            [_delegate getLocation:[[self.searchArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];

        }else{
            ASCityModel *model = [[self.orderArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            [_delegate getLocation:model];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//接口数据按字母分组
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort {
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i = 0; i < [arrToSort count]; i++) {
        ASCityModel *lookModel = [arrToSort objectAtIndex:i];
        if(lookModel.cityCn==nil){
            lookModel.cityCn=@"";
        }
        if(![lookModel.cityCn isEqualToString:@""]){
            //join the pinYin
            NSString *pinYinResult = [NSString string];
            for(int j = 0;j < lookModel.cityCn.length; j++) {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                 pinyinFirstLetter([lookModel.cityCn characterAtIndex:j])]uppercaseString];
                
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            lookModel.pinYin = pinYinResult;
        } else {
            lookModel.pinYin = @"";
        }
        [chineseStringsArray addObject:lookModel];
    }
    
    //sort the ChineseStringArr by pinYin
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex= NO;  //flag to check
    NSMutableArray *TempArrForGrouping = nil;
    NSMutableArray *_sectionHeadsKeys = [NSMutableArray array];
    
    for(int index = 0; index < [chineseStringsArray count]; index++)
    {
        ASCityModel *chineseStr = (ASCityModel *)[chineseStringsArray objectAtIndex:index];
        if (chineseStr.cityCn.length == 0) {
            continue;
        }
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pinYin];
        NSString *sr= [strchar substringToIndex:1];
        char tempChar = [sr characterAtIndex:0];
        
        if (tempChar < 'A' || tempChar > 'Z') {
            sr = @"#";
        }
        
        if(![_sectionHeadsKeys containsObject:[sr uppercaseString]])//here I'm checking whether the character already in the selection header keys or not
        {
            [_sectionHeadsKeys addObject:[sr uppercaseString]];
            TempArrForGrouping = [[NSMutableArray alloc] initWithObjects:nil];
            checkValueAtIndex = NO;
        }
        if([_sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [TempArrForGrouping addObject:[chineseStringsArray objectAtIndex:index]];
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    if (isSearch) {
        self.searchHeadArr = _sectionHeadsKeys;
    }else {
         self.listHeadArr = _sectionHeadsKeys;
        [self.listHeadArr insertObject:@"" atIndex:0];
    }
    
    return arrayForArrays;
}


/**
 *  判断输入的是中文还是英文
 */
-(BOOL)isInputChinese:(NSString*)inputString
{
    for(int i=0; i< [inputString length];i++){
        int a = [inputString characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
