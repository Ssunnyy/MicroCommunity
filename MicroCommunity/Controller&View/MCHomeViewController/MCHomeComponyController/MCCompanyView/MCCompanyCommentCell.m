//
//  MCCompanyCommentCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyCommentCell.h"

@interface MCCompanyCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *pariseLab;
@property (weak, nonatomic) IBOutlet UIButton *pariseBtn;


@end

@implementation MCCompanyCommentCell

- (void)awakeFromNib {
    // Initialization code
    [_headImage makeCircleView];
}

- (void)configCellWithMCCompanyCommentModel:(MCCompanyCommentModel *)model {

//    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:ImageNamed(@"")];
//    _userName.text = model.nickName;
//    _dataLab.text = model.date;
//    _pariseLab.text = model.pariseCount;
    _contentLab.text = model.comment;
}
- (IBAction)pariseBtnClick:(UIButton *)sender {

    if (_delegate && [_delegate respondsToSelector:@selector(pariseAtIndex:)]) {
        [_delegate pariseAtIndex:sender.tag];
    }
}


- (void)setPariseBtnTag:(NSInteger)index {

    _pariseBtn.tag = index;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
