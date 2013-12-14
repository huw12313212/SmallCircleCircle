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

-(NSArray*) GetCreatedActivity : (NSString*)facebookID ;
-(NSArray*) GetJoinedActivity : (NSString*)facebookID ;


-(NSDictionary*)GetActivityDetail:(NSString*)activityID;

-(NSArray*)GetBuyList:(NSString*)activityID;

-(NSDictionary*)GetTargetOrderList:(NSString*)orderID;

-(void)FinishedBuy:(NSString*)orderID;


-(NSString*) CreateActivity:(NSString*)facebookID :(NSDictionary*)ActivityDetail;
-(int)JoinActivity:(NSString*)facebookID :(NSString*)ActivityID :(NSDictionary*)Detail;

-(void)DeleteActivity:(NSString*)activityID;

@optional
-(NSDictionary*)GetMyBuyListInActivity:(NSString*)facebookID :(NSString*)activityID;

@end
