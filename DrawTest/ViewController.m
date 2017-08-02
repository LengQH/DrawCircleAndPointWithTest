//
//  ViewController.m
//  DrawTest
//
//  Created by 冷求慧 on 2017/8/1.
//  Copyright © 2017年 冷求慧. All rights reserved.
//

#import "ViewController.h"
#import "SleepQualityView.h"

@interface ViewController ()<SleepQualityViewDelegate>

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
    
    self.sleepView.delegate=self;
    [self.sleepView startExecuteAnimation];  // 开始执行动画
    
}
#pragma mark 代码方法
-(void)sleepQualityView:(SleepQualityView *)qualityView clickSleepHistoryButton:(ChangeFontWithButton *)sleepHistoryButton{
    NSLog(@"点击了睡眠足迹按钮");
}

@end
