//
//  FLCollectionViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/29.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCollectionViewController.h"
#import "FLCollectionViewLinearLayout.h"
#import "FLCollectionViewCell.h"
#import "FLCollectionViewWaterFallLayout.h"

@interface FLCollectionViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FLCollectionViewLinearLayout *linearLayout;
@property (nonatomic, strong) FLCollectionViewWaterFallLayout *waterFallLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FLCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    
    for (int i = 0; i < 100 ; ++i) {
        [self.dataArray addObject:[NSString stringWithFormat:@"cell%d",i]];
    }
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell updateWithText:self.dataArray[indexPath.item] bgColor:indexPath.item & 1 ? [UIColor redColor]  : [UIColor greenColor]];
    return cell;
}

- (CGFloat)waterFallLayout:(FLCollectionViewWaterFallLayout *)waterLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
                 itemWidth:(CGFloat)itemWidth {
    if (indexPath.item & 1) {
        return 200;
    }
    return 300;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.waterFallLayout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FLCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
        
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 20;
        _flowLayout.itemSize = CGSizeMake(100, 300);
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return _flowLayout;
}

- (FLCollectionViewLinearLayout *)linearLayout {
    if (!_linearLayout) {
        _linearLayout = [[FLCollectionViewLinearLayout alloc] init];
//        _flowLayout.minimumLineSpacing = 50;
        _linearLayout.minimumInteritemSpacing = MAXFLOAT;
        _linearLayout.itemSize = CGSizeMake(200, 300);
    }
    return _linearLayout;
}

- (FLCollectionViewWaterFallLayout *)waterFallLayout {
    if (!_waterFallLayout) {
        _waterFallLayout = [[FLCollectionViewWaterFallLayout alloc]
                            init];
        _waterFallLayout.delegate = self;
        
    }
    return _waterFallLayout;
}
@end
