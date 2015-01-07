//
//  ZBarOverLayView.m
//  WebKitCorePlam
//
//  Created by yang fan on 12-4-20.
//  Copyright 2012 zywx. All rights reserved.
//

#import "ZBarOverLayView.h"
#import "EUtility.h"

@implementation ZBarOverLayView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		//top
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
 
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:0 green:1 blue:0 alpha:1] CGColor]);
	  
	CGContextSetLineWidth(ctx,2.0);
		CGPoint strokeSegments[] =  
		{  
			CGPointMake(30.0, 40.0),  
			CGPointMake(30.0, 20.0), 
			CGPointMake(30.0, 20.0),
			CGPointMake(50.0, 20.0), 
			
			CGPointMake(270.0, 20.0),  
			CGPointMake(290.0, 20.0),  
			CGPointMake(290.0, 20.0), 
			CGPointMake(290.0, 40.0),
			
			CGPointMake(290.0, 260.0),  
			CGPointMake(290.0, 280.0), 
			CGPointMake(290.0, 280.0), 
			CGPointMake(270.0, 280.0), 
			
			CGPointMake(50.0, 280.0),  
			CGPointMake(30.0, 280.0), 
			CGPointMake(30.0, 280.0), 
			CGPointMake(30.0, 260.0),
		};  
		CGContextStrokeLineSegments(ctx, strokeSegments, sizeof(strokeSegments)/sizeof(strokeSegments[0])); 
	//draw redline
	// Drawing lines with a white stroke color  
	CGContextSetRGBStrokeColor(ctx, 1.0, 0, 0, 1.0);  
	CGContextSetLineWidth(ctx, 1.0);
	// Draw a single line from left to right  
	CGContextMoveToPoint(ctx, 30.0, 150.0);  
	CGContextAddLineToPoint(ctx, 290.0, 150.0);  
	CGContextStrokePath(ctx);  
}
 

- (void)dealloc {
    [super dealloc];
}


@end
