//
//  FakeDB.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "FakeDB.h"
#import <Parse/Parse.h>
#import "huwAppDelegate.h"


@implementation FakeDB

static FakeDB *instance = nil;
static NSCache *cache;

const float FAKE_DELAY = 1000;

+(FakeDB*)GetDBInstance
{
    NSLog(@"1");
    
    if(instance == nil)
    {
        
        [Parse setApplicationId:@"jigcccFU23yCJWb51bJ7Htt70ipoprGeouMUJNBb"
                      clientKey:@"hmbyJNUBVfjqAWwfwDDTCxfRAOACPqjFrOGaInZB"];
        instance = [[FakeDB alloc]init];
        cache = [[NSCache alloc] init];
        
    }
    return instance;
}


-(NSCache *)sharedCache {
    static NSCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}



-(NSArray*) GetCreatedActivity :(NSString*)facebookID
{
    NSLog(@"2");
    
    //為了讓parse可以跑，因為一開始要load頁面，但是appdelegate還沒準備好
   /* [Parse setApplicationId:@"jigcccFU23yCJWb51bJ7Htt70ipoprGeouMUJNBb"
     clientKey:@"hmbyJNUBVfjqAWwfwDDTCxfRAOACPqjFrOGaInZB"]; */
    NSMutableArray * result = [[NSMutableArray alloc] init];
    
    NSLog(@"2.1");

    //開始從parse 搜尋資料 找資料庫（class）為CircleList
    PFQuery *query = [PFQuery queryWithClassName:@"CircleList"];
    
    NSLog(@"2.2");

    // userID = facebookID 用FacebookID找出使用者的團購list
    [query whereKey:@"userID" equalTo:facebookID];
    
    NSLog(@"2.3");

    NSArray *objects = [query findObjects];
    NSLog(@"2.4");

    for (PFObject *object in objects) {
        NSDictionary *detail = object[@"Detail"];
        NSDictionary * temp = @{@"id":object.objectId,@"name":detail[@"name"],@"status":detail[@"status"]};
        [result addObject:temp];
        NSString *cacheKey = [NSString stringWithFormat:@"SSCDetail-%@", object.objectId];
        [cache setObject:detail forKey:cacheKey];
    }
    NSLog(@"2.5");

    
    return result;
    
}

-(NSArray*) GetJoinedActivity :(NSString*)facebookID
{
    NSLog(@"3");
    NSMutableArray * result = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"OrderList"];
    [query whereKey:@"userID" equalTo:facebookID];
    NSArray *objects = [query findObjects];
    for (PFObject *object in objects) {
        NSString * activityID = object[@"Detail"][@"activityID"];
        PFQuery * pfobject = [PFQuery queryWithClassName:@"CircleList"];
        PFObject * detail = [pfobject getObjectWithId:activityID];
        NSDictionary * temp = @{@"orderid":object.objectId,@"id":detail.objectId,@"activityID":detail.objectId,@"name":detail[@"Detail"][@"name"],@"status":detail[@"Detail"][@"status"]};
        [result addObject:temp];
    }
    return result;
    
}


-(int) CreateActivity:(NSString*)facebookID :(NSDictionary*)ActivityDetail
{
    
    
    
    
    NSLog(@"4");
    PFObject *pfObject = [PFObject objectWithClassName:@"CircleList"];
    pfObject[@"userID"] = facebookID;
    NSMutableDictionary * detail = ActivityDetail;
    [detail setObject:@(ASRecruting) forKey:@"status"];
    pfObject[@"Detail"] = ActivityDetail;
    [pfObject save];

    NSLog(@"CreateActivity : %@",ActivityDetail);
    NSLog(@"hello? %@",facebookID);
    return DBsuccess;
}


