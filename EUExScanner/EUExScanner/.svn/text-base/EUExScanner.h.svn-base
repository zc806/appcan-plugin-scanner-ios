//
//  EUExScanner.h
//  webKitCorePalm
//
//  Created by AppCan on 11-9-7.
//  Copyright 2011 AppCan. All rights reserved.
//
#import "EUExBase.h"
@class BarCodeScanner;
@class ZXingCodeScanner;
#define UEX_JKCODE						  @"code"
#define UEX_JKTYPE						  @"type"

@interface EUExScanner : EUExBase {
	BarCodeScanner *scannerObj;
    ZXingCodeScanner *xingScannerObj;
    NSString *msg;
}
@property(nonatomic,retain)  NSString *msg;
-(void)uexScannerWithOpId:(int)inOpId dataType:(int)inDataType data:(NSString *)inData;
@end
