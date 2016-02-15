//
//  ProductCollectionViewCell.h
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) IBOutlet UIImageView *imgProduct;

-(void)doSetCollectionViewCell:(NSDictionary *)dictData;

@end
