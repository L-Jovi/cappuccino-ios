//
//  AppDelegate.m
//  testJSPatchView
//
//  Created by jovi on 15/11/23.
//  Copyright © 2015年 jovi. All rights reserved.

#import "AppDelegate.h"
#import "ViewController.h"

#import "JSPatch/JPEngine.h"
#import "CocoaLumberjack/CocoaLumberjack.h"

@import ObjectiveC;

static const DDLogLevel ddLogLevel = DDLogLevelWarning;


@interface AppDelegate ()
@end


@implementation AppDelegate

- (NSDictionary *)getConfigInfo
{
    [self loadLogConfig];
    
    DDLogError(@"sth happend ..");
    DDLogWarn(@"test warning ..");
    DDLogInfo(@"foo bar here test");
    
    NSDictionary *configInfo = @{
        @"localPath": @"demo",
        @"remoteUrl": @"http://172.26.129.189:5000/static/patch/demo.js",
    };
    
    return configInfo;
}

-(void)loadLogConfig
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}

- (UIView *)genView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"static/eva.jpg"]];
    return view;
}


/* various kinds of test case object */
- (void)testEnvCollection
{
    NSLog(@"⬇️⬇️⬇️");
    
    NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    NSLog(@"%@", timestamp);
    
//    [self testDict];
    
    SEL ts = NSSelectorFromString(@"testSelector");
    NSString *str = [self performSelector:@selector(testSelector:withStr:) withObject:[NSNumber numberWithInt:1] withObject:@"here"];
    NSLog(@"%@", str);

//    [self callMultiSelector];
    [self callMultiSelectorSimple];
    
//    NSArray *arr = [self testDivideString:@"foo:bar"];
//    NSLog(@"%@ - %@", arr[0], arr[1]);
    
//    [self testSetUserDefaults];
//    NSString *val = [self testGetUserDefaults];
//    NSLog(@"%@", val);
    
//    [self testMultiThread];
//    [self testMainThread];
}


- (BOOL)testDict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSNumber numberWithFloat:INFINITY] forKey:@"inf"];
    [dict setValue:[NSNumber numberWithInt:467] forKey:@"int"];
    
    int foo = 89174982;
    float bar = [dict[@"int"] floatValue];
    
    float inf = [dict[@"inf"] floatValue];
    if (foo < inf) {
        if (bar < foo) {
            NSLog(@"go on");
        }
        NSLog(@"correct");
        return YES;
    }
    
    NSLog(@"fault");
    return NO;
}

- (NSString *)testSelector:(NSNumber *)num withStr:(NSString *)str
{
    NSLog(@"🌈 test selector here coming .. %@ -- %@", num, str);
    return str;
}


/* selector below */
- (void)callMultiSelectorSimple
{
    NSString *mainLog = @"foo";
    NSString *subLog = @"bar";
    NSString *trivialLog = @"king";
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setValue:@"happend" forKey:@"sth"];
    
    NSMutableDictionary *dict = ((NSMutableDictionary *(*)(id, SEL, NSString *,  NSString *, NSMutableDictionary *, NSString *))objc_msgSend)(self, NSSelectorFromString(@"matchMultiSelecorSimple:with2nd:alongDict:and3rd:"), mainLog, subLog, item, trivialLog);
    NSLog(@"🔥 %@", dict);
    
    return;
}
- (NSMutableDictionary *)matchMultiSelecorSimple:(NSString *)mainLog with2nd:(NSString *)subLog alongDict:(NSMutableDictionary *)dict and3rd:(NSString *)trivialLog
{
    return dict;
}

