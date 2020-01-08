# ORCharts

[![CI Status](https://img.shields.io/travis/sunrise_oy@163.com/ORCharts.svg?style=flat)](https://travis-ci.org/sunrise_oy@163.com/ORCharts)
[![Version](https://img.shields.io/cocoapods/v/ORCharts.svg?style=flat)](https://cocoapods.org/pods/ORCharts)
[![License](https://img.shields.io/cocoapods/l/ORCharts.svg?style=flat)](https://cocoapods.org/pods/ORCharts)
[![Platform](https://img.shields.io/cocoapods/p/ORCharts.svg?style=flat)](https://cocoapods.org/pods/ORCharts)

## Table of contents
* [Screenshots](#screenshots)
* [Installation](#installation)
* [Setup](#setup)

# <a id="screenshots"></a>Screenshots 

### RingChart
![RingChart](https://upload-images.jianshu.io/upload_images/5192751-6b13744cc1b9926d.png?imageMogr2/auto-orient/strip%7CimageView2/2/h/440)

### LineChart
|    Slider    |    Control    |
|--------------|-------------|
|![Slider](https://upload-images.jianshu.io/upload_images/5192751-3f68f4db547e98e3.gif?imageMogr2/auto-orient/strip)|![Control](https://upload-images.jianshu.io/upload_images/5192751-cc2abfaa9d6a4330.gif?imageMogr2/auto-orient/strip)|


### Example Config

To run the example project.

|    Ring    |    Line    |
|--------------|-------------|
|   ![Config](https://upload-images.jianshu.io/upload_images/5192751-0a70eb88d3829d58.gif?imageMogr2/auto-orient/strip)   |   ![101.gif](https://upload-images.jianshu.io/upload_images/5192751-00b5849cfb364bc4.gif?imageMogr2/auto-orient/strip)   |


# <a id="installation"></a>Installation

### ORCharts
```ruby
pod 'ORCharts'
```
### Only Ring

```ruby
pod 'ORCharts/Ring'  
```
### Only Line

```ruby
pod 'ORCharts/Line'  
```
# <a id="setup"></a>Setup

## Use Interface Builder
1、 Drag an UIView object to ViewController Scene
2、 Change the `Custom Class` to `ORLineChartView` or `ORRingChartView` <br/>
3、 Link `dataSource` and `delegate` to the ViewController <br/>

## Or use code

```objc
@property (nonatomic, strong) ORRingChartView *ringChartView;
```
```objc
_ringChartView = [[ORRingChartView alloc] initWithFrame:CGRectMake(0, 0, 375, 375)];
_ringChartView.dataSource = self;
[self.view addSubview:_ringChartView];
```
<br/>
```objc
@property (nonatomic, strong) ORLineChartView *lineChartView;
```
```objc
_lineChartView = [[ORLineChartView alloc] initWithFrame:CGRectMake(0, 0, 375, 350)];
_lineChartView.dataSource = self;
_lineChartView.delegate = self;    
[self.view addSubview:_lineChartView];
```
<br/>

## reloadData
reloadData when data or config changed, see more usage and config in example

```objc
[_ringChartView reloadData];
```
```objc
[_lineChartView reloadData];
```
## dataSource && delegate && config
Refer to the Example Or Click the link below

* [ORCharts:Ring](https://www.jianshu.com/p/317a79890984)
* [ORCharts:Line](https://www.jianshu.com/p/a571ae110ba5)



## License

ORCharts is available under the MIT license. See the LICENSE file for more info.

### [中文简书](https://www.jianshu.com/p/6f65bf7dfbbf)
