//
//  EUExScanner.m
//  webKitCorePalm
//
//  Created by AppCan on 11-9-7.
//  Copyright 2011 AppCan. All rights reserved.
//

#import "EUExScanner.h"
#import "EUtility.h"
#import "BarCodeScanner.h"
#import "ZXingCodeScanner.h"
#import "QRCodeGenerator.h"
#import "NKDEAN13Barcode.h"
#import "NKDEAN8Barcode.h"
#import "NKDCode39Barcode.h"
#import "NKDCode128Barcode.h"
#import "UIImage-NKDBarcode.h"

#define IsIOS6OrLower ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)

@implementation EUExScanner
@synthesize msg;

-(id)initWithBrwView:(EBrowserView *) eInBrwView{
	if (self = [super initWithBrwView:eInBrwView]) {
	}
	return self;
}

-(void)dealloc{
	if (scannerObj) {
		[scannerObj release];
		scannerObj = nil;
	}
    if (xingScannerObj) {
        [xingScannerObj release];
        xingScannerObj = nil;
    }
    if (self.msg) {
        self.msg = nil;
    }
	[super dealloc];
}

-(void)open:(NSMutableArray *)inArguments {
    if (!IsIOS6OrLower) {
        NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        // This status is normally not visible—the AVCaptureDevice class methods for discovering devices do not return devices the user is restricted from accessing.
        if(authStatus ==AVAuthorizationStatusRestricted){
            NSLog(@"Restricted");
        }else if(authStatus == AVAuthorizationStatusDenied){
            // The user has explicitly denied permission for media capture.
            //应该是这个，如果不允许的话
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请在设备的\"设置-隐私-相机\"中允许访问相机。"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }
        else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
            // The user has explicitly granted permission for media capture, or explicit user permission is not necessary for the media type in question.
        }else if(authStatus == AVAuthorizationStatusNotDetermined){
            // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if(granted){
                    //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                    NSString *typeStr = nil;
                    if ([inArguments count]>0) {
                        typeStr = [inArguments objectAtIndex:0];
                    }else{
                        
                    }
                    if ([typeStr isEqualToString:@"ZXing"]) {
                        if ([inArguments count] == 2) {
                            self.msg = [NSString stringWithFormat:@"%@",[inArguments objectAtIndex:1]];
                        }
                        if (!xingScannerObj) {
                            xingScannerObj = [[ZXingCodeScanner alloc] init];
                        }
                        [xingScannerObj openZXingScannerWithEuex:self];
                    }else{
                        //scanner 操作
                        if (!scannerObj) {
                            scannerObj = [[BarCodeScanner alloc] init];
                        }
                        [scannerObj openScannerWithEuex:self];
                    }
                    return;
                }
                else {
                    //
                }
            }];
        }else {
            //
        }
    }
    NSString *typeStr = nil;
    if ([inArguments count]>0) {
        typeStr = [inArguments objectAtIndex:0];
    }else{
        
    }
    if ([typeStr isEqualToString:@"ZXing"]) {
        if ([inArguments count] == 2) {
            self.msg = [NSString stringWithFormat:@"%@",[inArguments objectAtIndex:1]];
        }
        if (!xingScannerObj) {
            xingScannerObj = [[ZXingCodeScanner alloc] init];
        }
        [xingScannerObj openZXingScannerWithEuex:self];
    }else{
        //scanner 操作
        if (!scannerObj) {
            scannerObj = [[BarCodeScanner alloc] init];
        }
        [scannerObj openScannerWithEuex:self];
    }
}

