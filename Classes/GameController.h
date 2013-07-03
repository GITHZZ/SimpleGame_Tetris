//
//  GameController.h
//  Tetris_3
//
//  Created by 何遵祖 on 12-5-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameMainLayer.h"

//游戏控制层
@interface GameController : CCLayer {
	GameMainLayer *gLayer;
	CGPoint pos;
	
	int gbRotate;
	float timeInterval;
}

@property (readwrite) CGPoint pos;
@property (readwrite) int gbRotate;
@property (readwrite) float timeInterval;

-(void) setLayer:(CCLayer *) ly;
-(id) initWithGameLayer:(CCLayer *) layer;

@end