-(int)JoinActivity:(NSString*)facebookID :(NSString*)ActivityID :(NSDictionary*)Detail;
{
    
    NSLog(@"5");
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
    
    NSLog(@"6.1");
    NSString *cacheKey = [NSString stringWithFormat:@"GetBuyList-%@", activityID];
    NSArray *result =  [[self sharedCache] objectForKey:cacheKey];
    if(!result){
        NSLog(@"6.2");
        PFQuery * query = [PFQuery queryWithClassName:@"OrderList"];
        [query whereKey:@"ActivityID" equalTo:activityID];
        NSMutableArray * buyArray = [[NSMutableArray alloc] init];
        [buyArray addObjectsFromArray:[query findObjects]];
        NSMutableArray * buylist = [[NSMutableArray alloc] init];
        for(PFObject *list in buyArray)
        {
            [buylist addObject:@{@"activityID":list[@"ActivityID"],@"buyList":list[@"Detail"][@"buyList"],@"phone":list[@"Detail"][@"phone"],@"facebook":list[@"userID"],@"name":list[@"Detail"][@"userName"],@"date":list[@"Detail"][@"date"],@"location":list[@"Detail"][@"location"],@"buyid":list.objectId,@"finished":@"NO"}];
        }
        result = buylist ;
        [[self sharedCache] setObject:result forKey:cacheKey];
    }
    return result;
}




-(NSDictionary*)GetActivityDetail:(NSString*)activityID
{
    NSLog(@"7");
    NSLog([NSString stringWithFormat:@"GetActivityDetail-%@", activityID]);
    NSString *cacheKey = [NSString stringWithFormat:@"GetActivityDetail-%@", activityID];
    NSMutableDictionary * result =  [[self sharedCache] objectForKey:cacheKey];
    if(!result){
        result = [[NSMutableDictionary alloc] init];
        PFQuery * pfobject = [PFQuery queryWithClassName:@"CircleList"];
        PFObject * temp = [pfobject getObjectWithId:activityID];
        result = temp[@"Detail"];
        [result setObject:activityID forKey:@"id"];

        [[self sharedCache] setObject:result forKey:cacheKey];
    }
    return result;
    
    
}

-(NSDictionary*) GetTargetOrderList : (NSString*) orderID
{
    NSLog(@"8");
    NSString *cacheKey = [NSString stringWithFormat:@"GetMyBuyListInActivity-%@", orderID];
    NSMutableDictionary * result =  [[self sharedCache] objectForKey:cacheKey];
    if(!result){
        PFQuery * query = [PFQuery queryWithClassName:@"OrderList"];
        //  [query whereKey:@"userID" equalTo:facebookID];
        PFObject *  queryObject = [query getObjectWithId:orderID];
        result = [[NSMutableDictionary alloc] init];
        result =    [ @{
                        @"activityID":queryObject[@"ActivityID"],
                        @"buyList":queryObject[@"Detail"][@"buyList"],
                        @"phone":queryObject[@"Detail"][@"phone"],
                        @"facebookID":queryObject[@"userID"],
                        @"name":queryObject[@"Detail"][@"userName"],
                        @"date":queryObject[@"Detail"][@"date"],
                        @"location":queryObject[@"Detail"][@"location"],
                        @"buyid":queryObject.objectId,
                        @"finished":@(NO),
                        } mutableCopy];
        [[self sharedCache] setObject:result forKey:cacheKey];
    }
    return result ;
}

/*

-(NSDictionary*)GetMyBuyListInActivity:(NSString*)facebookID :(NSString*)activityID
{
    NSLog(@"8");
    NSString *cacheKey = [NSString stringWithFormat:@"GetMyBuyListInActivity-%@", activityID];
    NSMutableDictionary * result =  [[self sharedCache] objectForKey:cacheKey];
    if(!result){
        PFQuery * query = [PFQuery queryWithClassName:@"OrderList"];
      //  [query whereKey:@"userID" equalTo:facebookID];
        PFObject *  queryObject = [query getObjectWithId:activityID];
        result = [[NSMutableDictionary alloc] init];
        result =    [ @{
                                      @"activityID":queryObject[@"ActivityID"],
                                      @"buyList":queryObject[@"Detail"][@"buyList"],
                                      @"phone":queryObject[@"Detail"][@"phone"],
                                      @"facebookID":queryObject[@"userID"],
                                      @"name":@"小熊",
                                      @"date":queryObject[@"Detail"][@"date"],
                                      @"location":queryObject[@"Detail"][@"location"],
                                      @"buyid":queryObject.objectId,
                                      @"finished":@(NO),
                                      } mutableCopy];
         [[self sharedCache] setObject:result forKey:cacheKey];
    }
    return result ;

}
 */



@end
