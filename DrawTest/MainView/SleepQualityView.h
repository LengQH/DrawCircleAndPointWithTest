//
//  SleepQualityView.h
//  yoli
//
//  Created by 冷求慧 on 2017/7/29.
//  Copyright © 2017年 Leng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChangeFontWithLabel.h"
#import "ChangeFontWithButton.h"
#import "UIView+Extension.h"

#import "CircularSlider.h"

typedef void (^changeFinished)(void);

@class SleepQualityView;

@protocol SleepQualityViewDelegate <NSObject>

@optional
/**
 *  点击了睡眠足迹按钮
 *
 *  @param qualityView        本类对象
 *  @param sleepHistoryButton 睡眠足迹按钮
 */
-(void)sleepQualityView:(SleepQualityView *)qualityView clickSleepHistoryButton:(ChangeFontWithButton *)sleepHistoryButton;

@end

@interface SleepQualityView : UIView

/**
 *  成绩值
 */
@property (nonatomic,assign)NSInteger          gradeValue;
/**
 *  睡眠质量Label
 */
@property (nonatomic,strong)ChangeFontWithLabel *qualityNumberLabel;
/**
 *  日期Label
 */
@property (nonatomic,strong)ChangeFontWithLabel *dateLabel;
/**
 *  酒店名字Label
 */
@property (nonatomic,strong)ChangeFontWithLabel *hotelNameLabel;
/**
 *  结束睡眠Label
 */
@property (nonatomic,strong)ChangeFontWithLabel *endSleepLabel;
/**
 *  开始睡眠Label
 */
@property (nonatomic,strong)ChangeFontWithLabel *startSleepLabel;
/**
 *  代理属性
 */
@property (nonatomic,weak)id<SleepQualityViewDelegate> delegate;

/**
 *  设置睡眠Label上面的文字的富文本
 *
 *  @param setLabel 要设置的Label
 *  @param string   Label上面字符串
 */

-(void)setSleepLabelAttributedString:(ChangeFontWithLabel *)setLabel stringValue:(NSString *)string;
/**
 *  开始执行动画
 */
-(void)startExecuteAnimation;

@end
