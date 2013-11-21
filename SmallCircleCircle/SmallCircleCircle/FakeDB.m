//
//  FakeDB.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "FakeDB.h"
#import <Parse/Parse.h>


@implementation FakeDB

static FakeDB *instance = nil;
static NSCache *cache;
const float FAKE_DELAY = 1000;

+(FakeDB*)GetDBInstance
{
    if(instance == nil)
    {
        [Parse setApplicationId:@"jigcccFU23yCJWb51bJ7Htt70ipoprGeouMUJNBb"
                      clientKey:@"hmbyJNUBVfjqAWwfwDDTCxfRAOACPqjFrOGaInZB"];
        instance = [[FakeDB alloc]init];
        cache = [[NSCache alloc] init];
    }
    return instance;
}

+ (NSCache *)sharedCache {
    static NSCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}


-(NSArray*) GetCreatedActivity :(NSString*)facebookID
{
    //為了讓parse可以跑，因為一開始要load頁面，但是appdelegate還沒準備好
   /* [Parse setApplicationId:@"jigcccFU23yCJWb51bJ7Htt70ipoprGeouMUJNBb"
                  clientKey:@"hmbyJNUBVfjqAWwfwDDTCxfRAOACPqjFrOGaInZB"]; */
    NSMutableArray * result = [[NSMutableArray alloc] init];
    //開始從parse 搜尋資料 找資料庫（class）為CircleList
    PFQuery *query = [PFQuery queryWithClassName:@"CircleList"];
    // userID = facebookID 用FacebookID找出使用者的團購list
    [query whereKey:@"userID" equalTo:facebookID];
    NSArray *objects = [query findObjects];
    for (PFObject *object in objects) {
        NSDictionary *detail = object[@"Detail"];
        NSDictionary * temp = @{@"id":object.objectId,@"name":detail[@"name"],@"status":detail[@"status"]};
        [result addObject:temp];
        NSString *cacheKey = [NSString stringWithFormat:@"SSCDetail-%@", object.objectId];
        [cache setObject:detail forKey:cacheKey];
    }
    
    return result;
}

-(NSArray*) GetJoinedActivity :(NSString*)facebookID
{
    NSMutableArray * result = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"OrderList"];
    [query whereKey:@"userID" equalTo:facebookID];
    NSArray *objects = [query findObjects];
    NSLog(@"1");
    for (PFObject *object in objects) {
        NSString * activityID = object[@"Detail"][@"activityID"];
        NSLog(@" : >> 1.1");
        PFQuery * pfobject = [PFQuery queryWithClassName:@"CircleList"];
        NSLog(@" : >> 1.2");
        PFObject * detail = [pfobject getObjectWithId:activityID];
        NSLog(@" : >> 1.3");
        NSDictionary * temp = @{@"id":object.objectId,@"activityID":detail.objectId,@"name":detail[@"Detail"][@"name"],@"status":detail[@"Detail"][@"status"]};
        NSLog(@" : >> 1.4");
        [result addObject:temp];
        NSLog(@" : >> 1.5");
    }
    NSLog(@"2");
    return result;
}


-(int) CreateActivity:(NSString*)facebookID :(NSDictionary*)ActivityDetail
{
    
    
    PFObject *pfObject = [PFObject objectWithClassName:@"CircleList"];
    pfObject[@"userID"] = facebookID;
    pfObject[@"Detail"] = ActivityDetail;
    [pfObject save];
    NSLog(@"CreateActivity : %@",ActivityDetail);
    
    return DBsuccess;
}


-(int)JoinActivity:(NSString*)facebookID :(NSString*)ActivityID :(NSDictionary*)Detail;
{
    PFObject *pfObject = [PFObject objectWithClassName:@"OrderList"];
    pfObject[@"userID"] = facebookID;
    pfObject[@"ActivityID"] = ActivityID;
    pfObject[@"Detail"] = Detail;
    [pfObject save];
    NSLog(@"JoinActivity : %@",Detail);
    
    return DBsuccess;
}

-(NSArray*)GetBuyList:(NSString*)activityID
{
    NSArray *buylist = @[
     @{
         @"activityID":@"0",
         @"buyList":@[@(1),@(5)],
         @"phone":@"0933228300",
         @"facebookID":@"0",
         @"name":@"小熊",
         @"date":@"2013/10/22 10:00 am",
         @"location":@"臺大德田館",
         @"buyid":@"123",
         @"finished":@(NO),
      },
     
     @{
         @"activityID":@"0",
         @"buyList":@[@(1),@(0)],
         @"phone":@"0933228300",
         @"facebookID":@"1",
         @"name":@"包子",
         @"date":@"2013/10/22 10:00 am",
         @"location":@"臺大德田館",
         @"buyid":@"456",
         @"finished":@(YES),
         },
     
     @{
         @"activityID":@"0",
         @"buyList":@[@(1),@(1)],
         @"phone":@"0933228300",
         @"facebookID":@"2",
         @"name":@"昱儒",
         @"date":@"2013/10/24 12:00 am",
         @"location":@"公館捷運站",
         @"buyid":@"789",
         @"finished":@(NO),
         },
       ];
    
    return buylist;
}




-(NSDictionary*)GetActivityDetail:(NSString*)activityID
{

    [Parse setApplicationId:@"jigcccFU23yCJWb51bJ7Htt70ipoprGeouMUJNBb"
                  clientKey:@"hmbyJNUBVfjqAWwfwDDTCxfRAOACPqjFrOGaInZB"];
    PFQuery * pfobject = [PFQuery queryWithClassName:@"CircleList"];
    PFObject * temp = [pfobject getObjectWithId:activityID];
    NSMutableDictionary * result = temp[@"Detail"];
    [result setObject:activityID forKey:@"id"];
    return result;
}



@end
