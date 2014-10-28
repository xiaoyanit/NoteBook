//
//  NoteManagedObject.h
//  NoteBook
//
//  Created by 畅通 on 14/10/26.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * profileImageUrl;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * createAt;
@property (nonatomic, retain) NSString * mbtype;
@property (nonatomic, retain) NSString * userName;

@end
