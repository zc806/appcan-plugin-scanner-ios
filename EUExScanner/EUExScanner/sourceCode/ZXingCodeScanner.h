//
//  ZXingCodeScanner.h
//  EUExScanner
//
//  Created by AppCan on 13-1-29.
//  Copyright (c) 2013年 AppCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXingWidgetController.h"
@class UniversalResultParser;
@class ParsedResult;
@class ResultAction;
@class EUExScanner;
@interface ZXingCodeScanner : NSObject<ZXingDelegate>{
    ZXingWidgetController *widController;
	EUExScanner *euexObj;

}
-(void)openZXingScannerWithEuex:(EUExScanner *)euexObj_;

@end
