//
//  ProductsView.h
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectProductDelegate <NSObject>

@optional

-(void)doSelectProduct:(NSDictionary *)dictProduct;

@end

@interface ProductsView : UIView

@property (nonatomic,weak) id <SelectProductDelegate> delegate;

-(void)doSetData:(NSArray *)arrData;


@end
