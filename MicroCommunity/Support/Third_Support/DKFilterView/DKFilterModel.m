//
//  DKFilterModel.m
//  Partner
//
//  Created by Drinking on 14-12-19.
//  Copyright (c) 2014年 zhinanmao.com. All rights reserved.
//

#import "DKFilterModel.h"
#import "DKFilterCell.h"
#import "DKMacros.h"

@implementation DKFilterModel

- (instancetype)initElement:(NSArray*)array ofType:(DKFilterType)type{
    if (self = [super init]) {
        _elements = array;
        self.type = type;
        self.style = DKFilterViewDefault;
    }
    return self;
}


- (UIView *)getCustomeViewofWidth:(CGFloat)width{
    
    _sv = [[DKFilterCell alloc] init:self Width:width];
    if (self.style == DKFilterViewDefault) {
        _sv.buttonWidth = 100;
        _sv.buttonHeight = 30;
        _sv.paddingHorizontal = 8;
        _sv.paddingVertical = 18;
        _sv.paddingBottom = 8;
    }else if(self.style == DKFilterViewStyle1){
        _sv.buttonWidth = 95;
        _sv.buttonHeight = 30;
        _sv.paddingHorizontal = 8;
        _sv.buttonNormalColor = DK_HL_COLOR;
        _sv.buttonHighlightColor = DK_HL_COLOR;
    }
    return _sv;
}

- (NSArray *)getFilterResult;{
    if (self.cachedView && [self.cachedView isKindOfClass:
                            [DKFilterCell class]]){
        DKFilterCell *view = (DKFilterCell *)self.cachedView;
        return [view getSelectedValues];
    }
    return @[];
}
@end
