//
//  Scanner.h
//  WebKitCorePlam
//
//  Created by yang fan on 11-9-21.
//  Copyright2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBarSubViewController.h"
#import "ZBarSDK.h"
#import "ScanInputViewController.h"
@class EUExScanner;
@interface BarCodeScanner : NSObject <ZBarReaderDelegate,ScanInputDelegate,ZBarSubDelegate>  {
	EUExScanner *euexObj;
	ZBarSubViewController *_reader;
    
}
-(void)openScannerWithEuex:(EUExScanner *)euexObj_;
@end
