//
//  MCAutoSizeLab.h
//  
//
//  Created by apple on 15/8/5.
//
//

#import <UIKit/UIKit.h>

@interface MCAutoSizeLab : UIView

@property (nonatomic, copy) void (^ciytTagClickBlock)(NSUInteger currentIndex);

@property (nonatomic, assign) CGFloat currenHeight;

-(void)setHotViewWithArray:(NSArray*)resultArray andSampleLabelFont:(CGFloat)fontSize height:(CGFloat)labelHeight ;

- (instancetype)initWithFrame:(CGRect)frame;

@end
