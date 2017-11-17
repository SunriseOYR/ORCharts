# ORChartView
### iOS - 超轻量级的曲线图绘制

 [博客说明](http://www.jianshu.com/p/a571ae110ba5)

* 效果图   
![](https://github.com/SunriseOYR/ORChartView/blob/master/gif/002.gif?raw=false)

* 重绘效果图   
![](https://github.com/SunriseOYR/ORChartView/blob/master/gif/003.gif?raw=false)


* 使用 
    
      _chartView = [[ORChartView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 300) dataSource:@[@"90",@"30",@"10",@"20.5",@"91.5",@"44",@"66.6"] countFoyY:7];

      _chartView.titleForX = @"日期/日";
      _chartView.titleForY = @"收益/元";
    
      [self.view addSubview:_chartView];

* 调试  

        - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

            /*
            随机数据源
            随机样式
            随机颜色
            */

            NSMutableArray *array = [NSMutableArray array];

            for (int i = 0; i < 20; i ++) {
                NSInteger num = arc4random() % 300;
                [array addObject:[NSString stringWithFormat:@"%ld",(long)num]];
            }

            _chartView.dataSource = [array copy];
            _chartView.style = arc4random() % 4;

            _chartView.lineColor = [UIColor colorWithRed:arc4random() % 255 /255.f green:arc4random() % 255 /255.f blue:arc4random() % 255 /255.f alpha:1];
        }
        
* 接口


初始化

        /**
        * countY y轴 递增值的个数
        * datasource 数据源
        */
        - (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray<NSString *>*)dataSource  countFoyY:(NSInteger)countY;

        - (instancetype)initWithFrame:(CGRect)frame countFoyY:(NSInteger)countY;

数据

        //数据源 （赋值可重绘）
        @property (nonatomic,strong) NSArray *dataSource;

        // Y轴坐标数据， 根据dataSource 获取
        @property (nonatomic, strong,readonly) NSArray *dataArrOfY;

        // X轴坐标数据 默认为近期日期
        @property (nonatomic, strong) NSArray *dataArrOfX;

        //x轴，y轴标题
        @property (nonatomic, copy) NSString *titleForX;
        @property (nonatomic, copy) NSString *titleForY;

属性

        /**
        * 如果数据相同，仍然重新绘制曲线 默认 NO
        * 设为yes， 则只要重新设置数据源 都会有重绘动画，（tableView 上下滑动会出现动画）
        */
        @property (nonatomic, assign) BOOL reSetUIWhenSameData;

        /*
        * 样式 默认 ChatViewStyleSingleCurve
        */
        @property (nonatomic, assign) ChatViewStyle style;

        /*
        * 曲线颜色 默认 r:65 g:156 b:187
        */
        @property (nonatomic, copy) UIColor *lineColor;

        /*
        * 遮罩颜色
        * 遮罩颜色取 数组的第一个和最后一个
        * 不设置 将取 lineColor
        */
        @property (nonatomic, copy) NSArray<UIColor *> *maskColors;

        /*
        * 设置 点 的 图片和选中图片
        */
        - (void)setPointImage:(UIImage *)image pointselectedImage:(UIImage *)selectedImg;

回调

        /*
        * 点被选中的时候，回调 当前 值和下标
        */
        - (void)pointDidTapedCompletion:(void(^)(NSString *value,NSInteger index))block;


