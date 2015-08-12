//
//  QRemindLookModel.m
//  Mimi
//
//  Created by qiuyan on 14-9-10.
//
//

#import "QRemindLookModel.h"

@implementation QRemindLookModel

- (NSDictionary *)attributeMapDictionary {
    return @{
             @"headpic":@"headpic",
             @"sex":@"sex",
             @"userid":@"userid",
             @"username":@"username",
             @"pinYin":@"pinYin",
             @"isChoose":@"isChoose",
            };
}

@end
