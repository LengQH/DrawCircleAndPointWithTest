//
//  SleepQualityView.m
//  yoli
//
//  Created by 冷求慧 on 2017/7/29.
//  Copyright © 2017年 Leng. All rights reserved.
//

#import "SleepQualityView.h"

#define outsideCircleViewWH               140*heightRatioWithAll   // 最外面圆视图的宽高和上边距
#define outsideCircleViewTopDistance      80*heightRatioWithAll
#define outsideCircleBorderWidth          2.0*heightRatioWithAll   // 最外面圆的边框宽度

#define centerCircleViewWH                108*heightRatioWithAll   // 中间圆视图的宽高
#define insideCircleViewWH                76*heightRatioWithAll    // 最里面的圆的宽高
#define centerCircleBorderWidth           4.0*heightRatioWithAll   // 中心圆的边框宽度

#define qualityTopDistance                14*heightRatioWithAll    // 睡眠质量数字Label的上边距和宽高
#define qualityNumberLabelW               60*heightRatioWithAll
#define qualityNumberLabelH               30*heightRatioWithAll

#define qualityLabelW                     60*heightRatioWithAll    // 睡眠质量Label的宽高
#define qualityLabelH                     18*heightRatioWithAll

#define drawLineNumber                    36                       //  绘制直线的个数
#define drawLineWidth                     1.0*heightRatioWithAll   //  最外面圆的边框宽度

#define marginCircleWH                    9*heightRatioWithAll     //  边缘上圆的宽高
#define marginBorderW                     1.6*heightRatioWithAll   //  边缘上圆的边框宽度
#define historyLineW                      22*heightRatioWithAll    //  历史足迹线条的宽度
#define lineWidthValue                    1.2*heightRatioWithAll   //  直线的宽度

#define sleepHistoryButtonW               50*heightRatioWithAll    //  睡眠足迹按钮的宽高和左边距
#define sleepHistoryButtonH               20*heightRatioWithAll
#define sleepHistoryLeftDistance          4*heightRatioWithAll

#define dateLabelW                        60*heightRatioWithAll    // 日期Label的宽高和左边距
#define dateLabelH                        20*heightRatioWithAll
#define dateLabelLeftDistance             4*heightRatioWithAll

#define hotelNameLabelW                   120*heightRatioWithAll   // 酒店名字Label的宽高和左边距
#define hotelNameLabelH                   20*heightRatioWithAll
#define hotelNameLabelLeftDistance        4*heightRatioWithAll

#define endSleepLabelW                    66*heightRatioWithAll   // 结束睡眠Label的宽高和右边距
#define endSleepLabelH                    30*heightRatioWithAll
#define endSleepLabelRightDistance        -13.0*heightRatioWithAll

#define startSleepLabelW                  66*heightRatioWithAll   // 开始睡眠Label的宽高和右边距
#define startSleepLabelH                  30*heightRatioWithAll
#define startSleepLabelRightDistance      -17.0*heightRatioWithAll

#define centerLineH                       100*heightRatioWithAll  // 中间直线的高度
#define centerBomLineW                    180*heightRatioWithAll  // 中间直线下面的直线的宽度
#define centerRectangleW                  36*heightRatioWithAll   // 中间矩形的宽度
#define centerRectangleH                  4*heightRatioWithAll    // 中间矩形的高度
#define finaLeftAndRightLineH             38*heightRatioWithAll   // 最后左右直线的高度

#define animationNeedTimeWithACircle      2.0                     // 一个周期(一个圆)需要的动画时间
#define averageNumber                     10.0                    // 弧度的平均个数
#define lineWValue                        5*heightRatioWithAll    // 线条的宽度值
#define moveViewWH                        12*heightRatioWithAll
#define smallMoveImageViewWH              12*heightRatioWithAll

#define changeNum                         40                     // 改变的次数(UILabel)


// 对应的动画ID
#define sleepQualityAnimationID           @"sleepQualityAnimationID"
#define fiveLineAnimationID               @"fiveLineAnimationID"
#define verticalLineShapeID               @"verticalLineShapeID"
#define horizontalLeftAndRightLineID      @"horizontalLeftAndRightLineID"
#define horizontalLeftAndRightRectangleID @"horizontalLeftAndRightRectangleID"
#define verticalLeftAndRightCenterLineID  @"verticalLeftAndRightCenterLineID"



@interface SleepQualityView ()<CAAnimationDelegate>{
    
    UIView *outsideCircleView;
    UIView *insideCircleView;
    
    CGFloat angValue;                // 平均弧度值
    
    CGFloat startNeedShowNumValue;
    CGFloat showNumValue;
    
    
    CGFloat endAngleValueWithSure;   // 停止弧度值(精确到五位)
    CGFloat endAngleValue;           // 停止弧度值
    CGFloat averageTime;             // 平均时间
    CGFloat averageAngle;            // 每次改变的平均弧度
    
    
}
/**
 *  添加中心圆上的XY坐标值
 */
@property (nonatomic,strong)NSMutableArray<NSValue *>    *addCenterXYValue;
/**
 *  添加最里面圆上的XY坐标值
 */
@property (nonatomic,strong)NSMutableArray<NSValue *>    *addInsideXYValue;

/**
 *  添加Shape路径数组
 */
@property (nonatomic,strong)NSMutableArray<CAShapeLayer *> *arrShapeObj;
/**
 *  添加上一个起点
 */
@property (nonatomic,strong)NSMutableArray<NSNumber *>  *addDrawCircleLastPoint;
/**
 *  移动的点视图
 */
@property (nonatomic,strong)UIView       *movePointView;
/**
 *  定时器
 */
@property (nonatomic,strong)NSTimer      *timerWithCalculateNum;
/**
 *  用来添加五个显示控件,隐藏或者显示
 */
@property (nonatomic,strong)NSMutableArray<UIView *>    *addFiveUIShowView;
/**
 *  用来添加五个圆的数组,隐藏或者显示
 */
