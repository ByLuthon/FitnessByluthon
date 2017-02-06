//
//  FitnessViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 18/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimatedMenuScene.h"
#import "MenuItemNode.h"
#import <SpriteKit/SpriteKit.h>
#import "Common.h"


@interface FitnessViewController : UIViewController<AnimatedMenuSceneDelegate, WebServiceCallDelegate>
{
    NSMutableArray *fitnessArray;
    NSMutableArray *imgArray;
    NSMutableArray *selectionArray;
    MBProgressHUD *HUD;
    
    
    //** Animation **\\
    
    AnimatedMenuScene *animatedMenuScene;
    SKView *skView;
}
@property (strong, nonatomic) WebService *webrequest;

@property (readwrite) BOOL isCreateActivity;

@property (retain, nonatomic) NSMutableArray *selectedCategoryArray;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnDone:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewAddWorkout;
@property (weak, nonatomic) IBOutlet UIButton *refBtnDone;
@property (weak, nonatomic) IBOutlet UIView *viewInterest;

@end
