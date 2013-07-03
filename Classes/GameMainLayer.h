//
//  GameMainLayer.h
//  Tetris_2
//
//  Created by 何遵祖 on 12-5-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BlockManage.h"
#import "GameController.h"
#import "DrawingManager.h"
#import "GameClock.h"
#import "GameScoreLayer.h"
#import "ButtonLayer.h"
#import "GameEndLayer.h"

@interface GameMainLayer : CCLayer {	
	BlockManage *manage;
	CGPoint pos;
	
	int blockRotate;
	BlockCoupleType blType;
	BlockCoupleType nextType;
	
	int isBlockMoving;
	float gtinterval;
	
	int score,line,level;
	float origanInterval;
	
	int gIsBegin;
}

@property (readwrite) CGPoint pos;
@property (readwrite) int blockRotate;
@property (readwrite) int isBlockMoving;
@property (readwrite) float origanInterval;

-(void) blockUpdate;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
