//
//  QQAutoSizeLabel.m
//  Test
//
//  Created by mac  on 14-6-28.
//  Copyright (c) 2014年 qiuyan. All rights reserved.
//

#import "QQAutoSizeLabel.h"
#import "UIView+ITTAdditions.h"
#import "ASMaterialModel.h"

@interface QQAutoSizeLabel()
{
    CGFloat contentHeight;
}
@property (nonatomic, retain) UIView *containView;
@property (nonatomic, retain) NSMutableArray * tempArray;
@property (nonatomic, retain) NSMutableArray * allViewArray;

@end

@implementation QQAutoSizeLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)setHotViewWithArray:(NSArray*)resultArray andSampleLabelFont:(CGFloat)fontSize height:(CGFloat)labelHeight{
        
    _containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containView];
    
    UIFont * font = UIFontSize(fontSize);
    float height = 0;
    float labelWidth = 0;
    UIView * previousLabel = nil;
    
    _tempArray = [[NSMutableArray alloc] initWithCapacity:5];
    _allViewArray  = [[NSMutableArray alloc]init];
    for (int i=0;i<resultArray.count;i++) {
        //创建标签
        ASMaterialModel * tagModel = [resultArray objectAtIndex:i];
        NSString * labelTitle = tagModel.materialName;
        
        CGSize size = [labelTitle sizeWithFont:font];
        labelWidth = size.width + 20;
        height = labelHeight;
        if (labelWidth > 300) {
            size = [labelTitle sizeWithFont:font constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            labelWidth = 300;
            height = size.height + 5;
        }
        
        int tag = [tagModel.ids intValue] + 100;

        UIImageView * adopLabel = [self createHotLabelWithPreviousLabel:previousLabel andText:labelTitle andWidth:labelWidth andHeight:height andLabTag:tag];
        //  调色
        adopLabel.backgroundColor = [UIColor clearColor];
        adopLabel.layer.borderColor = BaseColor.CGColor;
        adopLabel.tag = [tagModel.ids intValue];
        //添加位置
        if (adopLabel.frameright > self.containView.frameright) { //下一行(需要换行)
            float width = self.containView.framewidth - previousLabel.frameright;
            //开始布局
            [self layoutLabelWithArray:_tempArray andWidth:width andIsLastLine:NO];
            [_tempArray removeAllObjects];
            adopLabel.frame = CGRectMake(0, previousLabel.framebottom+15.0f, adopLabel.framewidth, height);
            [self.containView addSubview:adopLabel];
        }else{//不变行（不需要换行）
            [_tempArray addObject:adopLabel];
            [self.containView addSubview:adopLabel];
        }
        previousLabel = adopLabel;
    }
    self.containView.frameheight = previousLabel.framebottom + 10.0f;
    
    if (previousLabel.framebottom > 0) {
        contentHeight = previousLabel.framebottom + 10;
    }else {
        contentHeight = height;
    }
    if (self.containViewHeightBlock) {
        self.containViewHeightBlock(self.containView.frameheight);
    }

    if (_allViewArray.count > 0) {
        UIView *tempView = [_allViewArray objectAtIndex:0];
        UILabel * labelView = [[tempView subviews] lastObject];
        tempView.backgroundColor = BaseColor;
        labelView.textColor = [UIColor whiteColor];
    }
    
}


//创建标签
- (UIImageView *)createHotLabelWithPreviousLabel:(UIView*)previousLabel
                                         andText:(NSString*)text
                                        andWidth:(float)width
                                       andHeight:(float)height
                                       andLabTag:(int)tag
{
    CGRect frame;
    if (previousLabel == nil) {
        frame = CGRectMake(0.0f, 0.0f, width, height);
        
    }else{
        frame = CGRectMake(previousLabel.frameright + 10, previousLabel.frametop, width, height);
    }
    UILabel *adopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    adopLabel.backgroundColor = [UIColor clearColor];
    adopLabel.font = [UIFont systemFontOfSize:13];
    adopLabel.text = text;
    adopLabel.tag = tag;
    if (height > 27) {
        adopLabel.textAlignment = NSTextAlignmentCenter;
        adopLabel.framewidth = width - 10;
    }else{
        adopLabel.textAlignment = NSTextAlignmentCenter;
    }

    adopLabel.textColor = BaseColor;
    adopLabel.autoresizesSubviews = YES;
    adopLabel.numberOfLines = 0;
    
    //    UIImage * bgImage = ImageByName(@"green");
    //    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.layer.cornerRadius = 10.0f;
    imageView.layer.borderWidth = 1.0f;
    //    imageView.layer.borderColor = RGBColorBySingle(0.2627f).CGColor;
    
    //  imageView.layer.borderColor = RGBCOLOR(85, 219, 231).CGColor;
    
    imageView.userInteractionEnabled = YES;
    [imageView addSubview:adopLabel];
    
    NSLog(@"%@",imageView);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taplabel:) ];
    [imageView addGestureRecognizer:tap];
    
    [_allViewArray addObject:imageView];

    return imageView ;
}

//布局标签
- (void)layoutLabelWithArray:(NSMutableArray *)labelArray andWidth:(float)width andIsLastLine:(BOOL)lastLine{
    NSRange arrayRange;
    arrayRange.location = 0;
    if (lastLine) {
        arrayRange.length = labelArray.count;
    }else{
        arrayRange.length = labelArray.count;
    }
    NSArray * layoutArray = [labelArray subarrayWithRange:arrayRange];
    float averageWith = width/layoutArray.count;
    
    
    for(int i=0;i<layoutArray.count;i++){
        UIView * tempView = [layoutArray objectAtIndex:i];
        tempView.framewidth = tempView.framewidth + averageWith;
        UIView * labelView = [[tempView subviews] lastObject];
        labelView.center = CGPointMake(tempView.framewidth / 2, tempView.frameheight / 2);
        if(i==0){
            continue;
        }else{
            tempView.frameleft = tempView.frameleft + averageWith*i;
        }
    }
}

#pragma mark 点击热门标签
-(void)taplabel:(UIGestureRecognizer*)gesture
{
    UILabel * label = (UILabel *)gesture.view;
    
    for (int i = 0 ; i < _allViewArray.count;  i ++) {
        UIView *tempView = [_allViewArray objectAtIndex:i];
        UILabel * labelView = [[tempView subviews] lastObject];
        if (gesture.view != tempView) {
            tempView.backgroundColor = [UIColor clearColor];
            labelView.textColor = BaseColor;
        } else {
            tempView.backgroundColor = BaseColor;
            labelView.textColor = [UIColor whiteColor];
        }
    }
    
    if (self.hotTagClickBlock) {
        self.hotTagClickBlock(label.tag);
    }
    
    UILabel *lab = (UILabel *)[label viewWithTag:label.tag + 100];
   
    if (self.hotTagNameBlock) {
        self.hotTagNameBlock(lab.text);
    }
}

- (void) setSelectAtIndex:(NSInteger)index {
    
    for (int i = 0 ; i < _allViewArray.count;  i ++) {
        UIView *tempView = [_allViewArray objectAtIndex:i];
        UILabel * labelView = [[tempView subviews] lastObject];
        if (tempView.tag != index) {
            tempView.backgroundColor = [UIColor clearColor];
            labelView.textColor = BaseColor;
        } else {
            tempView.backgroundColor = BaseColor;
            labelView.textColor = [UIColor whiteColor];
        }
    }
}

- (CGFloat)containHeight {

    return contentHeight;

}

@end
