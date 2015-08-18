
//The MIT License (MIT)
//
//Copyright (c) 2013 Rafał Augustyniak
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of
//this software and associated documentation files (the "Software"), to deal in
//the Software without restriction, including without limitation the rights to
//use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//the Software, and to permit persons to whom the Software is furnished to do so,
//subject to the following conditions:
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@interface RADataObject : NSObject

@property (strong, nonatomic) NSString *cid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray  *children;
@property (strong, nonatomic) NSString *agency_id;
@property (strong, nonatomic) NSString *parent_id;
@property (strong, nonatomic) NSString *region_id;
@property (strong, nonatomic) NSString *region_type;

- (id)initWithName:(NSString *)name children:(NSArray *)array;


- (id)initWithName:(NSString *)name andCid:(NSString *) cid children:(NSArray *)array;

- (id)initWithName:(NSString *)name andAgency_id:(NSString *)agency_id andParent_id:(NSString *)parent_id andPegion_id:(NSString *)region_id  children:(NSArray *)array;

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children;

+ (id)dataObjectWithName:(NSString *)name andAgency_id:(NSString *)agency_id andParent_id:(NSString *)parent_id andPegion_id:(NSString *)region_id  children:(NSArray *)array;;

+ (id)dataObjectWithName:(NSString *)name andCid:(NSString *) cid children:(NSArray *)array;
@end
