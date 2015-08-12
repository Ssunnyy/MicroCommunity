//
//  SearchBarView.h
//  Parking
//
//  Created by qiuyan on 14-11-18.
//
//

#import <UIKit/UIKit.h>

@class SearchBarView;
@protocol SearchBarViewDelegate <NSObject>

@optional
//开始输入
-(void) searchBarViewDidBeginEditing:(SearchBarView*) searchBarView;
//结束输入
-(void) searchBarViewDidEndEditing:(SearchBarView*) searchBarView;

//正在输入(获取正在输入的文本)
-(void) searchBarView:(SearchBarView*) searchBarView textChanged:(NSString*) searchText;
// 搜索完成
-(void) searchBarView:(SearchBarView *)searchBarView inputCompleted:(NSString *)searchText;
//清空数据
-(void) searchBarViewdidClearText:(SearchBarView *)searchBarView;
//搜索取消
- (void) searchBarViewCancel:(SearchBarView *)searchBarView;
//正在输入（获取当前文本框里的文本）
-(void) searchBarView:(SearchBarView*) searchBarView textDidChangedWithText:(NSString*) searchText;

@end

@interface SearchBarView : UIView <UITextFieldDelegate>
{
    UIImageView *bgImageView;//搜索框背景
    UIButton *clearBtn;       //清空搜索框文本
        UIView *searchV;          //承载搜索文本框的容器view
    BOOL isSearchNav;         //判断是否是导航
    NSString *placeHolder;
}

@property (nonatomic, strong) UITextField *textField ;
@property (nonatomic, assign) id<SearchBarViewDelegate> searchDelegate;
@property (nonatomic, strong) UIImageView *searchImg;   //搜索的图片
@property (nonatomic, strong) UIButton *cancelBtn;      //取消btn

//初始化是否是导航
- (id)initWithIsNav:(BOOL)isNav;
//设置搜索框 带有 取消 和 清空 按钮
- (void)setSearchVWithBtnPlace:(NSString *)textPlaceHolder;
//清空搜索框内容
- (void)clearText;
//收起键盘
- (void)hidenKeyboard;

@end
