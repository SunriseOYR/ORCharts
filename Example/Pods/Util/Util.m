//
//  Util.m
//
//  Created by NobitaZZZ on 9/23/13.
//  Copyright (c) 2013 iSoftJSC. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "Util.h"

@implementation Util
+ (instancetype)sharedInstance
{
	static dispatch_once_t once;
	static id sharedInstance;
	dispatch_once(&once, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        if(![[NSFileManager defaultManager] fileExistsAtPath:APP_DATA_FILE]){
            _data = [[NSMutableDictionary alloc] init];
            [_data writeToFile:APP_DATA_FILE atomically:YES];
        }else{
            _data = [[NSMutableDictionary alloc] initWithContentsOfFile:APP_DATA_FILE];
        }
        _mdata = [[NSMutableDictionary alloc] init];
    }
    return self;
}


+(id) appDelegate {
    return [[UIApplication sharedApplication] delegate];
}

+(NSMutableDictionary *) appData {
    return [[Util sharedInstance] data];
}
+(NSMutableDictionary *) appMData {
    return [[Util sharedInstance] mdata];
}

+(id) appRootViewController {
    return [[[Util appDelegate] window] rootViewController];
}


+(NSString *) docPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

+ (void) loadData:(NSString *)url cache:(BOOL)cache callback:(void (^)(NSData *))callback {
    dispatch_async(kBgQueue, ^{
//        QL(url);
//        QL(TMP_PATH);
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        bool bundleOK = false;
//        if([url rangeOfString:@"/assets/uploads/"].location != NSNotFound && [url rangeOfString:API_URL].location != NSNotFound){
//            NSString *bfile = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[[url stringByReplacingOccurrencesOfString:API_URL withString:@""] stringByReplacingOccurrencesOfString:@"/assets/" withString:@"/"]];
////            QL(bfile);
//            if([[NSFileManager defaultManager] fileExistsAtPath:bfile isDirectory:NO]){
////                RL;
//                bundleOK = YES;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    callback([NSData dataWithContentsOfFile:bfile]);
//                });
//            }
//        }
		
//		QL(url);
        if(!bundleOK){
            NSString *file = [NSString stringWithFormat:@"%@/data_%@", TMP_PATH, [url md5]];
//			L(@"load %@", file);
            if(cache && [[NSFileManager defaultManager] fileExistsAtPath:file]){
				
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback([NSData dataWithContentsOfFile:file]);
                });
                
            }else{
                [NSURLConnection
                 sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                 queue:[NSOperationQueue mainQueue]
                 completionHandler:^(NSURLResponse * response, NSData * rs, NSError * error){
                     long statusCode = [((NSHTTPURLResponse *)response) statusCode];
                     if(statusCode == 200){
                         if(cache){
                             [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
                             [rs writeToFile:file atomically:YES];
                         }
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             callback(rs);
                         });
                     }
                     
                 }];
            }
        }
        
        
        
        
        
    });
    
    
    
}

+ (void) clearTmpData:(NSString *)url {
    NSString *file = [NSString stringWithFormat:@"%@/data_%@", TMP_PATH, [url md5]];
    
    QL(file);
    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
}

+(UIImage *) imageFromColor:(UIColor *)color size:(CGSize) size{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:0]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(NSString *) timeDiff:(NSDate *)origDate {
    NSDate *todayDate = [NSDate date];
    double ti = [origDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
    	return @"now";
    } else 	if (ti < 60) {
    	return @"now";
    } else if (ti < 3600) {
    	int diff = round(ti / 60);
    	return [NSString stringWithFormat:@"%dm", diff];
    } else if (ti < 86400) {
    	int diff = round(ti / 60 / 60);
    	return[NSString stringWithFormat:@"%dh", diff];
    } else if (ti < 2629743) {
    	int diff = round(ti / 60 / 60 / 24);
    	return[NSString stringWithFormat:@"%dd", diff];
    } else {
    	return [Util stringFromDate:origDate format:@"MMM d"];;
    }
}

+(UIImage*) gradient:(NSArray*) colors size:(CGSize) size direction:(UIImageGradientDirection) direction
{
    
    //    NSDictionary *descriptors = @{@"kUIImageColors": colors,
    //                                  @"kUIImageSize": [NSValue valueWithCGSize:size],
    //                                  @"kUIImageGradientDirection": @(direction)};
    
    UIImage *image;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Create Gradient
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors)
        [cgColors addObject:(id)color.CGColor];
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)cgColors, NULL);
    
    // Apply gradient
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    if (direction == UIImageGradientDirectionVertical)
        endPoint = CGPointMake(0, rect.size.height);
    
    else if (direction == UIImageGradientDirectionHorizontal)
        endPoint = CGPointMake(rect.size.width, 0);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Clean memory & End context
    UIGraphicsEndImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    
    
    return image;
}



+ (NSString *) stringFromDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}
+ (NSDate *) dateFromString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter dateFromString:string];
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


+ (UIImage *) cropImage:(UIImage *)image forSize:(CGSize)size {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:RECT(0, 0, size.width, size.height)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return [Util imageWithView:imageView];
}

+ (NSString*)niceTime:(double)sec {
    double numd = sec/86400;
    int d = (int)numd;
    double decpart = numd - d;
    
    double numh = decpart*24;
    int h = (int)numh;
    double decparth = numh - h;
    
    
    double numm = decparth*60;
    int m = (int)numm;
    double decpartm = numm - m;
    
    int s = decpartm*60;
    
    NSString *format = @"";
    if(d > 0){
        format = [NSString stringWithFormat:@"%@:%d", format, d];
    }
    if(h > 0 || d > 0){
        format = [NSString stringWithFormat:@"%@:%02d", format, h];
    }
    if(m > 0 || h > 0 || d > 0){
        format = [NSString stringWithFormat:@"%@:%02d", format, m];
    }
    if(s > 0 || m > 0 || h > 0 || d > 0){
        format = [NSString stringWithFormat:@"%@:%02d", format, s];
    }
    if([format length] > 0 && [[format substringToIndex:1] isEqualToString:@":"]) format = [format substringFromIndex:1];
    return [NSString stringWithFormat:format, d, h, m, s];
}
+(CGSize) sizeFor:(UILabel*)control {
    return [Util sizeForText:control.text font:control.font width:control.frame.size.width];
}
+(CGSize) sizeForText:(NSString *)text font:(UIFont*)font width:(float)width {
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:attributesDictionary
                                              context:nil];
    
    return frame.size;
}
+ (void) clearCookies {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
}
@end
