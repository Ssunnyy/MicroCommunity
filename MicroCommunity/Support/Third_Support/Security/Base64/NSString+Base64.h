//
//  NSString+Base64.h
//  WenYiTing
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Base64)

- (NSString *) stringEncodeBase64;
- (NSString *) stringDecodeBase64;

@end