-(void)createBarCode:(NSMutableArray *)array{
    if ([array isKindOfClass:[NSMutableArray class]] && [array count] == 5) {
        NSString *str = [array objectAtIndex:0];
//        CGFloat w = [[array objectAtIndex:1] floatValue];
//        CGFloat h = [[array objectAtIndex:2] floatValue];
        BOOL isPrintsCaption = [[array objectAtIndex:3] boolValue];
        NSInteger NKD_code = [[array objectAtIndex:4] boolValue];
        if (str) {
            NKDBarcode *code = Nil;
            if (0 == NKD_code) {
                //EAN_8
                code = [[NKDEAN8Barcode alloc] initWithContent:str printsCaption:isPrintsCaption];
            }else if (1 == NKD_code){
                //EAN_13
                code = [[NKDEAN8Barcode alloc] initWithContent:str printsCaption:isPrintsCaption];
            }else if (2 == NKD_code){
                //CODE_128
                code = [[NKDEAN8Barcode alloc] initWithContent:str printsCaption:isPrintsCaption];
            }else if (3 == NKD_code){
                //CODE_39
                code = [[NKDEAN8Barcode alloc] initWithContent:str printsCaption:isPrintsCaption];
            }else if (4 == NKD_code){
                //CODE_93
                return;
            }else if (5 == NKD_code){
                //ITF
                return;
            }else{
                return;
            }
            UIImage *image = [UIImage imageFromBarcode:code];
            [code release];
            if (image) {
                NSString *wgtPath = [super absPath:@"wgt://"];
                NSString *photoPath = [wgtPath stringByAppendingPathComponent:@"scanner"];
                NSFileManager *filemag = [NSFileManager defaultManager];
                if (![filemag fileExistsAtPath:photoPath]) {
                    [filemag createDirectoryAtPath:photoPath withIntermediateDirectories:YES attributes:nil error:nil];
                }
                
                NSDate *data = [NSDate dateWithTimeIntervalSinceNow:0];
                NSTimeInterval a = [data timeIntervalSince1970];
                NSString *timeString = [NSString stringWithFormat:@"/scanner%.d.png", (NSInteger)a];
                photoPath = [photoPath stringByAppendingString:timeString];
                
                NSData *imageData = UIImagePNGRepresentation(image);
                BOOL success = [imageData writeToFile:photoPath atomically:YES];
                
                if (success) {
                    [self jsSuccessWithName:@"uexScanner.cbCreateBarCode" opId:0 dataType:0 strData:photoPath];
                } else {
                    [self jsSuccessWithName:@"uexScanner.cbCreateBarCode" opId:0 dataType:0 strData:@""];
                }
            }
        }
    }
}

-(void)twoDimensionCode:(NSMutableArray *)array{
    if ([array isKindOfClass:[NSMutableArray class]] && [array count] == 3) {
        NSString *str = [array objectAtIndex:0];
        CGFloat w = [[array objectAtIndex:1] floatValue];
        UIImage *image = [QRCodeGenerator qrImageForString:str imageSize:w];
        if (image) {
            NSString *wgtPath = [super absPath:@"wgt://"];
            NSString *photoPath = [wgtPath stringByAppendingPathComponent:@"scanner"];
            NSFileManager *filemag = [NSFileManager defaultManager];
            if (![filemag fileExistsAtPath:photoPath]) {
                [filemag createDirectoryAtPath:photoPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            
            NSDate *data = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval a = [data timeIntervalSince1970];
            NSString *timeString = [NSString stringWithFormat:@"/scanner%.d.png", (NSInteger)a];
            photoPath = [photoPath stringByAppendingString:timeString];
            
            NSData *imageData = UIImagePNGRepresentation(image);
            BOOL success = [imageData writeToFile:photoPath atomically:YES];
            
            if (success) {
                [self jsSuccessWithName:@"uexScanner.cbTwoDimensionCode" opId:0 dataType:0 strData:photoPath];
            } else {
                [self jsSuccessWithName:@"uexScanner.cbTwoDimensionCode" opId:0 dataType:0 strData:@""];
            }
        }
    }
}

-(void)uexScannerWithOpId:(int)inOpId dataType:(int)inDataType data:(NSString *)inData{
    if (inData) {
		[self jsSuccessWithName:@"uexScanner.cbOpen" opId:inOpId dataType:inDataType strData:inData];
	}
}

-(void)clean{
	if (scannerObj) {
		[scannerObj release];
		scannerObj = nil;
	}
}

@end
