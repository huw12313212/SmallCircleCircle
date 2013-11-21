//
//  FakeDB.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBQueryInterface.h"

@interface FakeDB : NSObject <DBQueryInterface>

+(FakeDB*)GetDBInstance;


@end
