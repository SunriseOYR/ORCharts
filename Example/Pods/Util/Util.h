//
//  Util.h
//
//  Created by NobitaZZZ on 9/23/13.
//  Copyright (c) 2013 iSoftJSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Util : NSObject

@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *mdata;
//@property (strong, nonatomic) DB *db;

+(Util *) sharedInstance;
+(id) appDelegate;
+(NSMutableDictionary *) appData;
+(NSMutableDictionary *) appMData;

+(id) appRootViewController;


+(NSString *) docPath;
+(UIImage *) imageFromColor:(UIColor *)color size:(CGSize) size;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
typedef enum __UIImageGradientDirection
{
    UIImageGradientDirectionVertical    = 1,
    UIImageGradientDirectionHorizontal  = 2,
} UIImageGradientDirection;

+(UIImage*) gradient:(NSArray*) colors size:(CGSize) size direction:(UIImageGradientDirection) direction;
+(CGSize) sizeFor:(UILabel*)control;
+(CGSize) sizeForText:(NSString *)text font:(UIFont*)font width:(float)width;
+(NSString *) timeDiff:(NSDate *)origDate;

+ (void)loadData:(NSString *)url cache:(BOOL)cache callback:(void (^)(NSData *))callback;
+ (void) clearTmpData:(NSString *)url;
+ (NSString *) stringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSDate *) dateFromString:(NSString *)string format:(NSString *)format;
+ (UIImage *) imageWithView:(UIView *)view;
+ (UIImage *) cropImage:(UIImage *)image forSize:(CGSize)size;
+ (NSString*)niceTime:(double)sec;
+ (void) clearCookies;
@end


@interface NSString (MD5)
- (NSString *)md5;
@end

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

@implementation NSString (MyExtensions)
- (NSString *)md5
{
    CC_MD5_CTX md5;
    CC_MD5_Init (&md5);
    CC_MD5_Update (&md5, [self UTF8String], (CC_LONG) [self length]);
        
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0],  digest[1], 
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
                   
    return s;
    
}
@end

#define ASYNC_LOAD_IMG(img, src) img.image = nil;[Util loadData:src cache:YES callback:^(NSData *data){ [img setImage:[UIImage imageWithData:data]];}];

// debug
//#define DEBUG

#define FIX_EDGE7 if([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
#define TXT(textField) (textField.text.length > 0)?textField.text:@""
#define OBJ(o) (o != nil)?o:@""

#define DOC_PATH [Util docPath]
#define TMP_PATH NSTemporaryDirectory()
#define APP_PATH [[NSBundle mainBundle] resourcePath]
#define APP_DATA_FILE [NSString stringWithFormat:@"%@/DATA.plist", DOC_PATH]

#define APP_DELEGATE [Util appDelegate]
#define APP_UTIL [Util sharedInstance]
#define APP_ROOTVIEWCONTROLLER [Util appRootViewController]

#define APP_DATA APP_UTIL.data
#define APP_DATA_GET(k) [APP_DATA objectForKey:k]
#define APP_DATA_SET(k, v) if(v != nil){ [APP_DATA setObject:v forKey:k]; [APP_DATA writeToFile:APP_DATA_FILE atomically:YES]; }
#define APP_DATA_CLEAR(k) [APP_DATA removeObjectForKey:k]; [APP_DATA writeToFile:APP_DATA_FILE atomically:YES];
#define APP_DATA_CLEAR_ALL() [APP_DATA removeAllObjects]; [APP_DATA writeToFile:APP_DATA_FILE atomically:YES];

#define APP_MDATA APP_UTIL.mdata
#define APP_MDATA_GET(k) [APP_MDATA objectForKey:k]
#define APP_MDATA_SET(k, v) if(v != nil){ [APP_MDATA setObject:v forKey:k]; }
#define APP_MDATA_CLEAR(k) [APP_MDATA removeObjectForKey:k];
#define APP_MDATA_CLEAR_ALL() [APP_MDATA removeAllObjects];

#ifdef DEBUG
#   define L(fmt, ...) NSLog((@"%@:%d %s\n" fmt), [[@(__FILE__) componentsSeparatedByString:@"/"] lastObject], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#   define QL(v) L("%@", v)
#   define RL L("OK")
#   define QLR(r) L(@"%f, %f, %f, %f", r.origin.x, r.origin.y, r.size.width, r.size.height)
#   define QLS(s) L(@"%f, %f", s.width, s.height)
#   define QLP(p) L(@"%f, %f", p.x, p.y)
#else
#   define L(...)
#   define QL(...)
#   define RL
#   define QLR(...)
#   define QLS(...)
#   define QLP(...)
#endif

#define FL(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define ALERT(title, msg) UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:[NSString stringWithFormat:@"%@", msg] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];[av show]

#define SWIDTH [UIScreen mainScreen].bounds.size.width
#define SHEIGHT [UIScreen mainScreen].bounds.size.height

#define COLOR_FROM_IMAGE(i) [UIColor colorWithPatternImage:[UIImage imageNamed:i]]

#define UTIME [[NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]] integerValue]

#define UTIME_FROM_DATE(date) [date timeIntervalSince1970]
#define DATE_FROM_UTIME(time) [NSDate dateWithTimeIntervalSince1970:time]

#define SET_FRAME_X(f, x) f = RECT(x, f.origin.y, f.size.width, f.size.height)
#define SET_FRAME_Y(f, y) f = RECT(f.origin.x, y, f.size.width, f.size.height)

#define DMY @"dd/M/yyyy"

#define DEG2RAD(angle) angle*M_PI/180.0

#define IOS_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define SCREEN4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define SIZE(w, h) CGSizeMake(w,h)
#define RECT(x,y,w,h) CGRectMake(x,y,w,h)
#define POINT(x,y) CGPointMake(x,y)
#define RERECT(r,ax,ay,aw,ah) r = RECT(r.origin.x+ax,r.origin.y+ay,r.size.width+aw,r.size.height+ah);

#define BUNDLE_PATH(file, type) [[NSBundle mainBundle] pathForResource:file ofType:type]

#define STRING(obj) [NSString stringWithFormat: @"%@", obj]

#define DATA_TO_STRING(data) [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]

#define URL_ENCODE(obj) [STRING(obj) stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]

#define RGB(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]

#define TRANSPARENT [UIColor clearColor]

#define IMAGE(file) [UIImage imageNamed:file]

#define JSON_DECODE(obj) (obj == nil)?nil:[NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableLeaves error:nil]

#define CLEAR_SUBVIEWS(v) if([v subviews] != nil) [[v subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)]

#define LIST_FONT for(NSString *familyName in [UIFont familyNames]) { for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]){ QL(fontName) }}

#define FONT(fname, fsize) [UIFont fontWithName:fname size:fsize]
#define SFONT(size) [UIFont systemFontOfSize:size]
#define SBFONT(size) [UIFont boldSystemFontOfSize:size]

#define SET_IBUTTON_CONTENTMODE(button, mode) for(UIView* testId in button.subviews) {if([testId isKindOfClass:[UIImageView class]])[testId setContentMode:mode];};

#define IBUTTON_AFILL(button) for(UIView* testId in button.subviews) {if([testId isKindOfClass:[UIImageView class]])[testId setContentMode:UIViewContentModeScaleAspectFill];};











