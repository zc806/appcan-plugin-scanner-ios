//
//  ZXingCodeScanner.m
//  EUExScanner
//
//  Created by AppCan on 13-1-29.
//  Copyright (c) 2013年 AppCan. All rights reserved.
//

#import "ZXingCodeScanner.h"
#import <UniversalResultParser.h>
#import <ParsedResult.h>
#import <ResultAction.h>
#import <QRCodeReader.h>
#import "EUtility.h"
#import "EUExScanner.h"
#import "EUExBaseDefine.h"
#import "JSON.h"
@implementation ZXingCodeScanner
- (void)dealloc
{
    if (widController) {
        [widController release];
    }
    [super dealloc];
}
//打开zxing
-(void)openZXing
{
    if (!widController) {
        widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
//        widController.wantsFullScreenLayout=NO;
        QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
        NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
        [qrcodeReader release];
        widController.readers = readers;
        [readers release];
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *urlString = [mainBundle pathForResource:@"uexScanner/beep-beep" ofType:@"aiff"];
        if (urlString) {
            widController.soundToPlay =[NSURL fileURLWithPath:urlString isDirectory:NO];
        }else{
            //
        }
    }
    widController.overlayView.displayedMessage = euexObj.msg;
    [EUtility brwView:euexObj.meBrwView presentModalViewController:widController animated:YES];
//    [[UIApplication sharedApplication]setStatusBarHidden:NO];
}
-(void)openZXingScannerWithEuex:(EUExScanner *)euexObj_{
	euexObj = euexObj_;
	[self openZXing];
	
}
#pragma mark -
#pragma mark ZXingDelegateMethods
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)resultString
{
    NSString *_resultString = [NSString stringWithFormat:@"%@",resultString];
    if (resultString&&euexObj) {
//		[euexObj uexScannerWithOpId:0 dataType:1 data:resultString];
        NSString *retStr = [EUtility transferredString:[_resultString dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithCapacity:5];
        if (retStr) {
            [resultDict setObject:retStr forKey:UEX_JKCODE];
        }else {
            [resultDict setObject:@"" forKey:UEX_JKCODE];
        }
        [resultDict setObject:@"" forKey:UEX_JKTYPE];
        NSString *retJson = [resultDict JSONFragment];
        [euexObj uexScannerWithOpId:0 dataType:1 data:retJson];
        [widController dismissModalViewControllerAnimated:YES];
	}
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    [widController dismissModalViewControllerAnimated:YES];
}
@end
