//
//  FLFMDBHelper.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/2/21.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLFMDBHelper.h"
#import <FMDB.h>
#import <sqlite3.h>

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

@interface FLFMDBHelper ()

@property (nonatomic, strong) FMDatabaseQueue *queue;


@end


@implementation FLFMDBHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSLog(@"----DBPath----%@",docPath);
        NSString *filepath = [docPath stringByAppendingPathComponent:@"test.db"];
        _queue = [FMDatabaseQueue databaseQueueWithPath:filepath];
    }
    return self;
}


+(NSInteger)createDB{
//    NSString *path = @"/tmp/test.db";s
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"----DBPath----%@",docPath);
    NSString *filepath = [docPath stringByAppendingPathComponent:@"test.db"];
   
    [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    FMDatabase *db = [FMDatabase databaseWithPath:filepath];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return 0;
    }
    
    if ([db hadError]) {
        NSLog(@"Err, %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    FMResultSet *rs = nil;
    
//    [db executeUpdate:@"create table t2 (a integer, b integer)"];
//    if (![db executeUpdate:@"insert into t2 values (?, ?)", nil, [NSNumber numberWithInt:5]]) {
//        NSLog(@"UH OH, can't insert a nil value for some reason...");
//    }
//
//    rs = [db executeQuery:@"select * from t2"];
//    while ([rs next]) {
//        NSString *aa = [rs stringForColumnIndex:0];
//        NSString *bb = [rs stringForColumnIndex:1];
//        if (aa != nil) {
//            NSLog(@"%s:%d", __FUNCTION__, __LINE__);
//            NSLog(@"OH OH, PROBLEMO!");
//            return 10;
//        }
//        else {
//            NSLog(@"YAY, NULL VALUES");
//        }
//
//        if (![bb isEqualToString:@"5"]) {
//            NSLog(@"%s:%d", __FUNCTION__, __LINE__);
//            NSLog(@"OH OH, PROBLEMO!");
//            return 10;
//        }
//    }
    
    
    [db executeUpdate:@"create table t3 (a somevalue)"];
    [db beginTransaction];
    int i = 0;
    while (i++ < 20) {
        [db executeUpdate:@"insert into t3(a) values(?)", @(i)];
        
    }
    [db commit];
    
    [db executeUpdate:@"create table nulltest(a text, b text)"];
    [db executeUpdate:@"insert into nulltest (a,b) values(?,?)", @"hello:\"this is fenngli's book\"", @"b"];
    rs = [db executeQuery:@"select * from nulltest"];
    
    while ([rs next]) {
        NSString *a = [rs stringForColumnIndex:0];
      
        NSLog(@"%@",a);
    }
//    while ([rs next]) {
//        int foo = [rs intForColumnIndex:0];
//        int newVal = foo + 100;
//        [db executeUpdate:@"update t3 set a = ? where a = ?", @(newVal), @(foo)];
//        FMResultSet *rs2 = [db executeQuery:@"select a from t3 where a = ?", @(newVal)];
//        [rs2 next];
//        if ([rs2 intForColumnIndex:0] != newVal) {
//            NSLog(@"Oh crap, our update didn't work out!");
//            return 9;
//        }
//        [rs2 close];
//    }
    
    
    
//    [db executeUpdate:@"create table cs (aRowName integer, bRowName text)"];
//    [db executeUpdate:@"insert into cs values(?,?)",[NSNumber numberWithBool:1], @"hello"];
//    FMResultSet *rs = [db executeQuery:@"select * from cs"];
//    while ([rs next]) {
//        NSDictionary *d = [rs resultDictionary];
//        FMDBQuickCheck([d objectForKey:@"aRowName"]);
////        FMDBQuickCheck([d objectForKey:@"arowname"]);
//        FMDBQuickCheck([d objectForKey:@"bRowName"]);
////        FMDBQuickCheck([d objectForKey:@"browname"]);
//    }

    
    return 0;
}

- (void)versionControlWithNewVersion:(NSString *)version {
    NSArray *existTables = [self existsTables];
    NSMutableArray *tmpexistTables = [NSMutableArray array];
    for (NSString *tableName in existTables) {
        [tmpexistTables addObject:[NSString stringWithFormat:@"%@_bak",tableName]];
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME TO %@_bak",tableName, tableName];
            [db executeUpdate:sql];
        }];
    }
    existTables = tmpexistTables;
    
    NSArray *newAddedTables = [self addedTables];
    //对比新表旧表，取出需要迁移的字段
    NSDictionary *migrationInfos = [self generateMigrationInfosWithOldTables:existTables newTables:newAddedTables];
    [migrationInfos enumerateKeysAndObjectsUsingBlock:^(NSString* newTableName, NSArray* publicColumns, BOOL * _Nonnull stop) {
        NSMutableString *colunmsString = [NSMutableString new];
        for (int i = 0; i < publicColumns.count; ++i) {
            [colunmsString appendString:publicColumns[i]];
            if (i != publicColumns.count-1) {
                [colunmsString appendString:@", "];
            }
        }
            NSMutableString* sql = [NSMutableString new];
            [sql appendString:@"INSERT INTO "];
            [sql appendString:newTableName];
            [sql appendString:@"("];
            [sql appendString:colunmsString];
            [sql appendString:@")"];
            [sql appendString:@" SELECT "];
            [sql appendString:colunmsString];
            [sql appendString:@" FROM "];
            [sql appendFormat:@"%@_bak", newTableName];
            
            [self.queue inDatabase:^(FMDatabase *db) {
                [db executeUpdate:sql];
            }];
    }];
    
    //删除备份表
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        [db beginTransaction];
        for (NSString *name in existTables) {
            NSString *sql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", name];
            [db executeUpdate:sql];
        }
        [db commit];
    }];
    
}

