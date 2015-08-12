//
//  MCIMSelectUserCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCIMSelectUserCell.h"

@implementation QQButton

@synthesize indexPath;

@end

@interface MCIMSelectUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@end

@implementation MCIMSelectUserCell

- (void)awakeFromNib {
    // Initialization code
    
    [_headImage makeCircleView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)chooseFriend:(QQButton *)sender
{
    self.selectBtn.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(chooseBtnClick:andChoose:)]) {
        [_delegate chooseBtnClick:sender.indexPath andChoose:self.selectBtn.selected];
    }
}


- (void)setContentCell:(QRemindLookModel *)model andChooseArray:(NSArray *) choose
{
    
    BOOL contan = NO;
    for (QRemindLookModel *mo in choose) {
        if ([mo.userid isEqualToString:model.userid]) {
            contan = YES;
            break;
        }
    }
    
    if ([model.isChoose isEqualToString:@"1"] || contan) {
        self.selectBtn.selected = YES;
    }else{
        self.selectBtn.selected = NO;
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headpic] placeholderImage:ImageNamed(@"")];
    if ([model.sex isEqualToString:@"1"]) {//男
        self.sexImage.image = ImageNamed(@"sex_male.png");
    }else if([model.sex isEqualToString:@"2"]){
        self.sexImage.image = ImageNamed(@"sex_famale.png");
    }
    self.nickName.text = model.username;
}


@end
