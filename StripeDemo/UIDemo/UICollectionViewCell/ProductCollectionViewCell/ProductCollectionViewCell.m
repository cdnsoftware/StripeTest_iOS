//
//  ProductCollectionViewCell.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell

-(void)doSetCollectionViewCell:(NSDictionary *)dictData
{
    [self.imgProduct setImage:[UIImage imageNamed:[dictData objectForKey:@"imgProduct"]]];
}
@end
