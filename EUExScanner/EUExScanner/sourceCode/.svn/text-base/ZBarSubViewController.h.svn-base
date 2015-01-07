//
//  ZBarSubViewController.h
//  WebKitCorePlam
//
//  Created by yang fan on 12-4-21.
//  Copyright 2012 zywx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "ZBarOverLayView.h"

@class BarCodeScanner;
@protocol ZBarSubDelegate <NSObject>

-(void)zbarWillDismiss;

@end
@interface ZBarSubViewController : ZBarReaderViewController {
	BOOL lightOn;
	ZBarOverLayView *overLay;
	UIView *mainOverView;
	UIView *topView;
	UIView *bottomView;
	UIToolbar *toolBar;
	UILabel *tLabel;
	BarCodeScanner *euexBs;
    CGSize screenSize;
    id <ZBarSubDelegate> _sCallBack;
}
@property(assign)   id <ZBarSubDelegate> sCallBack;
@property(nonatomic,assign)BarCodeScanner *euexBs;
@property(nonatomic,retain)UIImageView * scanImageView;
@end