@property (nonatomic,strong)NSMutableArray<UIView *>     *addFiveCircleView;
/**
 *  用来添加首先执行动画的5条线段的shape
 */
@property (nonatomic,strong)NSMutableArray<CAShapeLayer *>  *addFiveAnimationLineShape;
/**
 *  用来添加底部直线执行动画的shape
 */
@property (nonatomic,strong)NSMutableArray<CAShapeLayer *>  *addBomLineAnimationShape;


@end


@implementation SleepQualityView

-(NSMutableArray<NSValue *> *)addCenterXYValue{
    if (_addCenterXYValue==nil) {
        _addCenterXYValue=[NSMutableArray array];
    }
    return _addCenterXYValue;
}
-(NSMutableArray<NSValue *> *)addInsideXYValue{
    if (_addInsideXYValue==nil) {
        _addInsideXYValue=[NSMutableArray array];
    }
    return _addInsideXYValue;
}
-(NSMutableArray<CAShapeLayer *> *)arrShapeObj{
    if (_arrShapeObj==nil) {
        _arrShapeObj=[NSMutableArray array];
    }
    return _arrShapeObj;
}
-(NSMutableArray<NSNumber *> *)addDrawCircleLastPoint{
    if (_addDrawCircleLastPoint==nil) {
        _addDrawCircleLastPoint=[NSMutableArray array];
    }
    return _addDrawCircleLastPoint;
}
-(UIView *)movePointView{
    if (_movePointView==nil) {
        _movePointView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, moveViewWH, moveViewWH)];
        [self addSubview:_movePointView];
        
        UIImageView *bigMoveImageView=[[UIImageView alloc]initWithFrame:_movePointView.bounds];
        bigMoveImageView.layer.masksToBounds=YES;
        bigMoveImageView.layer.cornerRadius=moveViewWH/2;
        bigMoveImageView.image=[UIImage imageNamed:@"movePointWithIndexDeep"];
        [_movePointView addSubview:bigMoveImageView];
        
        UIImageView *smallMoveImageView=[[UIImageView alloc]initWithFrame:CGRectMake(moveViewWH/2-smallMoveImageViewWH/2, moveViewWH/2-smallMoveImageViewWH/2, smallMoveImageViewWH, smallMoveImageViewWH)];
        smallMoveImageView.layer.masksToBounds=YES;
        smallMoveImageView.layer.cornerRadius=smallMoveImageViewWH/2;
        [smallMoveImageView setBackgroundColor:cusColor(62, 113, 219, 1.0)];
        [_movePointView addSubview:smallMoveImageView];
    }
    return _movePointView;
}
-(NSMutableArray<UIView *> *)addFiveUIShowView{
    if (_addFiveUIShowView==nil) {
        _addFiveUIShowView=[NSMutableArray array];
    }
    return _addFiveUIShowView;
}
-(NSMutableArray<UIView *> *)addFiveCircleView{
    if (_addFiveCircleView==nil) {
        _addFiveCircleView=[NSMutableArray array];
    }
    return _addFiveCircleView;
}
-(NSMutableArray<CAShapeLayer *> *)addFiveAnimationLineShape{
    if (_addFiveAnimationLineShape==nil) {
        _addFiveAnimationLineShape=[NSMutableArray array];
    }
    return _addFiveAnimationLineShape;
}
-(NSMutableArray<CAShapeLayer *> *)addBomLineAnimationShape{
    if(_addBomLineAnimationShape==nil){
        _addBomLineAnimationShape=[NSMutableArray array];
    }
    return _addBomLineAnimationShape;
}
#pragma mark 关联xib的时候
-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self initWithDrawView];         // 初始化绘图
    
}
#pragma mark 初始化的时候
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        [self initWithDrawView];   // 初始化绘图
        
    }
    return self;
}
#pragma mark 初始化绘图
-(void)initWithDrawView{
    
    [self createView];                 // 创建固定的视图
    
    [self calculatePointAndDrawUI];   // 计算点和绘制视图
    
}
#pragma mark 创建视图
-(void)createView{
    
    self.width=self.width*heightRatioWithAll;
    self.backgroundColor=cusColor(112, 112, 112, 0.3);

    // 最外面圆视图
    outsideCircleView=[[UIView alloc]initWithFrame:CGRectMake(self.width/2-outsideCircleViewWH/2,outsideCircleViewTopDistance, outsideCircleViewWH, outsideCircleViewWH)];
    [self addSubview:outsideCircleView];
    outsideCircleView.layer.cornerRadius=outsideCircleViewWH/2;
    outsideCircleView.layer.masksToBounds=YES;
    outsideCircleView.layer.borderWidth=outsideCircleBorderWidth;
    outsideCircleView.layer.borderColor=[cusColor(38, 48, 119, 0.85) CGColor];
    outsideCircleView.backgroundColor=[UIColor clearColor];
    
    // 中间圆视图
    CGFloat centerXValue=outsideCircleViewWH/2-centerCircleViewWH/2;
    UIView *centerCircleView=[[UIView alloc]initWithFrame:CGRectMake(centerXValue, centerXValue, centerCircleViewWH, centerCircleViewWH)];
    [outsideCircleView addSubview:centerCircleView];
    centerCircleView.layer.cornerRadius=centerCircleViewWH/2;
    centerCircleView.layer.masksToBounds=YES;
    centerCircleView.layer.borderWidth=centerCircleBorderWidth;
    centerCircleView.layer.borderColor=[cusColor(37, 47, 116, 0.85) CGColor];
    
    // 最里面圆视图
    CGFloat insideXValue=outsideCircleViewWH/2-insideCircleViewWH/2;
    insideCircleView=[[UIView alloc]initWithFrame:CGRectMake(insideXValue, insideXValue, insideCircleViewWH, insideCircleViewWH)];
    [outsideCircleView addSubview:insideCircleView];
    insideCircleView.layer.cornerRadius=insideCircleViewWH/2;
    insideCircleView.layer.masksToBounds=YES;
    insideCircleView.backgroundColor=cusColor(78, 142, 252, 1.0);
    insideCircleView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSleepQuality)];
    [insideCircleView addGestureRecognizer:tapGesture];
    
    
    // 睡眠质量数字Label
    CGFloat numberXValue=insideCircleViewWH/2-qualityNumberLabelW/2;
    self.qualityNumberLabel=[[ChangeFontWithLabel alloc]initWithFrame:CGRectMake(numberXValue,qualityTopDistance, qualityNumberLabelW, qualityNumberLabelH)];
    [insideCircleView addSubview:self.qualityNumberLabel];
    self.qualityNumberLabel.cusFont=cusFont(24);
    self.qualityNumberLabel.textColor=[UIColor whiteColor];
    self.qualityNumberLabel.textAlignment=NSTextAlignmentCenter;
    self.gradeValue=90;
    self.qualityNumberLabel.text=[NSString stringWithFormat:@"%zi",self.gradeValue];
    
    
    // 睡眠质量显示Label
    CGFloat labelYValue=qualityTopDistance+qualityNumberLabelH;
    ChangeFontWithLabel *qualityLabel=[[ChangeFontWithLabel alloc]init];
    qualityLabel.size=CGSizeMake(qualityLabelW, qualityLabelH);
    qualityLabel.center=CGPointMake(insideCircleViewWH/2, labelYValue+qualityLabelH/2);
    [insideCircleView addSubview:qualityLabel];
    qualityLabel.cusFont=cusFont(12);
    qualityLabel.textColor=[UIColor whiteColor];
    qualityLabel.textAlignment=NSTextAlignmentCenter;
    qualityLabel.text=@"睡眠质量";
    
}
#pragma mark 计算点和绘制UI
-(void)calculatePointAndDrawUI{
    
    [self calculateDrawPoint];   // 计算绘图的各个点
    [self drawLineWithPoint];    // 通过计算的点绘制直线
    
    [self drawFiveCircleAndSomeUI];  // 绘制5个圆和对应的直线以及边缘上的控件
}
/**
 *  计算圆上每个点的坐标
 *  解决思路：根据三角形的正玄、余弦来得值
 *  假设一个圆的圆心坐标是(a,b)，半径为r
 *  X坐标= a + sin(2*PI / 360) * r
 *  Y坐标= b + cos(2*PI / 360) * r
 *
 */
