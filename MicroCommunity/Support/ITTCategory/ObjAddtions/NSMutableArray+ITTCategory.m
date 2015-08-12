//
//  NSMutableArray+ITTCategory.m
//
//  Created by keke on 14-7-19.
//
//

#import "NSMutableArray+ITTCategory.h"

@implementation NSMutableArray (ITTCategory)
-(void)safeString:(NSString*)string
{
    if (string) {
        if (![string isKindOfClass:[NSNull class]]) {
            [self addObject:string];
        }else
        {
            [self addObject:@""];
        }
    }else
    {
        [self addObject:@""];
    }
}
-(void)safeObject:(id)object
{
    if (object) {
        if (![object isKindOfClass:[NSNull class]]) {
            [self addObject:object];
        }
    }
}
@end
