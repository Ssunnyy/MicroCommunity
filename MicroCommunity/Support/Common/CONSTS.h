//
//  CONSTS.h
//  iTotemFrame
//
//  Copyright 2010 iTotem Studio. All rights reserved.
//
typedef enum : NSUInteger{
    kTagHintView = 101
} HintViewTag;



///用户身份（BC  OR  CC）

typedef enum
{
    ASPersonTypeUser = 1,//用户
    ASPersonTypeBusiness,//婚庆从业者
} ASPersonType;