#pragma mark 计算绘图的各个点
-(void)calculateDrawPoint{

    angValue=M_PI*2/drawLineNumber;                        // 平均弧度值
    CGFloat circleCenterXYValue=outsideCircleViewWH/2;     // 圆心的XY值
    CGFloat centerCircleRadiusValue=centerCircleViewWH/2-centerCircleBorderWidth;  // 中间圆的半径
    CGFloat insideCircleRadiusValue=insideCircleViewWH/2;  // 最里面圆的半径
    
    for (NSInteger i=0; i<drawLineNumber; i++) {
        
        CGFloat xVaueWihCenter=circleCenterXYValue+sin(angValue*i)*centerCircleRadiusValue;   // 计算在中心圆上的X Y
        CGFloat yVaueWihCenter=circleCenterXYValue+cos(angValue*i)*centerCircleRadiusValue;
        NSValue *valueWithCenter=[NSValue valueWithCGPoint:CGPointMake(xVaueWihCenter, yVaueWihCenter)];
        [self.addCenterXYValue addObject:valueWithCenter];
        
        CGFloat xVaueWihInside=circleCenterXYValue+sin(angValue*i)*insideCircleRadiusValue;   // 计算在最里面圆上的X Y
        CGFloat yVaueWihInside=circleCenterXYValue+cos(angValue*i)*insideCircleRadiusValue;
        NSValue *valueWithInside=[NSValue valueWithCGPoint:CGPointMake(xVaueWihInside, yVaueWihInside)];
        [self.addInsideXYValue addObject:valueWithInside];

    }
}
#pragma mark 通过计算的点绘制36条直线
-(void)drawLineWithPoint{
    
    for (NSInteger i=0; i<self.addCenterXYValue.count; i++) {
        NSValue *valueWithCenter=self.addCenterXYValue[i];
        NSValue *valueWithInside=self.addInsideXYValue[i];
        
        // 创建对应的路径和添加图层到对应的视图上
        UIBezierPath *bezierPath=[self createLineBezierPath:[valueWithCenter CGPointValue] endPoint:[valueWithInside CGPointValue]];;
        [self addLayerToView:outsideCircleView bezierPath:bezierPath isFill:NO];
    }
}
#pragma mark 绘制5个圆和对应的直线以及边缘上的控件
-(void)drawFiveCircleAndSomeUI{
    
    // 绘制三个空心圆
    UIView *historyCircle=[self drawMarginCircle:15.0 isStroke:YES];
    UIView *yearMonthDayCircle=[self drawMarginCircle:6.8 isStroke:YES];
    UIView *hotelNameCircle=[self drawMarginCircle:1.3 isStroke:YES];
    
    // 绘制两个实心圆
    UIView *endSleepCircle=[self drawMarginCircle:-1.2 isStroke:NO];
    UIView *startSleepCircle=[self drawMarginCircle:-3.6 isStroke:NO];
    
    // 绘制三个空心圆右边的两条直线
    CGPoint endPointWithHistoryCircle=[self drawCircleRightLine:historyCircle deviateAng:13 nextPointXDeviateValue:41*heightRatioWithAll nextPointYDeviateValue:-46*heightRatioWithAll lastLineWidth:historyLineW rightOrLeft:YES];
    CGPoint endPointWithDateCircle=[self drawCircleRightLine:yearMonthDayCircle deviateAng:6 nextPointXDeviateValue:12*heightRatioWithAll nextPointYDeviateValue:20*heightRatioWithAll lastLineWidth:historyLineW rightOrLeft:YES];
    CGPoint endPointWithHotelCircle=[self drawCircleRightLine:hotelNameCircle deviateAng:2 nextPointXDeviateValue:10*heightRatioWithAll nextPointYDeviateValue:20*heightRatioWithAll lastLineWidth:historyLineW rightOrLeft:YES];
    
    // 绘制两个实心圆右边的两条直线
    CGPoint endSleepWithCircle=[self drawCircleRightLine:endSleepCircle deviateAng:-2 nextPointXDeviateValue:-22*heightRatioWithAll nextPointYDeviateValue:68*heightRatioWithAll lastLineWidth:historyLineW rightOrLeft:NO];
    CGPoint startSleepWithCircle=[self drawCircleRightLine:startSleepCircle deviateAng:-9 nextPointXDeviateValue:-34*heightRatioWithAll nextPointYDeviateValue:0 lastLineWidth:historyLineW rightOrLeft:NO];
    
    // 绘制五条直线和两个矩形
    [self drawFiveLineAndTwoRectangle];
    
    [self addSleepHistoryButton:endPointWithHistoryCircle];     // 添加睡眠足迹按钮
    [self addDateLabel:endPointWithDateCircle];                 // 添加日期Label
    [self addHotelNameLabel:endPointWithHotelCircle];           // 添加酒店名字Label
    [self addEndSleepLabel:endSleepWithCircle];                 // 添加结束睡眠Label
    [self addStartSleepLabel:startSleepWithCircle];             // 添加开始睡眠Label
    
    
}
#pragma mark 绘制边缘上对应的圆(-18<=locationValue<=18),isStroke:是空心还是实心
-(UIView *)drawMarginCircle:(CGFloat)locationValue isStroke:(BOOL)isStroke{
    
    //  绘制圆(直接用了UIView)
    
    CGFloat circleRadiusValue=isStroke?(outsideCircleViewWH/2-outsideCircleBorderWidth/2):(centerCircleViewWH/2+(outsideCircleViewWH/2-centerCircleViewWH/2)/2-outsideCircleBorderWidth/2);   // 空心圆和实心圆的半径不一样哦
    CGFloat outsideCircleRadiusValue=circleRadiusValue;      // 最外面圆圆的半径
    CGPoint outsideCirclePoint=outsideCircleView.center;     // 最外面圆圆的中心点
    CGFloat whValue=marginCircleWH;                          // 圆的直径
    
    CGFloat xVaueWihCenter=outsideCirclePoint.x+sin(angValue*locationValue)*outsideCircleRadiusValue;   // 中心点(圆心)
    CGFloat yVaueWihCenter=outsideCirclePoint.y+cos(-angValue*locationValue)*outsideCircleRadiusValue;
   
    UIView *circleView=[[UIView alloc]init];
    [self addSubview:circleView];
    circleView.size=CGSizeMake(whValue, whValue);
    circleView.center=CGPointMake(xVaueWihCenter, yVaueWihCenter);
    circleView.layer.cornerRadius=whValue/2;
    circleView.layer.masksToBounds=YES;
    
    if(isStroke){   // 空心的情况下要绘制边框线
        circleView.layer.borderWidth=marginBorderW;
        circleView.backgroundColor=[UIColor clearColor];
        circleView.layer.borderColor=[sureLowBlueColor CGColor];
    }
    circleView.backgroundColor=isStroke?[UIColor clearColor]:sureLowBlueColor;
    [self.addFiveCircleView addObject:circleView];
    
    return circleView;
}
#pragma mark 绘制空心圆和实心圆以及右边的两个直线
/**
 *
 *  @param circle        空心圆
 *  @param deviateAng    偏移角度 >=-18   <=18
 *  @param xDeviateValue 第二个点相对起点的偏移X值
 *  @param yDeviateValue 第二个点相对起点的偏移Y值
 *  @param lastLineWidth 第二条直线的宽度
 *  @param isRight   第二条直线向左还是向右
 *
 *  @return 直线的终点值
 */
