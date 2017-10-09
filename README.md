# ORChartView
### iOS-简单实用的折线图

* 效果图   
![](https://github.com/SunriseOYR/ORChartView/blob/master/gif/002.gif?raw=false)

* 重绘效果图   
![](https://github.com/SunriseOYR/ORChartView/blob/master/gif/003.gif?raw=false)

* 样式  
总共四种样式 分别为 曲线、折线、网格曲线、网格折线  

![曲线](https://github.com/SunriseOYR/ORChartView/blob/master/gif/001.png?raw=false)
![折线](https://github.com/SunriseOYR/ORChartView/blob/master/gif/002.png?raw=false)
![网格曲线](https://github.com/SunriseOYR/ORChartView/blob/master/gif/003.png?raw=false)
![网格折线](https://github.com/SunriseOYR/ORChartView/blob/master/gif/004.png?raw=false)

* 接口相关代码

       /**
       * countY y轴 递增值的个数，默认7个
       * datasource
       */
      - (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray<NSString *>*)dataSource  countFoyY:(NSInteger)countY;

      //数据源 （赋值可重绘）
      @property (nonatomic,strong) NSArray *dataSource;

      // Y轴坐标数据， 根据dataSource 获取
      @property (nonatomic, strong,readonly) NSArray *dataArrOfY;

      // X轴坐标数据 默认为近期日期
      @property (nonatomic, strong) NSArray *dataArrOfX;

      //x轴，y轴标题
      @property (nonatomic, copy) NSString *titleForX;
      @property (nonatomic, copy) NSString *titleForY;

      //是否为折线 默认 NO
      @property (nonatomic, assign) BOOL isBrokenLine;

      //是否为矩形网格 默认 NO
      @property (nonatomic, assign) BOOL isMatrix;


* 使用 
    
      _chartView = [[ORChartView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 300) dataSource:@[@"90",@"30",@"10",@"20.5",@"91.5",@"44",@"66.6"] countFoyY:7];

      _chartView.titleForX = @"日期/日";
      _chartView.titleForY = @"收益/元";
    
      [self.view addSubview:_chartView];

* 调试  

      - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        /*
         随机数据源
         随机曲线折线
         随机网格
         */
         
        NSMutableArray *array = [NSMutableArray array];
    
        for (int i = 0; i < 20; i ++) {
            NSInteger num = arc4random() % 300;
            [array addObject:[NSString stringWithFormat:@"%ld",num]];
        }
        
        _chartView.dataSource = [array copy];
        _chartView.isMatrix = arc4random() % 2;
        _chartView.isBrokenLine = arc4random() % 2;
      }


