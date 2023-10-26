//
//  ShopCell.h
//  Hjq_UICollectionView
//
//  Created by 黄嘉群 on 2020/12/12.
//  Copyright © 2020 黄嘉群. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopCell : UICollectionViewCell
/** 商品模型 */
@property (nonatomic, strong) ShopModel * shop;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

NS_ASSUME_NONNULL_END