-(CGPoint)drawCircleRightLine:(UIView *)circle deviateAng:(CGFloat)deviateAng nextPointXDeviateValue:(CGFloat)xDeviateValue nextPointYDeviateValue:(CGFloat)yDeviateValue lastLineWidth:(CGFloat)lastLineWidth rightOrLeft:(BOOL)isRight{
    
    // 绘制两条直线(在上面UIView圆(circle)的参考系上)
    CGFloat historyCircleRadiusValue=(marginCircleWH-marginBorderW)/2;   // 要计算圆的半径
    CGPoint historyCircleCenter=circle.center;
    
    CGFloat startXValue=historyCircleCenter.x+sin(angValue*deviateAng)*historyCircleRadiusValue;      // 直线的起点(x,y)
    CGFloat startYValue=historyCircleCenter.y+cos(-angValue*deviateAng)*historyCircleRadiusValue;
    
    // 两点确定一条直线,所以三个点就是两条直线
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    CGPoint startPoint=CGPointMake(startXValue, startYValue);                                       // 起点
    CGPoint nextPoint=CGPointMake(startXValue+xDeviateValue, startYValue+yDeviateValue);            // 下一个点
    CGPoint endPoint=CGPointMake(nextPoint.x+(isRight?lastLineWidth:-lastLineWidth), nextPoint.y);  // 终点
//    [bezierPath moveToPoint:startPoint];
//    [bezierPath addLineToPoint:nextPoint];
//    [bezierPath addLineToPoint:endPoint];
    
    [bezierPath moveToPoint:endPoint];
    [bezierPath addLineToPoint:nextPoint];
    [bezierPath addLineToPoint:startPoint];
    
    CAShapeLayer *shapeObj=[self addLayerToView:self bezierPath:bezierPath isFill:NO];  // 添加图层到对应的视图上
    [self.addFiveAnimationLineShape addObject:shapeObj];
    
    return endPoint;      // 返回终点,绘制直线后面的控件的
}
#pragma mark 绘制五条直线和两个矩形(七个UIBezierPath和CAShapeLayer)
-(void)drawFiveLineAndTwoRectangle{
    
    CGPoint outsideCirclePoint=outsideCircleView.center;     // 最外面圆圆的中心点
    
    // 这两点决定的是竖线(绘制的是竖线的路径)
    CGPoint startPoint=CGPointMake(outsideCirclePoint.x, outsideCirclePoint.y+outsideCircleViewWH/2);  // 起点
    CGPoint nextPoint=CGPointMake(startPoint.x, startPoint.y+centerLineH);                             // 下一个点
    UIBezierPath *bezierPathWithVertical=[self createLineBezierPath:startPoint endPoint:nextPoint];
    CAShapeLayer *verticalLineShape=[self addLayerToView:self bezierPath:bezierPathWithVertical isFill:NO];   // 添加两条直线到对应的视图上
    
    // 下面绘制的是两条横线的路径(为了更好的执行动画,所以单独初始化Path和Shape)
    
    CGPoint bomLineStartPoint=CGPointMake(nextPoint.x-centerBomLineW/2, nextPoint.y);  // 两条横线的终点
    CGPoint bomLineEndPoint=CGPointMake(nextPoint.x+centerBomLineW/2, nextPoint.y);
    UIBezierPath *bezierPathWithHorizontalLeft=[self createLineBezierPath:nextPoint endPoint:bomLineStartPoint];
    CAShapeLayer *horizontalLeftShape=[self addLayerToView:self bezierPath:bezierPathWithHorizontalLeft isFill:NO];
    
    UIBezierPath *bezierPathWithHorizontalRight=[self createLineBezierPath:nextPoint endPoint:bomLineEndPoint];
    CAShapeLayer *horizontalRightShape=[self addLayerToView:self bezierPath:bezierPathWithHorizontalRight isFill:NO];
    
    // 添加两个矩形
    UIBezierPath *bezierWithLeftRectangle=[UIBezierPath bezierPathWithRect:CGRectMake(bomLineStartPoint.x-centerRectangleW, bomLineStartPoint.y-centerRectangleH/2, centerRectangleW, centerRectangleH)];
    CAShapeLayer *horizontalLeftRectangleShape=[self addLayerToView:self bezierPath:bezierWithLeftRectangle isFill:YES];
    
    UIBezierPath *bezierWithRightRectangle=[UIBezierPath bezierPathWithRect:CGRectMake(bomLineEndPoint.x, bomLineEndPoint.y-centerRectangleH/2, centerRectangleW, centerRectangleH)];
    CAShapeLayer *horizontalRightRectangleShape=[self addLayerToView:self bezierPath:bezierWithRightRectangle isFill:YES];
    
    // 添加竖直方向左和右边的两条直线
    CAShapeLayer *verticalLeftCenterLineShape=[self addTwoVerticalLine:nextPoint leftOrLeft:YES];
    CAShapeLayer *verticalRightCenterLineShape=[self addTwoVerticalLine:nextPoint leftOrLeft:NO];

    // 添加底部需要执行的动画的Shape
    [self.addBomLineAnimationShape addObjectsFromArray:@[verticalLineShape,horizontalLeftShape,horizontalRightShape,horizontalLeftRectangleShape,horizontalRightRectangleShape,verticalLeftCenterLineShape,verticalRightCenterLineShape]];

}
#pragma mark 添加中间左边和右边的直线
-(CAShapeLayer *)addTwoVerticalLine:(CGPoint)startPoint leftOrLeft:(BOOL)leftOrLeft{
    
    CGPoint lineStartPoint=CGPointMake(startPoint.x+(leftOrLeft?-centerBomLineW/4:centerBomLineW/4), startPoint.y);
    CGPoint lineEndPoint=CGPointMake(lineStartPoint.x,lineStartPoint.y+finaLeftAndRightLineH);
    UIBezierPath *bezierPathWithLeftLine=[self createLineBezierPath:lineStartPoint endPoint:lineEndPoint];
    
    return [self addLayerToView:self bezierPath:bezierPathWithLeftLine isFill:NO];
}
#pragma mark 贝塞尔曲线创建直线
-(UIBezierPath *)createLineBezierPath:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    [bezierPath moveToPoint:startPoint];                  // 起点
    [bezierPath addLineToPoint:endPoint];                 // 终点
    return bezierPath;
}
#pragma mark 添加图层到对应的视图上
/**
 *
 *  @param addView    要添加到的视图上
 *  @param bezierPath 绘图路径
 *  @param isFill     是否实心
 *
 *  @return 图层对象
 */
