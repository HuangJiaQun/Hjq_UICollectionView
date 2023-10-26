//
//  ShopModel.h
//  Hjq_UICollectionView
//
//  Created by 黄嘉群 on 2020/12/12.
//  Copyright © 2020 黄嘉群. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject

/** 宽度  */
@property (nonatomic,assign) CGFloat w;

/** 高度  */
@property (nonatomic,assign) CGFloat h;
/** 图片  */
@property (nonatomic, strong) NSString *img;
/** 价格  */
@property (nonatomic, strong) NSString *price;

@end

NS_ASSUME_NONNULL_END
