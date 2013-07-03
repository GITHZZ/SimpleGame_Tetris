//
//  GameClock.m
//  CCHWProject01
//
//  Created by 何遵祖 on 12-3-12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameClock.h"

@implementation GameClock

-(id) initWithPosition:(CGPoint) pos {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		myTime = 0;
		CCLabelTTF *time=[CCLabelTTF labelWithString:@"Time:" fontName:@"Georgia" fontSize:30];
		timeLabel = [CCLabelTTF labelWithString:@"0:0" fontName:@"Georgia" fontSize:30];
		timeLabel.position = ccp(pos.x, pos.y);
		timeLabel.opacity=60;
		time.position=ccp(timeLabel.position.x,timeLabel.position.y+20);
		time.opacity=60;
		timeLabel.anchorPoint = ccp(0.5f, 1.0f);
		[self addChild:time z:3];
		[self addChild:timeLabel z:3];
		[self schedule:@selector(update:) interval:1.0f];
		
	}	
	return self;
}

-(void)update:(ccTime)dt{
	totalTime += dt;
	currentTime = (int)totalTime;
	if (myTime < currentTime){
		myTime = currentTime;
		
		[timeLabel setString:[NSString stringWithFormat:@"%d:%d", myTime/60, myTime%60]];
	}
}

@end
