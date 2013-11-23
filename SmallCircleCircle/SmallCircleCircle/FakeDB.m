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




-(NSArray*) GetCreatedActivity :(NSString*)facebookID
{
    return @[@{@"id":@"0",@"name":@"小熊團購1",@"status":@(ASRecruting)},
             @{@"id":@"1",@"name":@"小熊團購2",@"status":@(ASFailed)},
             @{@"id":@"2",@"name":@"小熊團購3",@"status":@(ASSuccess)}];
}

-(NSArray*) GetJoinedActivity :(NSString*)facebookID
{
    return @[@{@"id":@"3",@"name":@"包子團購1",@"status":@(ASRecruting)},
             @{@"id":@"4",@"name":@"包子團購2",@"status":@(ASFailed)},
             @{@"id":@"5",@"name":@"包子團購3",@"status":@(ASSuccess)}];
}


-(int) CreateActivity:(NSString*)facebookID :(NSDictionary*)ActivityDetail
{
    NSLog(@"CreateActivity : %@",ActivityDetail);
    
    return DBsuccess;
}


-(int)JoinActivity:(NSString*)facebookID :(NSString*)ActivityID :(NSDictionary*)Detail;
{
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
    return @{
             @"id":activityID,
             @"name":@"包子團購",
             @"description":@"露天拍賣上的Mac比較便宜，但是要運費，一次訂超過十台可以免運，有興趣的++噢！",
             @"url":@"http://tw.yahoo.com",
             @"location":@"台大面交",
             @"PS":@"限女生",
             @"expireDate":@"2013/12/12 13:00:00",
             @"constraint":
                 @{
                     @"type":@"總金額大於",
                     @"amount":@(100000)
                 },
             @"fee":
                 @{
                     @"feeAmount":@(3000),
                     @"feeStyle":@"依金額比重平分"
                 },
             @"items":
                 @[
                  @{@"name":@"MacBook Air 13吋",@"price":@(33000)},
                  @{@"name":@"iPhone 5s 土豪金",@"price":@(30000)},
                 ],
             @"tradeDates":
                 @[
                     @{@"date":@"2013/12/14 13:00:00",@"location":@"臺大小福"},
                     @{@"date":@"2013/12/17 13:00:00",@"location":@"德田館Lab430"},
                  ],
             @"phone":@"0912345678"
             };
}

-(NSDictionary*)GetMyBuyListInActivity:(NSString*)facebookID:(NSString*)activityID
{
    return
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
      };
}



@end
