//
//  BaseViewController.m
//  iTotemFrame
//
//  Created by Lisa on 14-10-23.
//  Copyright (c) 2014年 Lisa. All rights reserved.
//

#import "BaseViewController.h"
#import "UserManager.h"
@interface BaseViewController ()<SearchBarViewDelegate>

{

    /***************键盘弹起时自动拖动TextField 到可见区域******************/
    //正在编辑的textview
    UIView            *_editingTextFieldOrTextView;
    id                 _textViewOrFieldOrgDelegate;
    float             _contentViewTop;

}

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationView];
    [self setUpView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate * app = [[UIApplication sharedApplication]delegate];
    if ([app respondsToSelector:@selector(getCurrentController:)]) {
        [app performSelector:@selector(getCurrentController:) withObject:self];
    }
}

#pragma mark--- Private method
//是否显示自定义导航栏 需要子类重写 默认显示
-(Boolean)isCustomNavigationBar
{
    return true;
}

- (void)setUpView
{
    self.view.backgroundColor = RGBCOLOR(238, 238, 238);
}

//设置导航样式
- (void)setNavigationView
{
    if([ self isCustomNavigationBar])
    {
        [self loadNavigationBar];
    }
}

//自定义导航栏背景
-(void)loadNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
    _navigationBarView = [[[NSBundle mainBundle] loadNibNamed:@"NavigationBarView" owner:self options:nil] lastObject];
    [self.view addSubview:_navigationBarView];
    
    CGFloat height = 64;
    if (ISLESS_IOS7) {
        height = 44;
    }
    UIView *superview = self.view;
    int padding = 0;
    //为 导航视图 代码添加约束
    [_navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).offset(padding); //with with
        make.left.equalTo(superview.left).offset(padding); //without with
        make.width.equalTo(superview.width);
        make.height.equalTo(@(height)); //can pass array of views
    }];
}

#pragma mark---Public method
//隐藏导航栏--- 默认是带导航栏的
-(void)hideNavBar
{
    CGFloat contentY = self.view.bounds.origin.y;
    self.contentView.frame = CGRectMake(self.view.bounds.origin.x, contentY, self.view.bounds.size.width, self.view.bounds.size.height);
    _navigationBarView.hidden = YES;
}

//设置标题
-(void)setNavigationBarTitle:(NSString *)title
{
    [_navigationBarView setNavigationBarTitle:title];
}


//导航上标题图片
- (void)setNavBarTitleImage:(UIImage *)img
{
    [_navigationBarView setNavBarWithImgTitle:img];
}

/**
 *  设置导航栏上的按钮
 *
 *  @param style     分为左边按钮 右边按钮
 *  @param image     normal 状态下的image
 *  @param highImage 高亮状态下的image
 */
-(void)setButtonStyle:(UIButtonStyle)style andImage:(UIImage *)image highImage:(UIImage *)highImage
{
    UIButton *button = [self buttonInitWithStyle:style];
    self.imageButton = button;
    [_navigationBarView addSubview:button];
    [button setImage:image forState:UIControlStateNormal];
    if (highImage) {
        [button setImage:highImage forState:UIControlStateHighlighted];
    }
    if (style == UIButtonStyleQuestion) {
        [button setImage:highImage forState:UIControlStateSelected];

    }
    //UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    [self buttonAction:button withStyle:style];
}



/**
 *  设置导航栏上的按钮
 *
 *  @param style    分为左边按钮 右边按钮
 *  @param title     显示的文本
 *  @param textColor 文本的显示颜色
 *  @param font      文本的字体大小
 */
-(void)setButtonStyle:(UIButtonStyle)style andTitle:(NSString *)title textColor:(UIColor*)textColor font:(UIFont *)font
{
    UIButton *button = [self buttonInitWithStyle:style];
    [self.titleButton removeFromSuperview];
    [_navigationBarView addSubview:button];
    self.titleButton = button;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
        [button setTitleColor:BaseColor forState:UIControlStateHighlighted];
    }
    button.showsTouchWhenHighlighted = YES;
    if (font) {
        button.titleLabel.font = font;
    }
    [self buttonAction:button withStyle:style];
}

