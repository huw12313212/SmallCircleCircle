//
//  FakeDB.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "FakeDB.h"


@implementation FakeDB

static FakeDB *instance = nil;
const float FAKE_DELAY = 1000;

+(FakeDB*)GetDBInstance
{
    if(instance == nil)
    {
        instance = [[FakeDB alloc]init];
    }
    return instance;
}

-(void) GetCreatedActivityAsync:(void(^)(int,NSArray*)) callback
{
    
}

-(void) GetJoinedActivityAsync:(void(^)(int,NSArray*)) callback
{
    
}



-(NSArray*) GetCreatedActivity
{
    return @[@{@"id":@(0),@"name":@"小熊團購1",@"status":@(ASRecruting)},
             @{@"id":@(1),@"name":@"小熊團購2",@"status":@(ASFailed)},
             @{@"id":@(2),@"name":@"小熊團購3",@"status":@(ASSuccess)}];
}

-(NSArray*) GetJoinedActivity
{
    return @[@{@"id":@(3),@"name":@"包子團購1",@"status":@(ASRecruting)},
             @{@"id":@(4),@"name":@"包子團購2",@"status":@(ASFailed)},
             @{@"id":@(5),@"name":@"包子團購3",@"status":@(ASSuccess)}];
}

@end
