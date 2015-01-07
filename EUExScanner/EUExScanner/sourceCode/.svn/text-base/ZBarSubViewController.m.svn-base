    //
//  ZBarSubViewController.m
//  WebKitCorePlam
//
//  Created by yang fan on 12-4-21.
//  Copyright 2012 zywx. All rights reserved.
//

#import "ZBarSubViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanInputViewController.h"
#import "BarCodeScanner.h"
#import "EUtility.h"

#define TOP_H   90
#define BOTTOM_H  40
#define TOOL_H   55
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation ZBarSubViewController
@synthesize euexBs;
@synthesize sCallBack = _sCallBack;
-(void)initDisplayView{
	overLay = [[ZBarOverLayView alloc] init];
    int height =0;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && 768 == SCREEN_WIDTH) {
		[overLay setFrame:CGRectMake(224, 272, screenSize.width,screenSize.height-TOP_H-BOTTOM_H-TOOL_H)];
        height = TOOL_H;
	}else {
		[overLay setFrame:CGRectMake(0, TOP_H-10, screenSize.width,screenSize.height-TOP_H-BOTTOM_H-TOOL_H)];
        height = TOOL_H-15;
	}
	[overLay setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	[overLay setBackgroundColor:[UIColor clearColor]];
	toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, screenSize.width, TOOL_H)];//screenSize.height-TOOL_H
	[toolBar setBarStyle:UIBarStyleBlack];
	[toolBar setContentMode:UIViewContentModeScaleAspectFit];
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] 
									  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
									  target:nil action:nil];
	//input
//	UIBarButtonItem *inputButton = [[UIBarButtonItem alloc] initWithTitle:@"手动输入"
//																	style:UIBarButtonItemStyleBordered
//																   target:self 
//																   action:@selector(inputBtnClick:)];
//	UIBarButtonItem *lightBtn = [[UIBarButtonItem alloc] initWithTitle:@"闪光灯"
//																 style:UIBarButtonItemStyleBordered 
//																target:self
//																action:@selector(lightBtnClick:)];
    NSString * lightImgStr = [[NSBundle mainBundle] pathForResource:@"uexScanner/plugin_scanner_light_normal" ofType:@"png"];
    UIBarButtonItem *lightBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithContentsOfFile:lightImgStr] style:UIBarButtonItemStylePlain target:self action:@selector(lightBtnClick:)];
//	UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消扫描"
//																  style:UIBarButtonItemStyleBordered 
//																 target:self
//																 action:@selector(cancelBtnClick:)];
    NSString * cancelImgStr = [[NSBundle mainBundle] pathForResource:@"uexScanner/plugin_scanner_cancel_normal" ofType:@"png"];
    UIBarButtonItem * cancelBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithContentsOfFile:cancelImgStr] style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick:)];
	
	
	[toolBar setItems:[NSArray arrayWithObjects:cancelBtn,flexibleSpace,lightBtn,nil]];//flexibleSpace,inputButton,
	[flexibleSpace release];
	//[inputButton release];
	[lightBtn release];
	[cancelBtn release];

	
}

-(id)init{
	if (self = [super init]) {

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && 768 == SCREEN_WIDTH){
            screenSize = CGSizeMake(768.0, 1024.0);
        }else {
            screenSize = CGSizeMake([EUtility screenWidth], [EUtility screenHeight]);
        }
		mainOverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,screenSize.width, screenSize.height)];
		 
		[mainOverView setUserInteractionEnabled:YES];
		[mainOverView setAutoresizesSubviews:YES];
		[mainOverView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
		topView = [[UIView alloc] initWithFrame:CGRectMake(0, screenSize.height-TOOL_H, screenSize.width, TOP_H)];
		[topView setAlpha:0.7];
		tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 20)];
		[tLabel setTextAlignment:UITextAlignmentCenter];
		[tLabel setBackgroundColor:[UIColor clearColor]];
		tLabel.text = @"将二维码/条形码放入框内，即可自动扫描";
		[tLabel setTextColor:[UIColor whiteColor]];
		[topView addSubview:tLabel];
		
		[topView setBackgroundColor:[UIColor blackColor]];
		
		
		//bottom
		bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, screenSize.height-TOOL_H-BOTTOM_H,screenSize.width, BOTTOM_H)];
		[bottomView setAlpha:0.7];
		[bottomView setBackgroundColor:[UIColor blackColor]];
        
        
        //
        NSString * imagePath = [[NSBundle mainBundle]pathForResource:@"uexScanner/plugin_scanner_scanning" ofType:@"png"];
        UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
        self.scanImageView = [[UIImageView alloc]initWithImage:image];
        self.scanImageView.frame = CGRectMake(30, 95, [EUtility screenWidth]-2*30, 9);
        
		
		[self initDisplayView];
	}
	return self;
}
-(void)loadView{
	[super loadView];
	[mainOverView addSubview:topView];
	[mainOverView addSubview:bottomView];
	[mainOverView addSubview:overLay];
	[mainOverView addSubview:toolBar];
    [mainOverView addSubview:self.scanImageView];
    
}