-(CAShapeLayer *)addLayerToView:(UIView *)addView bezierPath:(UIBezierPath *)bezierPath isFill:(BOOL)isFill{
    
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.lineWidth=drawLineWidth;
    shapeLayer.fillColor=isFill?sureLowBlueColor.CGColor:[UIColor clearColor].CGColor;   // 填充颜色
    shapeLayer.strokeColor=sureLowBlueColor.CGColor;     // 边框颜色
    shapeLayer.path=bezierPath.CGPath;
    [addView.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}
#pragma mark 添加睡眠足迹按钮
-(void)addSleepHistoryButton:(CGPoint)endPoint{
    // 睡眠足迹按钮
    ChangeFontWithButton *sleepHistoryButton=[[ChangeFontWithButton alloc]init];
    sleepHistoryButton.size=CGSizeMake(sleepHistoryButtonW, sleepHistoryButtonH);
    sleepHistoryButton.center=CGPointMake(endPoint.x+sleepHistoryLeftDistance+sleepHistoryButtonW/2, endPoint.y);
    [self addSubview:sleepHistoryButton];
    sleepHistoryButton.layer.cornerRadius=6.0;
    sleepHistoryButton.layer.masksToBounds=YES;
    sleepHistoryButton.backgroundColor=cusColor(78, 142, 252, 1.0);
    sleepHistoryButton.cusFont=cusFont(11);
    [sleepHistoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sleepHistoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [sleepHistoryButton setTitle:@"睡眠足迹" forState:UIControlStateNormal];
    [sleepHistoryButton setTitle:@"睡眠足迹" forState:UIControlStateHighlighted];
    [self.addFiveUIShowView addObject:sleepHistoryButton];
    
    [sleepHistoryButton addTarget:self action:@selector(sleepHistoryAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 添加日期Label
-(void)addDateLabel:(CGPoint)endPoint{
    
    self.dateLabel=[[ChangeFontWithLabel alloc]init];
    self.dateLabel.size=CGSizeMake(dateLabelW, dateLabelH);
    self.dateLabel.center=CGPointMake(endPoint.x+dateLabelLeftDistance+dateLabelW/2, endPoint.y);
    self.dateLabel.textAlignment=NSTextAlignmentLeft;
    self.dateLabel.cusFont=cusFont(9);
    self.dateLabel.textColor=cusColor(112, 122, 140, 1.0);
    self.dateLabel.numberOfLines=0;
    [self addSubview:self.dateLabel];
    self.dateLabel.text=@"2017-07-19";
    [self.addFiveUIShowView addObject:self.dateLabel];
    
}
#pragma mark 添加酒店名字Label
-(void)addHotelNameLabel:(CGPoint)endPoint{

    self.hotelNameLabel=[[ChangeFontWithLabel alloc]init];
    self.hotelNameLabel.size=CGSizeMake(hotelNameLabelW, hotelNameLabelH);
    self.hotelNameLabel.center=CGPointMake(endPoint.x+hotelNameLabelLeftDistance+hotelNameLabelW/2, endPoint.y);
    self.hotelNameLabel.textAlignment=NSTextAlignmentLeft;
    self.hotelNameLabel.cusFont=cusFont(9);
    self.hotelNameLabel.textColor=cusColor(112, 122, 140, 1.0);
    self.hotelNameLabel.numberOfLines=0;
    [self addSubview:self.hotelNameLabel];
    self.hotelNameLabel.text=@"深圳后海凯宾斯基大酒店";
    [self.addFiveUIShowView addObject:self.hotelNameLabel];
}
#pragma mark 添加结束睡眠Label
-(void)addEndSleepLabel:(CGPoint)endPoint{
    
    self.endSleepLabel=[[ChangeFontWithLabel alloc]init];
    self.endSleepLabel.size=CGSizeMake(endSleepLabelW, endSleepLabelH);
    self.endSleepLabel.center=CGPointMake(endPoint.x-endSleepLabelRightDistance-endSleepLabelW/2, endPoint.y-endSleepLabelH/2+5*heightRatioWithAll);           // 5*heightRatioWithAll  是自己添加的一个向下移的高度
    self.endSleepLabel.textAlignment=NSTextAlignmentLeft;
    self.endSleepLabel.cusFont=cusFont(9);
    self.endSleepLabel.textColor=cusColor(112, 122, 140, 1.0);
    self.endSleepLabel.numberOfLines=0;
    [self addSubview:self.endSleepLabel];
    [self.addFiveUIShowView addObject:self.endSleepLabel];
//    self.endSleepLabel.backgroundColor=[UIColor purpleColor]; // 调试用的
    [self setSleepLabelAttributedString:self.endSleepLabel stringValue:@"09:56 AM\n结束睡眠"]; // 设置文字的富文本
    
    
}
#pragma mark 添加开始睡眠Label
-(void)addStartSleepLabel:(CGPoint)endPoint{
    
    self.startSleepLabel=[[ChangeFontWithLabel alloc]init];
    self.startSleepLabel.size=CGSizeMake(startSleepLabelW, startSleepLabelH);
    self.startSleepLabel.center=CGPointMake(endPoint.x-startSleepLabelRightDistance-startSleepLabelW/2, endPoint.y-startSleepLabelH/2+5*heightRatioWithAll);
    self.startSleepLabel.textAlignment=NSTextAlignmentLeft;
    self.startSleepLabel.cusFont=cusFont(9);
    self.startSleepLabel.textColor=cusColor(112, 122, 140, 1.0);
    self.startSleepLabel.numberOfLines=0;
    [self addSubview:self.startSleepLabel];
    [self.addFiveUIShowView addObject:self.startSleepLabel];
//    self.startSleepLabel.backgroundColor=[UIColor purpleColor];
    [self setSleepLabelAttributedString:self.startSleepLabel stringValue:@"11:48 PM\n开始睡眠"];
    
}
#pragma mark 设置文字的富文本
-(void)setSleepLabelAttributedString:(ChangeFontWithLabel *)setLabel stringValue:(NSString *)string{
    setLabel.text=string;
    if (string.length<5) return;
    NSMutableAttributedString *attributed=[[NSMutableAttributedString alloc]initWithString:string];
    NSRange rang={0,5};
    [attributed addAttributes:@{NSFontAttributeName:cusFont(15),NSForegroundColorAttributeName:[UIColor whiteColor]} range:rang];
    setLabel.attributedText=attributed;
    
}

#pragma mark 点击了睡眠足迹按钮操作
-(void)sleepHistoryAction:(ChangeFontWithButton *)button{
    
    if([self.delegate respondsToSelector:@selector(sleepQualityView:clickSleepHistoryButton:)]){
        [self.delegate sleepQualityView:self clickSleepHistoryButton:button];
    }
}
#pragma mark 点击了睡眠质量
-(void)clickSleepQuality{
    
    insideCircleView.userInteractionEnabled=NO;
    
    // 隐藏五个圆和五个控件
    [self hiddenOrShowLabelAndButton];
    [self hiddenOrShowFiveMarginCircle:YES];
    
    // 移除视图的shape
    [self removeShapeAndView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self animationShowButtonAndLabel:0];
        
        [self startExecuteSleepQualityAnimation:self.gradeValue];      // 开始执行睡眠质量动画
        
        CGFloat value=self.gradeValue/100.0;
        CGFloat needFinishTime=animationNeedTimeWithACircle*value;
        [self changeLabelNum:self.gradeValue needTime:needFinishTime]; // 改变Label上面的值
        
    });
}
#pragma mark 开始执行动画
-(void)startExecuteAnimation{
    
    [self clickSleepQuality];
}






/************************************  下面是给      ************************************
 ************************************  对应的视图    ************************************
 ************************************  添加动画     ************************************/


#pragma mark -改变Label上面的值
-(void)changeLabelNum:(CGFloat)numValue needTime:(CGFloat)needTime{
    startNeedShowNumValue=numValue/changeNum;
    showNumValue=startNeedShowNumValue;
    
    CGFloat eachNeedTime=needTime/changeNum;      // 平均每次需要的时间
    
//    NSLogLeng(@"显示的最终的数据:%f 完成的总时间:%f 平均的数据:%f 平均的时间:%f",numValue,needTime,startNeedShowNumValue,eachNeedTime);
    
    self.qualityNumberLabel.text=[NSString stringWithFormat:@"%0.0f",startNeedShowNumValue];
    
    self.timerWithCalculateNum=[NSTimer scheduledTimerWithTimeInterval:eachNeedTime target:self selector:@selector(changeLabelWithTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timerWithCalculateNum forMode:NSRunLoopCommonModes];
}
-(void)changeLabelWithTimer:(NSTimer *)timer{
    showNumValue=(showNumValue+startNeedShowNumValue);
    NSInteger maxValue=self.gradeValue;
    if (showNumValue>=maxValue) {
        [timer invalidate];
        timer=nil;
        showNumValue=0.0;
        self.qualityNumberLabel.text=[NSString stringWithFormat:@"%zi",maxValue];
    }
    else{
        self.qualityNumberLabel.text=[NSString stringWithFormat:@"%0.0f",showNumValue];
    }
}


#pragma mark  开始执行睡眠报告动画
-(void)startExecuteSleepQualityAnimation:(CGFloat)gradeValue{
    
    self.movePointView.hidden=NO;
    
    CGFloat value=gradeValue/100.0;
    CGFloat needFinishTime=animationNeedTimeWithACircle*value;
    [self drawSectorView:value needTime:needFinishTime];     // 绘制扇形视图(通过比例)
    
}
#pragma mark 通过睡眠质量绘制扇形(后期的方法分割成10等份执行)
-(void)drawSectorView:(CGFloat)scaleValue needTime:(CGFloat)needTime{
    
    for (CAShapeLayer *shapeObj in self.arrShapeObj) { // 移除所有的绘图路径
        [shapeObj removeFromSuperlayer];
    }
    if(!(scaleValue>0)) return;
    
    averageTime=needTime/averageNumber;               //  动画每次执行的时间
    CGFloat unitValue=M_PI*2;                         //  一个圆
    CGFloat startValue=-(M_PI/2);                     //  起点位置
    CGFloat finaChangeValue=unitValue*scaleValue;     //  真正需要改变的值
    endAngleValue=finaChangeValue+startValue;         //  结束的弧度值
    averageAngle=finaChangeValue/averageNumber;       //  改变的每段弧度值
    
    endAngleValueWithSure=[[NSString stringWithFormat:@"%0.5f",endAngleValue] floatValue];
    
    CGFloat startFirstValue=startValue+averageAngle;        //  第一个开始的弧度制
    [self drawCircle:startValue endValue:startFirstValue];  //  开始画圆弧
}
#pragma mark 开始画圆弧(判断是否结束绘制动画)
-(void)drawCircle:(CGFloat)startValue endValue:(CGFloat)endValue{

    CGFloat startValueWithSure=[[NSString stringWithFormat:@"%0.5f",startValue] floatValue];
    if(startValueWithSure>=(endAngleValueWithSure)){
        [self.timerWithCalculateNum invalidate];
        self.timerWithCalculateNum=nil;
        showNumValue=0.0;
        self.qualityNumberLabel.text=[NSString stringWithFormat:@"%zi",self.gradeValue];
        
        [self startExecuteFiveLineAnimation];                          //  执行五个线段动画
        
        return;
    }
    
    [self.addDrawCircleLastPoint removeAllObjects];
    [self.addDrawCircleLastPoint addObject:[NSNumber numberWithFloat:endValue]];  // 添加下一个起点
    
    // 添加一个圆的路径
    UIBezierPath *bezier=[UIBezierPath bezierPath];
    CGPoint centerPoint=outsideCircleView.center;                               // 圆心的位置
    CGFloat radiusValue=centerCircleViewWH/2-centerCircleBorderWidth/2;         // 半径
    
    [bezier addArcWithCenter:centerPoint radius:radiusValue startAngle:startValue endAngle:endValue clockwise:YES]; // clockwise:是否顺时针
    
    // 设置Layer的一些属性
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    [self.arrShapeObj addObject:shapeLayer];
    shapeLayer.lineCap=kCALineCapRound;
    shapeLayer.lineJoin=kCALineJoinRound;
    shapeLayer.lineWidth=lineWValue;
    shapeLayer.strokeColor=cusColor(62, 113, 219, 1.0).CGColor;    // 设置空心和实心对应的颜色
    shapeLayer.fillColor=[UIColor clearColor].CGColor;
    shapeLayer.path=bezier.CGPath;
    
    // 通过关键帧动画和基本动画执行圆弧的整个动画
    [self addNewKeyframeAnimation:shapeLayer];
    [self setViewAnimationToLayer:self shapeObj:shapeLayer valueID:sleepQualityAnimationID animationNeedTime:averageTime];
    
    
}
#pragma mark 执行五个线段动画
-(void)startExecuteFiveLineAnimation{
    
    CABasicAnimation *baseAnimation=[self addNewBaseAnimation:fiveLineAnimationID animationNeedTime:1.0];

    for (CAShapeLayer *shapeObj in self.addFiveAnimationLineShape) {
        [shapeObj addAnimation:baseAnimation forKey:nil];          // layer添加动画
        [self.layer addSublayer:shapeObj];
    }
}
#pragma mark 设置视图对应的动画到Layer上(基本动画)
-(void)setViewAnimationToLayer:(UIView *)setViewObj shapeObj:(CAShapeLayer *)shapeObj valueID:(NSString *)valueID animationNeedTime:(CGFloat)animationNeedTime{
    
    if ((!shapeObj)||(!valueID)) return;
    
    CABasicAnimation *baseAnimation=[self addNewBaseAnimation:valueID animationNeedTime:animationNeedTime];
    [shapeObj addAnimation:baseAnimation forKey:nil];          // layer添加动画
    [setViewObj.layer addSublayer:shapeObj];
    
}
#pragma mark 添加关键帧动画
-(void)addNewKeyframeAnimation:(CAShapeLayer *)shapeObj{
    
    CAKeyframeAnimation *keyFrame=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrame.duration=averageTime;
    keyFrame.path=shapeObj.path;
    keyFrame.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyFrame.removedOnCompletion=NO;
    keyFrame.fillMode=kCAFillModeForwards;
    [self.movePointView.layer addAnimation:keyFrame forKey:nil];
    
}
#pragma mark 添加基础动画
-(CABasicAnimation *)addNewBaseAnimation:(NSString *)valueID animationNeedTime:(CGFloat)animationNeedTime{

    if (!valueID) return nil;
    
    CABasicAnimation *base=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];  // 初始化基本动画类型
    base.duration=animationNeedTime;
    base.fromValue=[NSNumber numberWithFloat:0.0f];
    base.toValue=[NSNumber numberWithFloat:1.0];
    base.removedOnCompletion=NO;
    base.fillMode=kCAFillModeForwards;
    base.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; // 匀速执行动
    [base setValue:valueID forKey:valueID];
    base.delegate=self;                               // 代理要放在添加动画之前
    
    return base;
}
#pragma mark 动画执行完毕
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    // 继续绘制圆弧
    if ([[anim valueForKey:sleepQualityAnimationID]isEqualToString:sleepQualityAnimationID]) {
        CGFloat startAngle=[[self.addDrawCircleLastPoint firstObject] floatValue];
        [self drawCircle:startAngle endValue:startAngle+averageAngle];
    }
    // 五个线段动画执行完毕之后,显示对应的圆和去动画执行最长的竖直线动画
    if ([[anim valueForKey:fiveLineAnimationID]isEqualToString:fiveLineAnimationID]) {
        [self hiddenOrShowFiveMarginCircle:NO];
        
        [self setViewAnimationToLayer:self shapeObj:[self.addBomLineAnimationShape firstObject] valueID:verticalLineShapeID animationNeedTime:0.8];
        
    }
    // 最长的竖直线动画执行完毕后,动画绘制左右边的水平直线(延时一半的时间,一半的时间去执行最后的两个中间竖直直线动画),
    if([[anim valueForKey:verticalLineShapeID]isEqualToString:verticalLineShapeID]){
        CGFloat needTime=0.6;
        [self startUseSameAnimation:needTime valueID:horizontalLeftAndRightLineID startShape:self.addBomLineAnimationShape[1] nextShape:self.addBomLineAnimationShape[2]];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(needTime/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startUseSameAnimation:needTime/2 valueID:verticalLeftAndRightCenterLineID startShape:self.addBomLineAnimationShape[5] nextShape:self.addBomLineAnimationShape[6]];
        });
    }
    // 左边的水平直线动画完成后,去动画绘图左边的矩形
    if ([[anim valueForKey:horizontalLeftAndRightLineID]isEqualToString:horizontalLeftAndRightLineID]) {
        [self startUseSameAnimation:0.3 valueID:horizontalLeftAndRightRectangleID startShape:self.addBomLineAnimationShape[3] nextShape:self.addBomLineAnimationShape[4]];
    }
    // 最后的两条中间的竖直直线动画完成后,恢复睡眠质量视图可以触摸
    if ([[anim valueForKey:verticalLeftAndRightCenterLineID]isEqualToString:verticalLeftAndRightCenterLineID]) {
        insideCircleView.userInteractionEnabled=YES;
    }
}
#pragma mark 两条直线使用一个动画
-(void)startUseSameAnimation:(CGFloat)needAnimaTime valueID:(NSString *)valueID startShape:(CAShapeLayer *)startShape nextShape:(CAShapeLayer *)nextShape{
    
    if (!(startShape&&nextShape)) return;
    
    CABasicAnimation *baseAnima=[self addNewBaseAnimation:valueID animationNeedTime:needAnimaTime];
    [startShape addAnimation:baseAnima forKey:nil];
    [nextShape addAnimation:baseAnima forKey:nil];
    [self.layer addSublayer:startShape];
    [self.layer addSublayer:nextShape];
}

