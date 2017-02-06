//
//  SubCategoriesViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 01/12/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "SubCategoriesViewController.h"
#import "CategoryCVCell.h"

@interface SubCategoriesViewController ()

@end

@implementation SubCategoriesViewController
@synthesize subCategoryArray;

- (void)viewDidLoad {
    
    _refBtnNext.enabled=false;
    _refBtnNext.alpha=0.5;
    
    [self.collectionViewSubCategory registerClass:[CategoryCVCell class] forCellWithReuseIdentifier:@"CategoryCVCell"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark -
#pragma mark - UICollectionViewwDataSource

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (IS_IPHONE_5 || IS_IPHONE_4) {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    } else {
        return UIEdgeInsetsMake(20, 20, 20, 20);
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [subCategoryArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CategoryCVCell";
    CategoryCVCell *cell = (CategoryCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.lblCatName.text=[subCategoryArray objectAtIndex:indexPath.row];
    if ([strCategory isEqualToString:cell.lblCatName.text]) {
        [cell.refBtnCategory setImage:[UIImage imageNamed:@"selectCat.png"] forState:UIControlStateNormal];
    } else {
        [cell.refBtnCategory setImage:[UIImage imageNamed:[_subCatImgArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }
    // Return the cell
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([strCategory isEqualToString:[subCategoryArray objectAtIndex:indexPath.row]]) {
        strCategory=@"";
        _refBtnNext.alpha=0.5;
        _refBtnNext.enabled=false;
    } else {
        _refBtnNext.alpha=1.0;
        _refBtnNext.enabled=true;
        strCategory=[subCategoryArray objectAtIndex:indexPath.row];
    }
    [_collectionViewSubCategory reloadData];
}

- (IBAction)btnBack:(id)sender {
}

- (IBAction)btnNext:(id)sender {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
