
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

#import "RADataObject.h"

@implementation RADataObject

- (id)initWithName:(NSString *)name children:(NSArray *)children
{
  self = [super init];
  if (self) {
    self.children = children;
    self.name = name;
  }
  return self;
}

- (id)initWithName:(NSString *)name andCid:(NSString *) cid children:(NSArray *)array {

    self = [super init];
    if (self) {
        self.name = name;
        self.cid = cid;
        self.children = array;
    }
    return self;
}

- (id)initWithName:(NSString *)name andAgency_id:(NSString *)agency_id andParent_id:(NSString *)parent_id andPegion_id:(NSString *)region_id  children:(NSArray *)array{

    self = [super init];
    if (self) {
        self.children = array;
        self.name = name;
        self.agency_id = agency_id;
        self.parent_id = parent_id;
        self.region_id = region_id;
    }
    return self;
    
}


+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children
{
  return [[self alloc] initWithName:name children:children];
}

+ (id)dataObjectWithName:(NSString *)name andAgency_id:(NSString *)agency_id andParent_id:(NSString *)parent_id andPegion_id:(NSString *)region_id  children:(NSArray *)array; {

    return [[self alloc] initWithName:name andAgency_id:agency_id andParent_id:parent_id andPegion_id:parent_id children:array];
}

+ (id)dataObjectWithName:(NSString *)name andCid:(NSString *) cid children:(NSArray *)array {
    return [[self alloc]initWithName:name andCid:cid children:array];
}

@end