//初始化button--主要是设置button的frame
-(UIButton*)buttonInitWithStyle:(UIButtonStyle)style
{
    int top;
    if (ISLESS_IOS7) {
        top = 8;
    }else{
        top = 20;
    }
    //导航按钮距离屏幕左边,右边的间距，及 btn 宽高
    int right;
    int btnWidth;
    int btnHeight;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [_navigationBarView addSubview:button];
    if (style == UIButtonStyleModelBack || style == UIButtonStylePerson) {
        if (!iPhone6Plus) {
            button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            btnWidth = 50;
            btnHeight = 44;
        }else{
            button.contentEdgeInsets = UIEdgeInsetsMake(5, 11, 4, 19);
            btnWidth = 66;
            btnHeight = 45;
        }
        button.tag = 10000;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_navigationBarView.mas_top).offset(top); //with with
            make.left.equalTo(_navigationBarView.left).offset(0); //without with
            make.width.equalTo(btnWidth);
            make.height.equalTo(btnHeight); //can pass array of views
        }];
    }else if(style == UIButtonStyleRegister){
        int btnTop;
        button.tag = 20000;
        if (!iPhone6Plus) {
            btnTop = 16;
            right = 10;
            button.contentEdgeInsets = UIEdgeInsetsMake(5, 0, 15, 20);
            btnWidth = 64;
            btnHeight = 64;
            button.titleLabel.font = UIFontSize(18);
        }else{
            btnTop = 20;
            right = 15;
            button.contentEdgeInsets = UIEdgeInsetsMake(5, 0, 25, 30);
            btnWidth = 66;
            btnHeight = 66;
        }
        if (iPhone6) {
            button.titleLabel.font = UIFontSize(17);
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_navigationBarView.mas_top).offset(btnTop); //with with
            make.right.equalTo(_navigationBarView.right).offset(right); //without with
            make.width.equalTo(btnWidth);
            make.height.equalTo(btnHeight); //can pass array of views
        }];
    }else if (style == UIButtonStyleQuestion){
        button.tag = 601;
        int btnTop;
        if (!iPhone6Plus) {
            btnTop = 16;
            button.contentEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
            btnWidth = 90;
            btnHeight = 44;
        }else{
            btnTop = 21;
            button.contentEdgeInsets = UIEdgeInsetsMake(2, 15, 2, 15);
            btnWidth = 100;
            btnHeight = 44;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_navigationBarView.mas_top).offset(top); //with with
            if (iPhone6Plus) {
                make.right.equalTo(_navigationBarView.right).offset(8);
            }else{
                make.right.equalTo(_navigationBarView.right).offset(0);
            }
            make.width.equalTo(btnWidth);
            make.height.equalTo(btnHeight); //can pass array of views
        }];
    }else if(style == UIButtonStyleBack){
        button.tag = 602;
        if (!iPhone6Plus) {
            button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            btnWidth = 49;
            btnHeight = 49;
        }else{
            button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 4, 20);
            btnWidth = 66;
            btnHeight = 45;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_navigationBarView.mas_top).offset(top); //with with
            make.left.equalTo(_navigationBarView.left).offset(0); //without with
            make.width.equalTo(btnWidth);
            make.height.equalTo(btnHeight); //can pass array of views
        }];
    }else if (style == UIButtonStyleShare){
        button.tag = 603;
        int btnTop;
        if (!iPhone6Plus) {
            btnTop = 16;
            button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            btnWidth = 44;
            btnHeight = 44;
        }else{
            btnTop = 21;
            button.contentEdgeInsets = UIEdgeInsetsMake(4, 25, 4, 5);
            btnWidth = 66;
            btnHeight = 44;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_navigationBarView.mas_top).offset(top);
            make.right.equalTo(_navigationBarView.right).offset(-50);
            make.width.equalTo(btnWidth);
            make.height.equalTo(btnHeight); //can pass array of views
        }];
    }
    return button;
}

