//
//  QRemindLookModel.h
//  Mimi
//
//  Created by qiuyan on 14-9-10.
//
//

#import "ITTBaseModelObject.h"

@interface QRemindLookModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *headpic;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *pinYin;
@property (nonatomic, strong) NSString *isChoose;//1选中 2 不选中

@end