#pragma mark 隐藏或者显示对应的按钮和Label
-(void)hiddenOrShowLabelAndButton{
    
    for (UIView *circle in self.addFiveUIShowView) {
        circle.hidden=YES;
    }
}
#pragma mark 动画显示按钮和Label
-(void)animationShowButtonAndLabel:(CGFloat)aValue{
    
    if (aValue>1.0) return;
    
    __block CGFloat backFloat=aValue;
    
    if (aValue==0) {
        for (UIView *circle in self.addFiveUIShowView) {
            circle.alpha=0.0;
            circle.hidden=NO;
        }
    }
    [UIView animateWithDuration:0.15 animations:^{
        for (UIView *circle in self.addFiveUIShowView) {
            circle.alpha=backFloat;
        }
    } completion:^(BOOL finished) {
        backFloat+=0.1;
        [self animationShowButtonAndLabel:backFloat];
    }];
}
#pragma mark 隐藏或者显示五个边缘圆
-(void)hiddenOrShowFiveMarginCircle:(BOOL)isHidden{
    for (UIView *circle in self.addFiveCircleView) {
        circle.hidden=isHidden;
    }
}
#pragma mark 移除shape和视图
-(void)removeShapeAndView{
    
    self.movePointView.hidden=YES;
    
    for (CAShapeLayer *shape in self.addFiveAnimationLineShape) {
        [shape removeFromSuperlayer];
    }
    for (CAShapeLayer *shape in self.addBomLineAnimationShape) {
        [shape removeFromSuperlayer];
    }
    for (CAShapeLayer *shape in self.arrShapeObj){
        [shape removeFromSuperlayer];
    }
}

@end
