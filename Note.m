//
//  Note.m
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "Note.h"

@implementation Note

-(Note *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        self.Id = [dic[@"Id"] longLongValue];
        self.profileImageUrl = dic[@"profileImageUrl"];
        self.userName = dic[@"userName"];
        self.mbtype = dic[@"mbtype"];
        self.createAt = dic[@"createAt"];
        self.source = dic[@"source"];
        self.text = dic[@"text"];

    }
    
    return  self;
}
+(Note *)statusWithDictionary:(NSDictionary *)dic{

    Note *myNote=[[Note alloc] initWithDictionary:dic];
    return  myNote;
}
@end