//按钮关联的事件
-(void)buttonAction:(UIButton *)button withStyle:(UIButtonStyle)style
{
    if (style == UIButtonStyleRight || style == UIButtonStyleRegister || style ==UIButtonStyleQuestion ||style == UIButtonStyleShare) {
        [button addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [button addTarget:self action:@selector(leftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//导航上面按钮事件
//左边按钮关联的触发方法
- (void)leftBarButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//右边导航栏上的按钮关联的触发方法
-(void)rightBarButtonClick:(UIButton *)button
{
    
}
/**
 *
 *
 *  获取用户类型(返回的是否是BC)
 */

- (BOOL)getUserTypeIsBc{

    NSString *type = [[UserManager shareManager]getCurrentUser].type;
    if ([type isEqualToString:@"2"]) {
        return YES;
    }
    return NO;
}

- (void)navBtnEnable:(BOOL)isEnable
{
    UIButton *rightBtn = (UIButton *)[self.navigationBarView viewWithTag:20000];
    if (isEnable) {
        rightBtn.enabled = YES;
    }else{
        rightBtn.enabled = NO;
    }
}

- (void)navlineViewIsHidden:(BOOL)isHidden;
{
    self.navigationBarView.lineView.hidden = isHidden;
}

- (void)navBGAlpha
{
    self.navigationBarView.backgroundColor = [UIColor clearColor];
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark  键盘事件
///////////////////////////////////////////////////////////////////////////////

-(BOOL)isEnableKeyboardManger
{
    return YES;
}

-(void)enableKeyboardManger
{
    
    if (![self isEnableKeyboardManger])
    {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    /*Registering for textField notification*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidBeginEditingNotification:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidEndEditingNotification:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
    
    /*Registering for textView notification*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidBeginEditingNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidEndEditingNotification:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:nil];
    
}

-(void)disableKeyboardManager
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setContentViewTop:(float)contentViewTop
{
    self.view.frametop = contentViewTop;
    _contentViewTop = contentViewTop;
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    
    NSLog(@"keyboardWillShow=%@",_editingTextFieldOrTextView);
    
    if (!_editingTextFieldOrTextView)
    {
        return;
    }
    /*
     获取通知携带的信息
     */
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect toView:self.view];
    
    CGRect textViewRect =  [_editingTextFieldOrTextView.superview convertRect:_editingTextFieldOrTextView.frame toView:self.view];
    
    
    float offsetY  = (textViewRect.origin.y + textViewRect.size.height) - keyboardRect.origin.y;
    
    //输入框未被键盘遮挡 无需调整
    if (offsetY <=0)
    {
        return;
    }
    
    //  offsetY += IOS_VERSION_CODE < IOS_SDK_7 ? 44 :0;
    
    //获取键盘的动画执行时长
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frametop = -keyboardRect.size.height;
    
    [UIView commitAnimations];
}


-(void)keyboardWillHide:(NSNotification *)notification
{
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frametop = 0;
    
    [UIView commitAnimations];
}

#pragma mark - UITextField Delegate methods
//Fetching UITextField object from notification.
-(void)textFieldDidBeginEditingNotification:(NSNotification *) notification
{
    _editingTextFieldOrTextView = notification.object;
    if ([_editingTextFieldOrTextView isKindOfClass:[UITextField class]])
    {
        //        UITextField *textFiled = (UITextField *)_editingTextFieldOrTextView;
        //        _textViewOrFieldOrgDelegate = textFiled.delegate;
        //        [textFiled setDelegate:self];
    }else if ([_editingTextFieldOrTextView isKindOfClass:[UITextView class]]) {
        
        //        TextView写死高度 键盘
        CGRect textViewRect =  [_editingTextFieldOrTextView convertRect:_editingTextFieldOrTextView.frame toView:self.view];
        
        
        if (textViewRect.origin.y + textViewRect.size.height < SCREEN_HEIGHT - 216)
        {
            return;
        }
        float offsetY  =  (textViewRect.origin.y - 216);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        if (offsetY+ 20>=0) {
            self.view.frametop = -216;
        }
        
        [UIView commitAnimations];
    }
}

//Removing fetched object.
-(void)textFieldDidEndEditingNotification:(NSNotification*)notification
{
    if ([_editingTextFieldOrTextView isKindOfClass:[UITextField class]])
    {
        //        UITextField *textFiled = (UITextField *)_editingTextFieldOrTextView;
        //        [textFiled setDelegate:_textViewOrFieldOrgDelegate];
        
    }
    
    [_editingTextFieldOrTextView resignFirstResponder];
    _editingTextFieldOrTextView = nil;
    _textViewOrFieldOrgDelegate =nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing];
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing];
}


- (void)endEditing
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
