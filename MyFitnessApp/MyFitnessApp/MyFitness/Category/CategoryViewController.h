//
//  CategoryViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 18/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController
{
    NSMutableArray *categoryArray;
    NSString *strCategory;
    NSMutableArray *catImgArray;
    NSMutableArray *selectedArray;
}
@property (readwrite) BOOL isCreateActivity;

@property (weak, nonatomic) IBOutlet UITableView *tblActivitry;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewCategory;
- (IBAction)btnNext:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *refBtnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end
