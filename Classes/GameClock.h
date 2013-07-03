//
//  GameClock.h
//  CCHWProject01
//
//  Created by 何遵祖 on 12-3-12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameClock : CCLayer {
	CCLabelTTF *timeLabel;
	
	int myTime;
	int minTime;
	int totalTime;
	int currentTime;
}

-(id) initWithPosition:(CGPoint) pos;

@end
