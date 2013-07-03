//
//  GameController.m
//  Tetris_3
//
//  Created by 何遵祖 on 12-5-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"
@implementation GameController

@synthesize pos;
@synthesize gbRotate;
@synthesize timeInterval;

-(id) initWithGameLayer:(CCLayer *) layer{
	if ((self=[super init])) {
		[self setLayer:layer];
		timeInterval=gLayer.origanInterval;
		gbRotate=0;
		self.isKeyboardEnabled=YES;
	}
	return self;
}

-(void) setLayer:(CCLayer *) ly{
	gLayer=(GameMainLayer*)ly;
}

-(BOOL) ccKeyDown:(NSEvent *)event{
	NSString *character=[event characters];
	unichar keyCode=[character characterAtIndex:0];
	
	if (keyCode==27) {
		//退出键
	}else if (keyCode==NSDownArrowFunctionKey) {
		timeInterval=0.01f;
	}else if (keyCode==NSLeftArrowFunctionKey) {
		pos.x=-1;
	}else if (keyCode==NSRightArrowFunctionKey){
		pos.x=1;
	}else if (keyCode==32) {
		gbRotate=1;
	}
	
	return YES;
}

-(BOOL) ccKeyUp:(NSEvent *)event{
	return YES;
}

-(void) dealloc{
	[super dealloc];
}

@end
