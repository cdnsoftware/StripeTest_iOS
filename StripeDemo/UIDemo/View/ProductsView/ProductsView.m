//
//  ProductsView.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "ProductsView.h"
#import "ProductCollectionViewCell.h"

@interface ProductsView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *arrProductList;

@end

@implementation ProductsView

-(void)doSetData:(NSArray *)arrData
{
    self.arrProductList = arrData;
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arrProductList count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dict = [self.arrProductList objectAtIndex:indexPath.row];
    [cell doSetCollectionViewCell:dict];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate doSelectProduct:[self.arrProductList objectAtIndex:indexPath.row]];
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width / 2 - 15, self.collectionView.frame.size.width / 2 - 15);
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10,10,10,10);  // top, left, bottom, right
}

@end
