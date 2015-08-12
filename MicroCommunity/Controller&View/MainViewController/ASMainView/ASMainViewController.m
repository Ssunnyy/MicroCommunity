//
//  ASMainViewController.m
//  ITotem
//
//  Created by qiuyan on 15-3-3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASMainViewController.h"
#import "ASMaterialCell.h"
#import "EScrollerView.h"
#import "ASMainHeadCell.h"
#import "ASMainShopTableViewCell.h"
#import "ASNewShowTableViewCell.h"
#import "ASMainRequestManager.h"
#import "ASMainAdModel.h"
#import "ASMaterialModel.h"
#import "ASMainBCCCModel.h"
#import "UserManager.h"
@interface ASMainViewController ()<UITableViewDataSource,UITableViewDelegate,ITTTableViewDelegate,EScrollerViewDelegate,ASCCCenterDelegate,ASBCCenterDelegate>
{
    BOOL isRequest;//是否要网络请求
}

@property (nonatomic, strong) IBOutlet ITTTableView *tableView;
/**
 *  轮播图
 */
@property (nonatomic, strong) EScrollerView *circleScrollV;

/**
 *  广告数组
 */
@property (nonatomic, strong) NSMutableArray *adArr;
/**
 *  素材数组
 */
@property (nonatomic, strong) NSMutableArray *materialArr;

/**
 *  BC_Arr
 */
@property (nonatomic, strong) NSMutableArray *bcArr;
/**
 *  CCArr
 */
@property (nonatomic, strong) NSMutableArray *ccArr;
@end

@implementation ASMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //隐藏导航栏
    [self hideNavBar];
    [self setUpTableView];
    [self setUpData];
    [self initWithCache];
    [self requestAdData];
    [self startLocation];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadView) name:@"reload_bc" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [AppDelegate DisplayTabBar];
    
    if (isRequest) {
        __weak ASMainViewController *weakSelf = self;
        [self requestMaterial:^{
            [weakSelf requestBcAndCcRequest];
        }];
    }
}

- (void) reloadView{

    [self requestBcAndCcRequest];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    isRequest = NO;
}

#pragma  mark   --  取消请求

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[ASMainRequestManager shareManager] cancelAllRequest];
}

/**
 *  设置tableview的headview
 */
- (void)setUpTableView
{
    int headViewHeight ;
    if (iPhone6Plus) {
        headViewHeight = 353;
    }else if(iPhone6){
        headViewHeight = 318;
    }else{
        headViewHeight = 273;

    }
    _circleScrollV=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
    self.tableView.tableHeaderView = _circleScrollV;
        
    _tableView.footer.hidden = YES;
    _tableView.ittDelegate = self;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46)];
    footView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = footView;
}
/**
 *  初始化缓存信息
 */
- (void)initWithCache{
    
    //  广告缓存
    NSMutableDictionary *dic = [[ASMainRequestManager shareManager] getLocalCache];
    [_adArr addObjectsFromArray:[dic objectForKey:MainAdImgKEY]];
    [self setUpScrollViewContent];
    //  素材缓存
    [_materialArr addObjectsFromArray:[dic objectForKey:MainMaterialImageKey]];
    //  bc缓存
    [_bcArr addObjectsFromArray:[dic objectForKey:MainAsBcImageKey]];
    //  cc缓存
    [_ccArr addObjectsFromArray:[dic objectForKey:MainAsCcImageKey]];
}


/**
 *  初始化数据
 */
- (void)setUpData
{
    _adArr = [[NSMutableArray alloc] init];
    _bcArr = [[NSMutableArray alloc] init];
    _ccArr = [[NSMutableArray alloc] init];
    _materialArr = [[NSMutableArray alloc]init];
    isRequest = YES;
}

#pragma mark --- 轮播图
- (void)setUpScrollViewContent
{
    NSMutableArray *imgArr = [NSMutableArray array];
    for (int i = 0; i < _adArr.count; i++) {
        ASMainAdModel *picModel = [_adArr objectAtIndex:i];
        [imgArr addObject:picModel.activityImg];
    }
    if (imgArr.count > 0) {
        [self.circleScrollV setScrollViewContent:imgArr];
    }
    _circleScrollV.delegate = self;
}

#pragma  mark  --  轮播图代理方法

- (void)EScrollerViewDidClicked:(NSUInteger)index {

}

#pragma  mark  --  请求成功后刷新数据
- (void) reloadData{
    
    [self.tableView reloadData];
}
/**
 *  数据请求
 */
