//
//  Note.h
//  NoteBook
//
//  Created by 畅通 on 14-10-14.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property(nonatomic,assign)long long id;
@property (nonatomic ,copy) NSString * profileImageUrl;//头像

@property (nonatomic ,copy) NSString * userName;//发送用户

@property (nonatomic ,copy) NSString * mbtype;//会员类型

@property (nonatomic ,copy) NSString * createAt;//创建日期

@property (nonatomic ,copy) NSString * source;//设备来源

@property (nonatomic ,copy) NSString * text;//微博内容

#pragma mark - 方法
#pragma mark 根据字典初始化微博对象
- (Note * )initWithDictionary:(NSDictionary *)dic;

#pragma mark 初始化微博对象（静态方法）
+ (Note *)statusWithDictionary:(NSDictionary *)dic;


@end
