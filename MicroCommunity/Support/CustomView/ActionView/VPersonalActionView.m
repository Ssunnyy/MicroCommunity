//
//  VPersonalActionView.m
//  Mimi
//
//  Created by ligh on 14-6-3.
//
//

#import "VPersonalActionView.h"

@interface VPersonalActionView ()

@end

@implementation VPersonalActionView

- (void)awakeFromNib {
    self.frameheight = SCREEN_HEIGHT;
    self.framewidth = SCREEN_WIDTH;
    self.frametop = SCREEN_HEIGHT;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/**
 *  获取视图
 *
 *  @return VPersonalActionView
 */
+ (VPersonalActionView *)getVPersonalActionView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"VPersonalActionView" owner:self options:nil] lastObject];
}
/**
 *  设置标题
 *
 *  @param strArr
 */
- (void)setUpBtnTitle:(NSArray *)strArr
{
    for (NSInteger i = 0; i < strArr.count; i ++) {
        UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 55*(i + 1), SCREEN_WIDTH - 40, 45)];
        actionBtn.tag = (strArr.count - 1 - i) + 100;
        NSString *btnTitle = [strArr objectAtIndex:(strArr.count - 1 - i)];
        if ([btnTitle isEqualToString:@"取消"]) {
            [actionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [actionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
            
        }else{
            
            if (_isFriendCircle) {
                [actionBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [actionBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

            }else{
                [actionBtn setTitleColor:BaseColor forState:UIControlStateNormal];
                [actionBtn setTitleColor:BaseColor forState:UIControlStateHighlighted];
            }
        }
        
        [actionBtn setTitle:btnTitle forState:UIControlStateNormal];
        [actionBtn setTitle:btnTitle forState:UIControlStateHighlighted];
        [actionBtn setBackgroundImage:[UIImage imageNamed:@"tcanniu.png"] forState:UIControlStateNormal];
        [actionBtn setBackgroundImage:[UIImage imageNamed:@"tcanniu.png"] forState:UIControlStateHighlighted];
        [actionBtn addTarget:self action:@selector(tapWithTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:actionBtn];
    }
}

#pragma  mark  --  显示视图
- (void) showActionView {
    __weak UIView *week = self;
    [UIView animateWithDuration:.3f animations:^{
        week.framebottom = SCREEN_HEIGHT;
        [[AppDelegate GetAppDelegate].window addSubview:week];
    }];
}

#pragma  mark  --  隐藏视图
- (void) hidenActionView {

    __weak UIView *week = self;
    
    [UIView animateWithDuration:0.3f animations:^{
        week.frametop = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            [week removeFromSuperview];
        }];
    }];
}

#pragma mark -- 按钮事件
- (void) tapWithTag:(UIButton *)sender
{
    if (_actionDelegate && [_actionDelegate respondsToSelector:@selector(blackListOrCancelClick:)]) {
        [_actionDelegate blackListOrCancelClick:sender.tag];
    }
}
@end
