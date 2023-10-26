//
//  ShopLayout.h
//  Hjq_UICollectionView
//
//  Created by 黄嘉群 on 2020/12/12.
//  Copyright © 2020 黄嘉群. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopLayout;
@protocol ShopLayoutDeleaget <NSObject>

@required
/*
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(ShopLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(ShopLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(ShopLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(ShopLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(ShopLayout *)waterFallLayout;

@end



@interface ShopLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<ShopLayoutDeleaget> delegate;
@end

NS_ASSUME_NONNULL_END
