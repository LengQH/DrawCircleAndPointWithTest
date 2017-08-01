//
//  ViewController.m
//  DrawTest
//
//  Created by 冷求慧 on 2017/8/1.
//  Copyright © 2017年 冷求慧. All rights reserved.
//

#import "ViewController.h"
#import "SleepQualityView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet SleepQualityView *sleepView;
/**
 *  宽度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
/**
 *  高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.widthConstraint.constant=self.widthConstraint.constant*heightRatioWithAll;
    self.heightConstraint.constant=self.heightConstraint.constant*heightRatioWithAll;
    
    [self.sleepView startExecuteAnimation];  // 开始执行动画
    
}


@end
