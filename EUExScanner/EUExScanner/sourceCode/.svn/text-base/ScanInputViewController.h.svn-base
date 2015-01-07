//
//  ScanInputViewController.h
//  WebKitCorePlam
//
//  Created by yang fan on 12-4-20.
//  Copyright 2012 zywx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScanInputDelegate <NSObject>

-(void)inputFinishWithResult:(NSString *)result;
-(void)changeToScanner;

@end


@interface ScanInputViewController : UIViewController {

	id<ScanInputDelegate> _delegate;
	UITextField *inputText;
}
@property(assign)id<ScanInputDelegate> delegate;
@end
