//
//  Scanner.m
//  WebKitCorePlam
//
//  Created by yang fan on 11-9-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//
//#define UEX_PLATFORM_CALL_ARGS		5
//json,text,int
//#define UEX_CALLBACK_DATATYPE_TEXT	0
 #define SC_CALLBACK_DATATYPE_JSON	1
//#define UEX_CALLBACK_DATATYPE_INT	2
//const true/false
#define SC_CTRUE				1
#define SC_CFALSE				0
//success failed
#define SC_CSUCCESS			0
#define SC_CFAILED			1
//define error destribution
#define SC_ERROR_DESCRIBE_ARGS				@"参数错误"
#define SC_ERROR_DESCRIBE_FILE_EXIST		@"文件不存在"
#define SC_ERROR_DESCRIBE_FILE_FORMAT		@"文件格式错误"
#define SC_ERROR_DESCRIBE_FILE_OPEN			@"文件未打开错误"
#define SC_ERROR_DESCRIBE_FILE_SAVE			@"保存文件失败"
#define SC_ERROR_DESCRIBE_STORAGE_DEVICE	@"存储设备错误"
#define SC_ERROR_DESCRIBE_FILE_TOO_LARGE	@"文件过大"
#define SC_ERROR_DESCRIBE_DEVICE_SUPPORT	@"设备不支持错误"
#define SC_ERROR_DESCRIBE_CONFIG			@"config文件未配置"

#import "BarCodeScanner.h"
#import "EUExScanner.h"
#import "JSON.h"
#import "EUtility.h"
@implementation BarCodeScanner
-(void)transformScreen{
	//强制转屏
	UIInterfaceOrientation cOrientation = [UIApplication sharedApplication].statusBarOrientation;
	if (cOrientation==UIInterfaceOrientationLandscapeLeft||(cOrientation== UIInterfaceOrientationLandscapeRight)) {
		if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
			[[UIDevice currentDevice] performSelector:@selector(setOrientation:)
										   withObject:(id)UIInterfaceOrientationPortrait];
		}
	}
} 

-(void)showScanner{
		UIInterfaceOrientation cOrientation = [UIApplication sharedApplication].statusBarOrientation;
		if ((cOrientation==UIInterfaceOrientationLandscapeLeft)||(cOrientation==UIInterfaceOrientationLandscapeRight)) {
	//		[self transformScreen];
		} 
		_reader = [ZBarSubViewController new];
		_reader.showsCameraControls = NO;  
		_reader.showsZBarControls = NO;
		_reader.readerDelegate = self;
        _reader.sCallBack = self;
		[_reader setSupportedOrientationsMask:ZBarOrientationMaskAll];
		[_reader.scanner setSymbology: ZBAR_I25
							   config: ZBAR_CFG_ENABLE
								   to: 0];
		
		[_reader setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff];
		_reader.euexBs = self;
		[EUtility brwView:euexObj.meBrwView presentModalViewController:_reader animated:YES];
 
}
-(void)zbarWillDismiss{
    ScanInputViewController *input = [[ScanInputViewController alloc] init];
    [input setDelegate:self];
    [EUtility brwView:euexObj.meBrwView presentModalViewController:input animated:NO];
    [input release];
}
-(void)scannerDidDismiss{
  //  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ScannerDidRemove" object:nil];
    ScanInputViewController *input = [[ScanInputViewController alloc] init];
    [input setDelegate:self];
    [EUtility brwView:euexObj.meBrwView presentModalViewController:input animated:YES];
    [input release];
}

-(void)openScannerWithEuex:(EUExScanner *)euexObj_{
	euexObj = euexObj_;
	[self showScanner];
	
}
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
	NSString *resultCode = symbol.data;
	NSLog(@"resultcode = %@",resultCode);
	NSString *retStr = [EUtility transferredString:[resultCode dataUsingEncoding:NSUTF8StringEncoding]];
	NSString *resultType = symbol.typeName;
	NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithCapacity:5];
	if (resultCode) {
		[resultDict setObject:retStr forKey:UEX_JKCODE];
	}else {
		[resultDict setObject:@"" forKey:UEX_JKCODE];
	}
	if (resultType) {
		[resultDict setObject:resultType forKey:UEX_JKTYPE];
	}else {
		[resultDict setObject:@"" forKey:UEX_JKTYPE];
	}
	NSString *retJson = [resultDict JSONFragment];
	 NSLog(@"retJson = %@",retJson);
	[euexObj uexScannerWithOpId:0 dataType:SC_CALLBACK_DATATYPE_JSON data:retJson];
	
    // EXAMPLE: do something useful with the barcode image
    //UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
	
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
}
-(void)inputFinishWithResult:(NSString *)result{
	if (result) {
		NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithCapacity:5];
		if (result) {
			[resultDict setObject:result forKey:UEX_JKCODE];
		}else {
			[resultDict setObject:@"" forKey:UEX_JKCODE];
		}
			[resultDict setObject:@"" forKey:UEX_JKTYPE];
		NSString *retJson = [resultDict JSONFragment];
		NSLog(@"retJson = %@",retJson);
		[euexObj uexScannerWithOpId:0 dataType:SC_CALLBACK_DATATYPE_JSON data:retJson];
	}
}
-(void)changeToScanner{
	UIInterfaceOrientation cOrientation = [UIApplication sharedApplication].statusBarOrientation;
	if (cOrientation==UIInterfaceOrientationLandscapeLeft||(cOrientation == UIInterfaceOrientationLandscapeRight)) {
		[self transformScreen];
	} 
	if (_reader) {
		[EUtility brwView:euexObj.meBrwView presentModalViewController:_reader animated:NO];
 	}
}
-(void)dealloc{
	if (_reader) {
		[_reader release];
		_reader = nil;
	}
	[super dealloc];
}

@end
