//
//  SubCategoriesViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 01/12/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubCategoriesViewController : UIViewController
{
    NSMutableArray *subCategoryArray;
    NSString *strCategory;
}
- (IBAction)btnBack:(id)sender;
- (IBAction)btnNext:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *refBtnNext;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewSubCategory;

@property (nonatomic ,retain) NSMutableArray *subCatImgArray;
@property (nonatomic ,retain) NSMutableArray *subCategoryArray;

@end
