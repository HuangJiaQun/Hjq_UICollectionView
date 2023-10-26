//
//  ShopCell.m
//  Hjq_UICollectionView
//
//  Created by 黄嘉群 on 2020/12/12.
//  Copyright © 2020 黄嘉群. All rights reserved.
//

#import "ShopCell.h"
#import "UIImageView+WebCache.h"
@implementation ShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 * 重写商品的setter方法
 */
- (void)setShop:(ShopModel *)shop{
    
    _shop = shop;
    
    // 图片
    //[self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    self.backgroundColor = UIColor.blueColor;
    self.imageView.image = [UIImage imageNamed:@"0.jpg"];
    // 价格
    self.priceLabel.text = shop.price;
    
}
@end