- (void)animation
{
    
    [UIView animateWithDuration:2.0 animations:^{
        CGRect frame = self.scanImageView.frame;
        frame.origin.y += 255;
        [self.scanImageView setFrame:frame];
    } completion:^(BOOL finished) {
        //if (finished) {
            [self.scanImageView setFrame:CGRectMake(30, 95, [EUtility screenWidth]-2*30, 9)];
            [self animation];
        //}
    }];
}



-(void)viewDidLoad{
	[super viewDidLoad];
//    //注册一个通知
//    [[NSNotificationCenter defaultCenter] addObserver:euexBs selector:@selector(scannerDidDismiss) name:@"ScannerDidRemove" object:nil];
	self.cameraOverlayView = mainOverView;
    [self animation];
}
-(void)turnOffFlash{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];  
    if ([device hasTorch]) {  
        [device lockForConfiguration:nil];  
        [device setTorchMode: AVCaptureTorchModeOff];  
        [device unlockForConfiguration];  
    }  
}
-(void)turnOnFlash{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];  
    if ([device hasTorch]) {  
        [device lockForConfiguration:nil];  
        [device setTorchMode: AVCaptureTorchModeOn];  
        [device unlockForConfiguration];  
    }  
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}
-(void)inputBtnClick:(id)sender{
////   UIViewController *parent = self.parentViewController;
//// 	[parent presentModalViewController:input animated:YES];
//  //   [self dismissModalViewControllerAnimated:NO];
        [self dismissModalViewControllerAnimated:NO];
    if (_sCallBack&&[_sCallBack respondsToSelector:@selector(zbarWillDismiss)]) {
        [_sCallBack zbarWillDismiss];
    }


}

-(void)lightBtnClick:(id)sender{
	UIBarButtonItem *btn = (UIBarButtonItem *)sender;
	if (lightOn) {
        
		//[btn setTitle:@"闪光灯"];
		//关闭闪光灯
		[self turnOffFlash];
		lightOn = NO;
	} else {
		
		//[btn setTitle:@"关闭"];
		[self turnOnFlash];
		lightOn = YES;
	}
	
}
-(void)cancelBtnClick:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
} 
-(void)setVerticalFrame{
	[overLay setHidden:NO];
    [toolBar setFrame:CGRectMake(0,screenSize.height-TOOL_H, screenSize.width, TOOL_H)];
	[topView setFrame:CGRectMake(0, 0, screenSize.width, TOP_H)];
 	[bottomView setFrame:CGRectMake(0, screenSize.height-BOTTOM_H-TOOL_H,screenSize.width, BOTTOM_H)];
	[tLabel setHidden:NO];
}
-(void)setHorizontalFrame{
	[overLay setHidden:YES];
 	[topView setFrame:CGRectMake(0, 0,screenSize.height, TOP_H)];
	[toolBar setFrame:CGRectMake(0, screenSize.width-TOOL_H, screenSize.height, TOOL_H)];
	[bottomView setFrame:CGRectMake(0, screenSize.width-TOOL_H-BOTTOM_H,screenSize.height, BOTTOM_H)];
	[tLabel setHidden:YES];
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
		//[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	if (toInterfaceOrientation== UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
		//[self setVerticalFrame];
	}else {
		//[self setHorizontalFrame];
	}
}
 
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[topView release];
	[bottomView release];
	[toolBar release];
	[tLabel release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation

{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (BOOL)shouldAutorotate

{
    
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
    
}




@end
