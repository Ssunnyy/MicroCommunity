//
//  NSArray+ITTAdditions.h
//  iTotemFrame
//
//  Created by guo hua on 11-9-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(ITTAdditions)

/**
 *  数组中是否包含某个字符串
 *
 *  @param string 字符串
 *
 *  @return
 */
-(BOOL)contentString:(NSString *)string;

/**
 *  字符串在数组中的index
 *
 *  @param string 字符串
 *
 *  @return index
 */
-(NSInteger)indexOfString:(NSString *)string;
@end
