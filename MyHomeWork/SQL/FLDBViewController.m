//
//  FLDBViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/28.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLDBViewController.h"
#import "FLCarModel.h"
#import "FLPersonModel.h"
#import "FLPersonRealmModel.h"
#import "NSObject+RLMHelper.h"
#import <Realm/Realm.h>
#import <objc/runtime.h>

static NSString * const kDBActionInsert = @"插入";
static NSString * const kDBActionSelect = @"查询";
static NSString * const kDBActionUpdate = @"更新";
static NSString * const kDBActionDelete = @"删除";

static NSString * const kDBTableViewCellID = @"kDBTableViewCellID";

@interface FLDBViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) FLPersonModel *person;
@property (nonatomic, strong) FLCarModel *car;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *listTableView;

@end

@implementation FLDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.listTableView];
    
//    NSLog(@"%@",[CCDDataBaseHelper getInstance].dbPath);
    self.dataSource = @[kDBActionInsert,kDBActionSelect,kDBActionUpdate,kDBActionDelete];
    
    FLPersonModel *person = [FLPersonModel new];
    FLCarModel *bmw = [FLCarModel new];
    bmw.name = @"BMW-X3";
    bmw.price = 300000.00;
    
    
    FLCarModel *audi = [FLCarModel new];
    audi.name = @"Audi-A4L";
    audi.price = 400000.00;
    
    person.vehicles = @[bmw, audi];
    person.car = bmw;
    person.userID = 1001;
    person.name = @"Fengli";
    person.age = 20;
    person.salary = 1000000.001;
    person.man = YES;
    person.goal = @(1.11);
    person.birthday = [NSDate date];
    FLPersonRealmModel *personModel = [person ccd_realmModelByClass:[FLPersonRealmModel class]];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:personModel];
    }];
    NSLog(@"%@",[realm configuration].fileURL);
    NSLog(@"FAFAAA");
    RLMResults *persons = [FLPersonRealmModel allObjects];
    for (FLPersonRealmModel *pp in persons) {
        NSLog(@"personInfo=%@",pp);
        NSLog(@"person.car=%@",pp.car);
        for (FLCarRealmModel *cc in pp.vehicles) {
             NSLog(@"person.vehicles.car=%@",cc);
        }
    }
    
    
    
//    FLRLMCar *car = [[FLRLMCar alloc] init];
//    car.carId = @"1";
//    car.carName = @"BMW";
//
//
//    FLRLMPerson *person = [[FLRLMPerson alloc] init];
//    person.userId = @"1";
//    person.userName = @"Fengli";
//    person.age = 20;
//    person.salary = 1000000.001;
//    person.man = YES;
//    [person.cars addObject:car];
//
//
//    FLRLMPerson *person2 = [[FLRLMPerson alloc] init];
//    person2.userId = @"2";
//    person2.userName = @"Fl";
//    person2.age = 22;
//    person2.salary = 2000000.001;
//    person2.man = NO;
//    [person2.cars addObject:car];
//
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm addObjects:@[person, person2]];
//    }];
//    RLMResults *results = [FLRLMPerson allObjects];
//    for (FLRLMPerson *p in results) {
//        NSLog(@"%@,%@,%ld",p.userId, p.userName,p.age);
//    }
//
//    NSLog(@"succee");
    
    
//
//    [FLPerson ccd_fmdbUpdateTable];
//
//    self.person =  [[FLPerson alloc] init];
//    self.person .userID = 1;
//    self.person.sex = @"male";
//    self.person .name = @"Fl";
//    self.person .age = 20;
//    self.person .salary = 100000.01;
//    self.person .birthday = [NSDate dateWithTimeIntervalSince1970:1559031655];
//
//
//    self.car = [FLCar new];
//    self.car.name = @"BMW";
//    self.car.price = 20000.0;
//
//    NSLog(@"person info: %@",self.person);

}

- (void)createRealmDB {
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"flrealm"];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:dbPath];
    config.schemaVersion = 1.0;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 1.0) {
            
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    
}

- (void)insert {
//    FLPerson *p2 =  [[FLPerson alloc] init];
//    p2.userID = 2;
//    p2.name = @"Fengli";
//    p2.age = 21;
//    p2.salary = 200000.01;
//    p2.birthday = [NSDate dateWithTimeIntervalSince1970:1559033895];
    
//    [FLPerson ccd_fmdbSaveObjects:@[self.person]];
    [self selectAllEntry];
}

- (void)select {
//    NSArray *persons = [FLPerson ccd_fmdbSelectWithCondition:@" where age >= 20"];
//    for (FLPerson *person in persons) {
//        NSLog(@"person info: %@",person);
//    }
}

- (void)update {
    self.person.age = 30;
//    [FLPerson ccd_fmdbUpdateObjects:@[self.person]];
    [self selectAllEntry];
}

- (void)delete {
//    [FLPerson ccd_fmdbDeleteObjects:@[self.person]];
//    [self.person ccd_fmdbDeleteFromTable];
    [self selectAllEntry];
}

- (void)selectAllEntry {
//    NSArray *array = [FLPerson ccd_fmdbSelectAll];
//    for (FLPerson *person in array) {
//        NSLog(@"selectAllEntry result: %@", person);
//    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDBTableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDBTableViewCellID];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = self.dataSource[indexPath.row];
    if ([title isEqualToString:kDBActionInsert]) {
        [self insert];
    } else if ([title isEqualToString:kDBActionSelect]) {
        [self select];
    } else if ([title isEqualToString:kDBActionUpdate]) {
        [self update];
    } else if ([title isEqualToString:kDBActionDelete]) {
        [self delete];
    }
}

- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        _listTableView.rowHeight = 44;
        [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDBTableViewCellID];
        _listTableView.tableFooterView = [UIView new];
    }
    return _listTableView;
}

@end
