//
//  ViewController.m
//  Hjq_UICollectionView
//
//  Created by 黄嘉群 on 2020/12/12.
//  Copyright © 2020 黄嘉群. All rights reserved.
//

#import "ViewController.h"
#import "ShopModel.h"
#import "ShopCell.h"
#import "ShopLayout.h"
#import <MJRefresh.h>
#import <MJExtension.h>

static NSString * const ShopCellId = @"shop";
//随机色
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface ViewController ()<UICollectionViewDataSource,ShopLayoutDeleaget>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray  * shopData;
@property (nonatomic, strong) UICollectionView * collectionView;
/** 列数 */
@property (nonatomic, assign) NSUInteger columnCount;

@end

@implementation ViewController
#pragma mark - 懒加载
- (NSMutableArray *)shopData{
    if (!_shopData) {
        _shopData = [NSMutableArray array];
    }
    return _shopData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];//初始化
    // Do any additional setup after loading the view.
    [self setupLayoutAndCollectionView];//b瀑布流
    [self setupRefresh];//刷新
}

/**
 * 初始化
 */
- (void)initialize{
    
    self.title = @"瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];
    
}
/**
 * 创建布局和collectionView
 */
- (void)setupLayoutAndCollectionView{
    ShopLayout *layout=[[ShopLayout alloc]init];
    layout.delegate=self;
    
    
    // 创建布局
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.dataSource=self;
    [self.view addSubview:self.collectionView];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ShopCellId];
    self.collectionView.backgroundColor=[UIColor grayColor];
    // 注册
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCell class]) bundle:nil] forCellWithReuseIdentifier:ShopCellId];
}

/**
 * 刷新控件
 */
- (void)setupRefresh{
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    self.collectionView.mj_header.backgroundColor = [UIColor yellowColor];
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_header.hidden = YES;
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.mj_footer.backgroundColor = [UIColor yellowColor];
   // self.collectionView.mj_footer.hidden = YES;
}

/**
 * 加载新的商品
 */
- (void)loadNewShops{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //转化模型
        NSArray * shops = [ShopModel mj_objectArrayWithFilename:@"shop.plist"];
        
        [self.shopData removeAllObjects];
        
        [self.shopData addObjectsFromArray:shops];
        // 刷新表格
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });
    
}


/**
 * 加载更多商品
 */
- (void)loadMoreShops{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //转化模型
        NSArray * shops = [ShopModel mj_objectArrayWithFilename:@"shop.plist"];
        [self.shopData addObjectsFromArray:shops];
        // 刷新表格
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });
    
}


///**
// * 分段控件的点击事件
// */
//- (void)segmentClick: (UISegmentedControl *)segment{
//
//    NSInteger index = segment.selectedSegmentIndex;
//
//    switch (index) {
//        case 0:
//            self.columnCount = 2;
//            break;
//        case 1:
//            self.columnCount = 3;
//            break;
//        default:
//            break;
//    }
//}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shopData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopCellId forIndexPath:indexPath];
    
    ShopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopCellId forIndexPath:indexPath];
    
    cell.shop = self.shopData[indexPath.item];
    cell.backgroundColor = randomColor;
    return cell;
}

#pragma mark  - <ShopLayoutDeleaget>

/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(ShopLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    ShopModel * shop = self.shopData[indexPath];
    
    return itemWidth * shop.h / shop.w;
}
/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(ShopLayout *)waterFallLayout{
    return 20;
    
}
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(ShopLayout *)waterFallLayout{
    return 2;
}



@end