- (void)callMultiSelector
{
    NSString *methodName = @"matchMultiSelecor:with2nd:alongDict:and3rd:";
    
    NSMutableArray *argsArr = [[NSMutableArray alloc] init];
    
    NSString *mainLog = @"foo";
    NSString *subLog = @"bar";
    NSString *trivialLog = @"king";
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setValue:@"happend" forKey:@"sth"];
    
    [argsArr addObject:mainLog];
    [argsArr addObject:subLog];
    [argsArr addObject:item];
    [argsArr addObject:trivialLog];
    
    [self testMultiSelectorViaArray:methodName withTarget:self andArgsArr:argsArr];
}
- (void)testMultiSelectorViaArray:(NSString *)methodName withTarget:(id)target andArgsArr:argsArr
{
    SEL sel = NSSelectorFromString(methodName);
    if ([target respondsToSelector:sel]) {
        
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:sel]];
        [inv setSelector:sel];
        [inv setTarget:target];
        
        id tmp;
        for (int i = 0; i < [argsArr count]; i++) {
            tmp = [argsArr objectAtIndex:i];
            [inv setArgument:&(tmp) atIndex:i+2];
        }
        [inv invoke];
        
        NSMutableDictionary * __unsafe_unretained tmpDict;
        [inv getReturnValue:&tmpDict];
        NSMutableDictionary *dict = tmpDict;
        
        NSLog(@"🚩 %@", dict);
    }
}
- (NSMutableDictionary *)matchMultiSelecor:(NSString *)mainLog with2nd:(NSString *)subLog alongDict:(NSMutableDictionary *)dict and3rd:(NSString *)trivialLog
{
    NSLog(@"hold %@ --- with %@ --- and %@ +++ %@", mainLog, subLog, trivialLog, dict);
    
    NSMutableDictionary *resDict = [[NSMutableDictionary alloc] init];
    [resDict setValue:mainLog forKey:@"mainLog"];
    [resDict setValue:subLog forKey:@"subLog"];
    [resDict setValue:dict forKey:@"item"];
    [resDict setValue:trivialLog forKey:@"trivialLog"];
    
    return resDict;
}
/* end selector */


- (NSArray *)testDivideString:(NSString *)str
{
    NSArray *arr = [str componentsSeparatedByString:@":"];
    return arr;
}

- (void)testSetUserDefaults
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"saber" forKey:@"king"];
    return;
}

- (NSString *)testGetUserDefaults
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"king"];
    return val;
}

- (void)testMultiThread
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"sub thread number - %d", i);
        }
    });
    return;
}

- (void)testMainThread
{
    for (int i = 0; i < 100; i++) {
        NSLog(@"main thread number - %d", i);
    }
    return;
}

- (void)testThreadAsync:(NSURLRequest *)req
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // maybe in the future.. above [script] will be display
        for (int i = 0; i < 100; i++) {
            NSLog(@"async thread number - %d", i);
        }
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:(id<NSURLSessionDelegate>)self delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [JPEngine evaluateScript:script];
            
            [self.window addSubview:[self genView]];
            [self.window makeKeyAndVisible];
            
            NSLog(@"%@", script);
            
            if ([script rangeOfString:@"defineClass"].location != NSNotFound) {
                NSLog(@"contain");
            };
        }];
        
        [task resume];
    });
}
/* end various test */


/* run various way to exec js file */
- (void)runLocalJs:(NSString *)localPath
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:localPath ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", script);
    [JPEngine evaluateScript:script];
    
    [self.window addSubview:[self genView]];
    [self.window makeKeyAndVisible];
}

- (void)runRemoteJsAsync:(NSURLRequest *)req
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:(id<NSURLSessionDelegate>)self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [JPEngine evaluateScript:script];
        
        [self.window addSubview:[self genView]];
        [self.window makeKeyAndVisible];
        
        NSLog(@"%@", script);
    }];

    [task resume];
}

- (NSString *)runRemoteJsSync:(NSURLRequest *)req
{
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
//    NSFileManager * fm = [NSFileManager new];
//    NSString * dirPath = [fm currentDirectoryPath];
//    NSLog(@"%@", dirPath);
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"rootPath >>> %@", rootPath);
    NSString *parentPath = [rootPath stringByAppendingPathComponent:@"static"];
    NSLog(@"parentPath >>> %@", parentPath);
    [[NSFileManager defaultManager] createDirectoryAtPath:parentPath withIntermediateDirectories:NO attributes:nil error:nil];
    NSString *filePath = [rootPath stringByAppendingPathComponent:@"static/test.js"];
    NSLog(@"path >>> %@", filePath);
    
    NSError *error;
    BOOL ok = [script writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!ok) {
        NSLog(@"Error writing file at %@\n%@",
              filePath, [error localizedFailureReason]);
    }

    [JPEngine evaluateScript:script];
    
    [self.window addSubview:[self genView]];
    [self.window makeKeyAndVisible];
    
    return script;
}
/* end run exec js file */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // maybe oc must have dispatch pointer to window.rootViewController
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
    
    /* refer extern dep */
    [JPEngine startEngine];
    /* end refer extern dep*/
    
    /* read simple config */
    NSDictionary *configInfo = [self getConfigInfo];
    /* end read config*/
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:configInfo[@"remoteUrl"]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
//    [self testThreadAsync:req];
//    [self runRemoteJsAsync:req];
//    [self runRemoteJsSync:req];
//    [self runLocalJs:configInfo[@"localPath"]];
    
    /* test various kinds function case */
    [self testEnvCollection];
    /* end test function case */
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end