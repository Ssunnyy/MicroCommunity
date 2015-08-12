//
//  MCAutoSizeLab.m
//  
//
//  Created by apple on 15/8/5.
//
//

#import "MCAutoSizeLab.h"
#import "RADataObject.h"

@interface MCAutoSizeLab ()

@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) NSMutableArray *dataAray;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat labelHeight;

@end

@implementation MCAutoSizeLab

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void) initView {

    _dataAray = [[NSMutableArray alloc]init];
    _countLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 15)];
    _countLab.textColor = RGBCOLOR(85, 85, 85);
    _countLab.font = [UIFont systemFontOfSize:14];
    _countLab.backgroundColor = [UIColor clearColor];
    [self addSubview:_countLab];
    
    _containView = [[UIView alloc] initWithFrame:CGRectMake(0, _countLab.framebottom , SCREEN_WIDTH, self.frameheight - 15)];
    self.containView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containView];
}

-(void)setHotViewWithArray:(NSArray*)resultArray andSampleLabelFont:(CGFloat)fontSize height:(CGFloat)labelHeight {
    
    _fontSize = fontSize;
    _labelHeight = labelHeight;
    [_dataAray removeAllObjects];
    [_containView removeAllSubviews];
    [_dataAray addObjectsFromArray:resultArray];
    _countLab.text = [NSString stringWithFormat:@"已选择的区域(%ld)",resultArray.count];
    UIFont * font = UIFontSize(fontSize);
    float labHeight = 10;
    float labelWidth = 10;;
    for ( int i = 0;  i < resultArray.count; i ++) {
        
        RADataObject *data = [resultArray objectAtIndex:i];
        
        NSString *labelTitle = [NSString stringWithFormat:@"  %@",data.name];
        
        CGSize size = [labelTitle sizeWithFont:font];
        
        float btnWidth = size.width + 28;
        float btnHeight = labelHeight + 5;
        
        float lineWidth = labelWidth + btnWidth;
        if (lineWidth > (SCREEN_WIDTH - 20)) {
            labelWidth = 10;
            labHeight += (btnHeight + 5);
        }
        
        UIImage *buttonImage = [UIImage imageNamed:@"ico_area_bg1.png"];
        buttonImage = [buttonImage stretchableImageWithLeftCapWidth:floorf(buttonImage.size.width/2) topCapHeight:floorf(buttonImage.size.height/2)];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:labelTitle forState:UIControlStateNormal];
        btn.titleLabel.font = font;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setBackgroundImage:buttonImage forState:UIControlStateNormal];
        btn.frame = CGRectMake(labelWidth + 3, labHeight + 5, btnWidth, btnHeight);
        btn.tag = i + 1000;
        [btn addTarget:self action:@selector(currentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.containView addSubview:btn];
        
        labelWidth += btnWidth + 12;
        if (labelWidth > (SCREEN_WIDTH - 20)) {
            labelWidth = 10;
            labHeight += (btnHeight + 5);
        }
    }
    if (labHeight > 150 - 15 - 20) {
        self.frameheight = labHeight + 15 + 60;
        self.containView.frameheight = self.frameheight - 20;
    }
    self.currenHeight = self.frameheight;
}
#pragma  mark  --  button点击事件
- (void) currentBtnClick:(UIButton *) button {

    NSInteger index = button.tag - 1000;
    [_dataAray removeObjectAtIndex:index];
    NSArray *array = [NSMutableArray arrayWithArray:_dataAray];
    [self setHotViewWithArray:array andSampleLabelFont:_fontSize height:_labelHeight];
    
    if (self.ciytTagClickBlock) {
        self.ciytTagClickBlock(index);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
