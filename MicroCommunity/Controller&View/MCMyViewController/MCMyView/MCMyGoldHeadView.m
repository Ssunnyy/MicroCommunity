//
//  MCMyGoldHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyGoldHeadView.h"

@interface MCMyGoldHeadView ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *goldCount;


@end

@implementation MCMyGoldHeadView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)sendGold:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendGoldToOther)]) {
        [_delegate sendGoldToOther];
    }
    
}

@end