// 遍历旧的表和新表，对比取出需要迁移的表的字段
- (NSDictionary*)generateMigrationInfosWithOldTables:(NSArray*)oldTables newTables:(NSArray*)newTables {
    NSMutableDictionary<NSString*, NSArray* >* migrationInfos = [NSMutableDictionary dictionary];
    for (NSString* newTableName in newTables) {
        NSString* oldTableName = [NSString stringWithFormat:@"%@_bak", newTableName];
        if ([oldTables containsObject:oldTableName]) {
            // 获取表数据库字段信息
            NSArray* oldTableColumns = [self columsWithTableName:oldTableName];
            NSArray* newTableColumns = [self columsWithTableName:newTableName];
            NSArray* publicColumns = [self publicColumnsWithOldTableColumns:oldTableColumns newTableColumns:newTableColumns];
            
            if (publicColumns.count > 0) {
                [migrationInfos setObject:publicColumns forKey:newTableName];
            }
        }
    }
    return migrationInfos;
}

//新表和旧表共有的字段
- (NSArray *)publicColumnsWithOldTableColumns:(NSArray *)oldColumns newTableColumns:(NSArray *)newColumns {
    NSMutableArray* publicColumns = [NSMutableArray array];
    for (NSString* oldTableColumn in oldColumns) {
        if ([newColumns containsObject:oldTableColumn]) {
            [publicColumns addObject:oldTableColumn];
        }
    }
    return publicColumns;
}

//获取新创建的表
- (NSArray *)addedTables {
    __block NSMutableArray<NSString*>* tables = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = @"SELECT * FROM sqlite_master where type='table' AND name not like '%_bak'";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"name"];
            [tables addObject:name];
        }
    }];
    return tables;
}

//获取数据库中的现有的表
- (NSArray *)existsTables {
    __block NSMutableArray<NSString*>* existsTables = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = @"SELECT * FROM sqlite_master where type='table'";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"name"];
            [existsTables addObject:name];
        }
    }];
    return existsTables;
}


//获取表中的所有列
- (NSArray *)columsWithTableName:(NSString *)name {
    __block NSMutableArray *columns = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = [NSString stringWithFormat:@"PRAGMA table_info('%@')", name];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"name"];
            [columns addObject:name];
        }
    }];
    return columns;
}

@end