- (void)requestAdData
{
    __weak ASMainViewController *weakSelf = self;
    
    [[ASMainRequestManager shareManager] requestMainAdWithParam:nil withIndicatorView:self.view withCancelRequestID:@"MainAd" withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
        
        if (operation.isSuccees) {
            [weakSelf.adArr removeAllObjects];

            NSArray *arr = [operation.resultDic objectForKey:@"data"];
            for (int i = 0; i < arr.count; i++) {
                ASMainAdModel *model = [[ASMainAdModel alloc] initWithDataDic:[arr objectAtIndex:i]];
                if (model) {
                    [weakSelf.adArr addObject:model];
                }
            }
            [DATA_CATHE addObject:_adArr forKey:MainAdImgKEY];
            [DATA_CATHE doSave];
            [weakSelf setUpScrollViewContent];
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        [weakSelf.tableView endNetTable];
   }];
}

#pragma  mark --  MainMaterialRequest

-(void)requestMaterial:(void(^)(void))requestBcCcBlock
{
    __weak ASMainViewController *weakSelf = self;
    
    [[ASMainRequestManager shareManager] requestMainMaterialWithParam:nil withIndicatorView:self.view withCancelRequestID:@"MainMaterial" withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            [_materialArr removeAllObjects];
            requestBcCcBlock();
            NSArray *arr = [operation.resultDic objectForKey:@"data"];
            for (int i = 0; i < arr.count; i++) {
                ASMaterialModel *model = [[ASMaterialModel alloc] initWithDataDic:[arr objectAtIndex:i]];
                if (model) {
                    [weakSelf.materialArr addObject:model];
                }
            }
            
            [DATA_CATHE addObject:_materialArr forKey:MainMaterialImageKey];
            [DATA_CATHE doSave];
            
            [weakSelf reloadData];
            [weakSelf.tableView endNetTable];
        }
        
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        
        [ITTPromptView showMessage:@"网络请求失败"];
        [weakSelf.tableView endNetTable];
    }];
}
/**
 *  BC&CC
 */
- (void)requestBcAndCcRequest
{
    __weak ASMainViewController *weakSelf = self;
    [[ASMainRequestManager shareManager] requestMainBCCCWithParam:nil withIndicatorView:self.view withCancelRequestID:@"MAINBCCC" withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            [_bcArr removeAllObjects];
            [_ccArr removeAllObjects];
            NSArray *bArr = [operation.resultDic objectForKey:@"bcShowList"];
            NSArray *cArr = [operation.resultDic objectForKey:@"ccShowList"];
            
            for (int i = 0 ; i < bArr.count; i++) {
                
                NSDictionary *useDic = [bArr objectAtIndex:i];
                
                NSDictionary *job = [useDic objectForKey:@"job"];
                
                ASMainBCCCModel *model = [[ASMainBCCCModel alloc] initWithDataDic:useDic];
                
                if (model) {
                    model.user = [[UserModel alloc]initWithDataDic:[[bArr objectAtIndex:i]objectForKey:@"appUser"]];
                    if ([job isKindOfClass:[NSDictionary class]]) {
//                        model.job = [[ASBCJobModel alloc]initWithDataDic:job];
                    }
                    [weakSelf.bcArr addObject:model];
                }
            }
            
            [DATA_CATHE addObject:_bcArr forKey:MainAsBcImageKey];
            [DATA_CATHE doSave];
            
            for (int i = 0; i < cArr.count; i++) {
                ASMainBCCCModel *model = [[ASMainBCCCModel alloc] initWithDataDic:[cArr objectAtIndex:i]];
                if (model) {
                    model.user = [[UserModel alloc]initWithDataDic:[[cArr objectAtIndex:i]objectForKey:@"appUser"]];
                    [weakSelf.ccArr addObject:model];
                }
            }
            
            [DATA_CATHE addObject:_ccArr forKey:MainAsCcImageKey];
            [DATA_CATHE doSave];
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endNetTable];
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [weakSelf.tableView endNetTable];
    }];
}


- (void)setViewOffset
{
     self.tableView.contentOffset = CGPointMake(0, 0);
}

