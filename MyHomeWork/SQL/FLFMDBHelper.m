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
    
//    FMDBQuickCheck([db hadError]);
    
    if ([db hadError]) {
        NSLog(@"Err, %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
//    [db executeUpdate:@"create table test(a text, b text, c integer, d double, e double)"];
//    [db dbeginTransaction];
//    int i = 0;
//    while (i++ < 20) {
//        [db executeUpdate:@"insert into test(a,b,c,d,e) values (?,?,?,?,?)",
//         @"hi this a",
//         [NSString stringWithFormat:@"%d",i],
//         @(i),
//         [NSDate date],
//         [NSNumber numberWithFloat:2.2f]];
//    }
//    [db commit];
    
//    FMResultSet *ret = [db executeQuery:@"select * from test "];
//    while ([ret next]) {
//        NSLog(@"current c is: %d", [ret intForColumn:@"c"]);
//
//    }
/*
    // empty strings should still return a value.
    FMDBQuickCheck(([db boolForQuery:@"SELECT ? not null", @""]));
    
    // same with empty bits o' mutable data
    FMDBQuickCheck(([db boolForQuery:@"SELECT ? not null", [NSMutableData data]]));
    
    // same with empty bits o' data
    FMDBQuickCheck(([db boolForQuery:@"SELECT ? not null", [NSData data]]));

    [db beginTransaction];
    int i= 0;
    while (i++ < 20) {
        [db executeUpdate:@"insert into test values (?,?,?,?,?)",@"hi'world",[NSString stringWithFormat:@"number %d",i],
         [NSNumber numberWithInt:i],
         [NSDate date],
         [NSNumber numberWithFloat:30.0]];
    }

    [db commit];

    [db executeUpdate:@"create table cs (aRowName integer, bRowName text)"];
    FMDBQuickCheck(![db hadError]);
    [db executeUpdate:@"insert into cs values(?, ?)", @1,@"hello"];
    
    FMResultSet *rs = [db executeQuery:@"select * from cs"];
    while ([rs next]) {
        NSDictionary *d = [rs resultDictionary];
        //列名大小写敏感
        FMDBQuickCheck([d objectForKey:@"aRowName"]);
        FMDBQuickCheck([d objectForKey:@"arowname"]);
        FMDBQuickCheck([d objectForKey:@"bRowName"]);
        FMDBQuickCheck(![d objectForKey:@"browname"]);
    }

    [db executeUpdate:@"create table blobTable (a text, b blob)"];
    NSData *data = [NSData dataWithContentsOfFile:@"/Applications/Safari.app/Contents/Resources/compass.icns"];
    if (data) {
        [db executeUpdate:@"insert into blobTable(a, b) values (?,?)",@"safari's compass", data];
        FMResultSet *rs = [db executeQuery:@"select b from blobTable where a = ?", @"safari's compass"];
        if ([rs next]) {
            data = [rs dataForColumn:@"b"];
            [data writeToFile:@"/tmp/compass.icns" atomically:NO];
//            system("/usr/bin/open /tmp/compass.icns");
            NSLog(@"succed");
        } else {
             NSLog(@"Could not select image.");
        }
        [rs close];
    }

    [db executeUpdate:@"create table nulltest (a text, b text)"];
    [db executeUpdate:@"insert into nulltest values(?,?)", [NSNull null], @"a"];
    [db executeUpdate:@"insert into nulltest values(?,?)", nil, @"b"];
    FMResultSet *rs = [db executeQuery:@"select * from nulltest"];
    while ([rs next]) {
        NSString *a = [rs stringForColumnIndex:0];
        NSString *b = [rs stringForColumnIndex:1];
        
        if (!b) {
            NSLog(@"Oh crap, the nil / null inserts didn't work!");
            return 10;
        }
        if (a) {
            NSLog(@"Oh crap, the nil / null inserts didn't work (son of error message)!");
            return 11;
        }
        else {
            NSLog(@"HURRAH FOR NSNULL (and nil)!");
        }
    }

    FMDBQuickCheck([db columnExists:@"a" inTableWithName:@"nulltest"]);
    FMDBQuickCheck([db columnExists:@"b" inTableWithName:@"nulltest"]);
    FMDBQuickCheck(![db columnExists:@"c" inTableWithName:@"nulltest"]);
*/
    [db executeUpdate:@"create table nulltest2 (s text, d data, i integer, f double, b integer)"];
    
    // grab the data for this again, since we overwrote it with some memory that has since disapeared.
    NSData *safariCompass = [NSData dataWithContentsOfFile:@"/Applications/Safari.app/Contents/Resources/compass.icns"];
    
    [db executeUpdate:@"insert into nulltest2 (s, d, i, f, b) values (?, ?, ?, ?, ?)" , @"Hi", safariCompass, [NSNumber numberWithInt:12], [NSNumber numberWithFloat:4.4f], [NSNumber numberWithBool:YES]];
//    [db executeUpdate:@"insert into nulltest2 (s, d, i, f, b) values (?, ?, ?, ?, ?)" , nil, nil, nil, nil, [NSNull null]];
    
    FMResultSet *rs = [db executeQuery:@"select * from nulltest2"];
    
    while ([rs next]){
        int i = [rs intForColumnIndex:2];
//        if (i == 12)
        {
            FMDBQuickCheck(![rs columnIndexIsNull:0]);
            FMDBQuickCheck(![rs columnIndexIsNull:1]);
            FMDBQuickCheck(![rs columnIndexIsNull:2]);
            FMDBQuickCheck(![rs columnIndexIsNull:3]);
            FMDBQuickCheck(![rs columnIndexIsNull:4]);
            FMDBQuickCheck( [rs columnIndexIsNull:5]);
        
        }
        
        
        
    }
    
    
    
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
