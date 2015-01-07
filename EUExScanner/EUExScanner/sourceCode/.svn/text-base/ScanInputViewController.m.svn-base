    //
//  ScanInputViewController.m
//  WebKitCorePlam
//
//  Created by yang fan on 12-4-20.
//  Copyright 2012 zywx. All rights reserved.
//

#import "ScanInputViewController.h"
#import "EUtility.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation ScanInputViewController
@synthesize delegate = _delegate;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

 
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	//[self.view setBackgroundColor:[UIColor blackColor]];

}
-(void)viewDidLoad{
    [super viewDidLoad];
    float y_pos = [EUtility screenHeight]/4;
	UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10,y_pos-40, 100, 20)];
	[lb setText:@"请输入条码:"];
	[lb setTextColor:[UIColor whiteColor]];
	[lb setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:lb];
	[lb release];
	
    
	
	UIButton *affirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[affirmBtn setFrame:CGRectMake([EUtility screenWidth]-103, y_pos, 98, 34)];
   // UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"uexScanner/plugin_scan_confirm" ofType:@"png"]];
	//[affirmBtn setImage:image forState:UIControlStateNormal];
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *imagePath = [mainBundle pathForResource:@"uexScanner/plugin_scan_confirm" ofType:@"png"];
    [affirmBtn setBackgroundImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
	[affirmBtn addTarget:self action:@selector(affirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:affirmBtn];
    
	UIToolbar *toolBar = [[UIToolbar alloc] init];
	if ([EUtility isIpad] && 768 == SCREEN_WIDTH) {
		//关于ipad，横屏键盘高度是352，竖屏键盘高度是264
		[toolBar setFrame:CGRectMake(0, [EUtility screenHeight]-264-50, [EUtility screenWidth],50)];
	}else {
		//iphone竖屏键盘高度是216
		[toolBar setFrame:CGRectMake(0,  [EUtility screenHeight]-216-50, [EUtility screenWidth],50)];
	}
    
	[toolBar setBarStyle:UIBarStyleBlack];
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] 
									  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
									  target:nil action:nil];
	//input
	UIBarButtonItem *scanBtn = [[UIBarButtonItem alloc] initWithTitle:@"扫描切换" 
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self 
                                                               action:@selector(scanBtnClick:)];
	UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" 
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self 
                                                                action:@selector(closeBtnClick:)];	
	[toolBar setItems:[NSArray arrayWithObjects:scanBtn,flexibleSpace,closeBtn,nil]];
	[flexibleSpace release];
	[scanBtn release];
	[closeBtn release];
	[self.view addSubview:toolBar];
	[toolBar release];

    inputText = [[UITextField alloc] initWithFrame:CGRectMake(5,y_pos, [EUtility screenWidth]-108, 34)];
	[inputText setKeyboardType:UIKeyboardTypeNumberPad];
	[inputText setFont:[UIFont systemFontOfSize:20.0]];
	[inputText setBorderStyle:UITextBorderStyleRoundedRect];
        [inputText setBackgroundColor:[UIColor whiteColor]];
 
   [inputText becomeFirstResponder];
  
 	[inputText setKeyboardAppearance:UIKeyboardAppearanceAlert];
	[self.view addSubview:inputText];
}
-(void)scanBtnClick:(id)sender{
	[self dismissModalViewControllerAnimated:NO];
	if (_delegate&&[_delegate respondsToSelector:@selector(changeToScanner)]) {
		[_delegate changeToScanner];
	}
	
}
-(void)closeBtnClick:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
}
-(void)affirmBtnClick:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
	NSString *resText = [inputText text];
	if (resText&&[resText length]>0) {
		if (_delegate&&[_delegate respondsToSelector:@selector(inputFinishWithResult:)]) {
			[_delegate inputFinishWithResult:resText];
		}
	}

}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
}
 
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [super dealloc];
	[inputText release];
}


@end