/**
 *  tableview delegate and datasource
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone6Plus) {
        if (indexPath.row == 0) {
            return 39;
        }else{
            if (indexPath.section == 1) {
                return 441;
            }
            return 333;
        }
    }else if(iPhone6){
        if (indexPath.row == 0) {
            return 34;
        }else{
            if (indexPath.section == 1) {
                return 382;
            }
            return 288;
        }
    }else{
        if (indexPath.row == 0) {
            return 29;
        }else{
            if (indexPath.section == 1) {
                return 379;
            }
            return 258;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0://素材库
            return _materialArr.count + 1;
            break;
        case 1:///新人区
            if (_ccArr.count == 0) {
                return 0;
            }
            return _ccArr.count + 1;
            break;
        case 2:///热门商铺
            if (_bcArr.count == 0) {
                return 0;
            }
            return _bcArr.count + 1;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASMainHeadCell *headView = [[[NSBundle mainBundle] loadNibNamed:@"ASMainHeadCell" owner:self options:nil] lastObject];
    headView.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.section) {
        case 0:///素材库
        {
            if (indexPath.row == 0) {///标题
                [headView changeHeadViewContent:0];
                return headView;
            }else{
                static NSString *materialCellIdentifier = @"MaterialCellIdentifier";
                ASMaterialModel *model;
                if (_materialArr.count > 0) {
                    model = [_materialArr objectAtIndex:indexPath.row - 1];

                }
                ASMaterialCell *materialCell = [tableView dequeueReusableCellWithIdentifier:materialCellIdentifier];
                if (materialCell == nil) {
                    materialCell = [[[NSBundle mainBundle] loadNibNamed:@"ASMaterialCell" owner:self options:nil] lastObject];
                }
                [materialCell setContentCellTitle:model.materialImg andImage:model.pic];
                materialCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return materialCell;
            }
        }
            break;
        case 1:///新人秀
        {
            if (indexPath.row == 0) {
                [headView changeHeadViewContent:1];
                return headView;
            }else{
                static NSString *newCellIdentifier = @"newCellIdentifier";
                ASNewShowTableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:newCellIdentifier];
                if (newCell == nil) {
                    newCell = [[[NSBundle mainBundle] loadNibNamed:@"ASNewShowTableViewCell" owner:self options:nil] lastObject];
                }
                if (_ccArr.count > 0) {
                    [newCell setContentCell:[_ccArr objectAtIndex:indexPath.row - 1]];
                }
                newCell.delegate = self;
                newCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return newCell;
            }
        }
            break;
        case 2:///热门商铺
        {
            if (indexPath.row == 0) {
                [headView changeHeadViewContent:2];
                return headView;
            }else{
                static NSString *shopCellIdentifier = @"shopCellIdentifier";
                ASMainShopTableViewCell *shopCell = [tableView dequeueReusableCellWithIdentifier:shopCellIdentifier];
                shopCell.useType = serachUse;
                if (shopCell == nil) {
                    shopCell = [[[NSBundle mainBundle] loadNibNamed:@"ASMainShopTableViewCell" owner:self options:nil] lastObject];
                }
                if (_bcArr.count > 0) {
                    [shopCell setContentCell:[_bcArr objectAtIndex:indexPath.row - 1]];
                }
                shopCell.bcdelegate = self;
                shopCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return shopCell;
            }
        }
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - ITTTableViewDelegate

/**
 *  触发时，刷新--- 在执行这个代理方法  请求数据结束之后 需要手动调用endNetTable
 *
 *  @param ittTableView
 */
-(void)pullTableViewDIdTriggerRefresh:(ITTTableView *)ittTableView
{
    
    [[ASMainRequestManager shareManager]cancelAllRequest];
    [self requestAdData];
    __weak ASMainViewController *weakSelf = self;
    [self requestMaterial:^{
        [weakSelf requestBcAndCcRequest];
    }];
}



/**
 *  scrollview delegate（当滑动的时候tab隐藏，滑动停止的时候tab显示）
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [AppDelegate HideTabBar];
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerat
{
    if (!decelerat) {
        [AppDelegate DisplayTabBar];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [AppDelegate DisplayTabBar];
}


#pragma mark --  开启定位服务

- (void)startLocation
{
    if ([self checkLocationIsValid]) {
        [[MMLocationManager shareLocation]startGetUserLocation:^(CLLocationCoordinate2D locationCorrrdinate)
         {
             NSString *_lon=[NSString stringWithFormat:@"%f",locationCorrrdinate.longitude];
             NSString *_lat=[NSString stringWithFormat:@"%f",locationCorrrdinate.latitude];
             NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
             
             [USER_DEFAULT setObject:_lon forKey:MMLastLongitude];
             [USER_DEFAULT setObject:_lat forKey:MMLastLatitude];
             
             [standard synchronize];
             [[MMLocationManager shareLocation]getProvince:^(NSString *state, NSString *city) {
                 NSString *filePath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
                 NSArray *arr =[NSArray arrayWithContentsOfFile:filePath];
                 for (NSDictionary *lowdic in arr) {
                     NSString *cityStr = [lowdic objectForKey:@"citycn"];
                     if ([state hasPrefix:cityStr]) {
                         [USER_DEFAULT setObject:cityStr forKey:@"CURRENTCITY"];
                         [USER_DEFAULT setObject:[lowdic objectForKey:@"id"] forKey:@"CURRENTCITYID"];
                     }
                 }                 
             }];
         }];
    }
  
}

-(BOOL)checkLocationIsValid
{
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
            
            return YES;
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        
        return NO;
    }
    return NO;
}


#pragma mark -- ASCCCenterDelegate
- (void)enterCenter:(ASNewShowTableViewCell *)cell
{
    
}

#pragma mark -- ASBCCenterDelegate
- (void)enterCenterBC:(ASMainShopTableViewCell *)cell
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
