//
//  MCCreatTalkGroupController.m
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCreatTalkGroupController.h"
#import "MCIMSelectUserCell.h"
#import "pinyin.h"


@interface MCCreatTalkGroupController ()<UITableViewDelegate,UITableViewDataSource,MCIMSelectUserCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *friendTableView;

@property (nonatomic, retain) NSMutableArray *listHeadArr;
@property (nonatomic, retain) NSMutableArray *listArr;
@property (nonatomic, retain) NSMutableArray *allArr;
@property (nonatomic, retain) NSMutableArray *showArr; // 显示在右侧的# A--Z

@end

@implementation MCCreatTalkGroupController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  初始化数据
 */

- (void) setUpData{

    _chooseArr = [[NSMutableArray alloc]init];
//    _exitArr = [[NSMutableArray alloc]init];
    
    _listArr = [[NSMutableArray alloc]init];
    _listHeadArr = [[NSMutableArray alloc]init];
    _allArr = [[NSMutableArray alloc]init];
    _showArr = [[NSMutableArray alloc]init];
    
    [self.showArr addObject:@"#"];
    for (char i = 'A'; i <= 'Z'; i++) {
        [_showArr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    
    QRemindLookModel *model1 = [[QRemindLookModel alloc] init];
    model1.headpic = @"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg";
    model1.sex = @"1";
    model1.userid = @"1";
    model1.username = @"萌萌";
    model1.isChoose = @"2";
    
    QRemindLookModel *model2 = [[QRemindLookModel alloc] init];
    model2.headpic = @"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg";
    model2.sex = @"2";
    model2.userid = @"2";
    model2.username = @"小明";
    model2.isChoose = @"2";
    
    QRemindLookModel *model3 = [[QRemindLookModel alloc] init];
    model3.headpic = @"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg";
    model3.sex = @"1";
    model3.userid = @"3";
    model3.username = @"张龙";
    model3.isChoose = @"2";
    
    QRemindLookModel *model4 = [[QRemindLookModel alloc] init];
    model4.headpic = @"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg";
    model4.sex = @"2";
    model4.userid = @"4";
    model4.username = @"郭健";
    model4.isChoose = @"2";
    
    QRemindLookModel *model5 = [[QRemindLookModel alloc] init];
    model5.headpic = @"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg";
    model5.sex = @"1";
    model5.userid = @"5";
    model5.username = @"阿敏";
    model5.isChoose = @"2";
    
    
    [_allArr addObject:model1];
    [_allArr addObject:model2];
    [_allArr addObject:model3];
    [_allArr addObject:model4];
    [_allArr addObject:model5];
    
    [_listArr addObjectsFromArray:[self getChineseStringArr:_allArr]];
    
    [self showExitAite];

}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    
    _friendTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self setNavigationBarTitle:@"创建聊天室"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"确认" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.listArr objectAtIndex:section] count];
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.listArr count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_listHeadArr objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.showArr;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 76;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = [NSString stringWithFormat:@"cell%ld%ld",indexPath.row,indexPath.section];
//    static NSString *cellID = @"MCIMSelectUserCellIdentifier";
    
    MCIMSelectUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCIMSelectUserCell" owner:self options:nil]lastObject];
    }
    [cell setContentCell:[[self.listArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] andChooseArray:self.chooseArr];
    cell.selectBtn.indexPath = indexPath;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma  mark  --  MCIMSelectUserCellDelegate 

- (void)chooseBtnClick:(NSIndexPath *)chooseIndexPath andChoose:(BOOL)isChoose {

    QRemindLookModel *model ;

    model = [[self.listArr objectAtIndex:chooseIndexPath.section] objectAtIndex:chooseIndexPath.row];
    if (isChoose) {
        model.isChoose = @"1";
        if (![self.chooseArr containsObject:model]) {
            BOOL contan = NO;
            for (QRemindLookModel *mo in self.chooseArr) {
                if ([mo.userid isEqualToString:model.userid]) {
                    contan = YES;
                    break;
                }
            }
            if (!contan) {
                [self.chooseArr addObject:model];
            }
        }
    }else{
        model.isChoose = @"2";
        [self.chooseArr removeObject:[[self.listArr objectAtIndex:chooseIndexPath.section] objectAtIndex:chooseIndexPath.row]];
    }
}


//在前一个页面已经存在的@
- (void)showExitAite
{
    for (int i = 0; i < _exitArr.count; i ++) {
        QRemindLookModel * model ;
        model = (QRemindLookModel *)[_exitArr objectAtIndex:i];
        for (int j = 0; j < self.listArr.count; j ++) {
            NSArray *arr = [self.listArr objectAtIndex:j];
            for (int k = 0; k < arr.count; k ++ ) {
                QRemindLookModel *compareModel = [arr objectAtIndex:k];
                if ([model.userid isEqualToString:compareModel.userid]) {
                    compareModel.isChoose = @"2";
                    [self.chooseArr addObject:compareModel];
                }
            }
        }
    }
}


//接口数据按字母分组
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort {
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i = 0; i < [arrToSort count]; i++) {
        QRemindLookModel *lookModel = [arrToSort objectAtIndex:i];
        if(lookModel.username==nil){
            lookModel.username=@"";
        }
        if(![lookModel.username isEqualToString:@""]){
            //join the pinYin
            NSString *pinYinResult = [NSString string];
            for(int j = 0;j < lookModel.username.length; j++) {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                 pinyinFirstLetter([lookModel.username characterAtIndex:j])]uppercaseString];
                
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
        QRemindLookModel *chineseStr = (QRemindLookModel *)[chineseStringsArray objectAtIndex:index];
        if (chineseStr.username.length == 0) {
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
            TempArrForGrouping = [NSMutableArray array];
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

    self.listHeadArr = _sectionHeadsKeys;
    
    return arrayForArrays;
}

- (void)rightBarButtonClick:(UIButton *)button {

    if (_qremindDelegate && [_qremindDelegate respondsToSelector:@selector(aite:)]) {
        [_qremindDelegate aite:self.chooseArr];
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
