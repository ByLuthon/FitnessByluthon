//
//  CategoryViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 18/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCVCell.h"
#import "FitnessViewController.h"
#import "SubCategoriesViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize isCreateActivity;

- (void)viewDidLoad {
    
    self.navigationController.navigationBarHidden = TRUE;
    
    if (isCreateActivity)
    {
        _btnBack.hidden = TRUE;
    }
    
    [_refBtnNext setTitleColor:kColorLightGray forState:UIControlStateNormal];
    _refBtnNext.enabled=false;
    _refBtnNext.alpha=0.5;
    
    [self.collectionViewCategory registerClass:[CategoryCVCell class] forCellWithReuseIdentifier:@"CategoryCVCell"];
    
    selectedArray=[[NSMutableArray alloc] init];
    categoryArray=[[NSMutableArray alloc] initWithObjects:@"Family",@"Sports",@"Social",@"Outdoors",@"Creativity",@"Education", nil];
    catImgArray=[[NSMutableArray alloc] initWithObjects:@"ic_family.png",@"ic_sports.png",@"ic_fun.png",@"ic_biking.png",@"ic_family.png",@"ic_fun.png", nil];
   
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
    
    return [categoryArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CategoryCVCell";
    CategoryCVCell *cell = (CategoryCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.lblCatName.text=[categoryArray objectAtIndex:indexPath.row];
    
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF contains[c] '%@'",[categoryArray objectAtIndex:indexPath.row]]];
    NSArray *filteredArr = [selectedArray filteredArrayUsingPredicate:sPredicate];
    
    if (filteredArr.count != 0) {
        [cell.refBtnCategory setImage:[UIImage imageNamed:@"selectCat.png"] forState:UIControlStateNormal];
    } else {
        [cell.refBtnCategory setImage:[UIImage imageNamed:[catImgArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }
    // Return the cell
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF contains[c] '%@'",[categoryArray objectAtIndex:indexPath.row]]];
    NSArray *filteredArr = [selectedArray filteredArrayUsingPredicate:sPredicate];
    
    if (filteredArr.count == 0) {
        [selectedArray addObject:[categoryArray objectAtIndex:indexPath.row]];
    } else {
        [selectedArray removeObject:[categoryArray objectAtIndex:indexPath.row]];
    }
    
    if (selectedArray.count == 0) {
        _refBtnNext.alpha=0.5;
        _refBtnNext.enabled=false;
        [_refBtnNext setTitleColor:kColorLightGray forState:UIControlStateNormal];
    } else {
        _refBtnNext.alpha=1.0;
        _refBtnNext.enabled=true;
        [_refBtnNext setTitleColor:RGBA(56, 46, 237, 1) forState:UIControlStateNormal];
        strCategory=[categoryArray objectAtIndex:indexPath.row];
    }
    [_collectionViewCategory reloadData];
}

- (IBAction)btnNext:(id)sender
{
//    if (isCreateActivity)
//    {
//        SubCategoriesViewController *fitnessVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SubCategoriesViewController"];
//        fitnessVC.subCategoryArray = selectedArray;
//        [self.navigationController pushViewController:fitnessVC animated:YES];
//    }
//    else
//    {
//        FitnessViewController *fitnessVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FitnessViewController"];
//        fitnessVC.selectedCategoryArray = selectedArray;
//        [self.navigationController pushViewController:fitnessVC animated:YES];
//    }
    
    FitnessViewController *fitnessVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FitnessViewController"];
    fitnessVC.selectedCategoryArray = selectedArray;
    fitnessVC.isCreateActivity = isCreateActivity;
    [self.navigationController pushViewController:fitnessVC animated:YES];

    

}
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
