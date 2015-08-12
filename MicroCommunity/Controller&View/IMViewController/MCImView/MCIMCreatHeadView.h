//
//  MCIMCreatHeadView.h
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCIMCreatHeadViewDelegate <NSObject>

- (void) currentBtnClickAtIndex:(NSInteger) index;

@end

@interface MCIMCreatHeadView : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *firendScrollView;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImages;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBtn_left;
@property (weak, nonatomic) IBOutlet UILabel *talkName;
@property (weak, nonatomic) IBOutlet UILabel *mainTalk;
@property (weak, nonatomic) IBOutlet UITextView *talkDescription;
@property (weak, nonatomic) IBOutlet UIButton *deleteTalkBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeNameBtn;
@property (weak, nonatomic) IBOutlet UIImageView *moreImage;


@property (nonatomic,assign) id <MCIMCreatHeadViewDelegate> delegate;

- (void) configCellWith:(id) model andIsSelf:(BOOL) isSelf;
- (void) setHeadImage:(UIImage *) image;
- (UIImage *) getHeadImage;
@end
