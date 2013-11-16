//
//  DBQueryInterface.h
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import <Foundation/Foundation.h>

enum DatabaseEventType
{
    DBsuccess,
    DBTimeout,
    DBError,
    DBnoNetwork,
};

enum ActivityStatus
{
    ASRecruting,
    ASFailed,
    ASSuccess,
};



@protocol DBQueryInterface <NSObject>

@required
-(void) GetCreatedActivityAsync:(void(^)(int,NSArray*)) callback;
-(void) GetJoinedActivityAsync:(void(^)(int,NSArray*)) callback;

-(NSArray*) GetCreatedActivity;
-(NSArray*) GetJoinedActivity;
@end
