//
//  GameScoreLayer.h
//  TetrisGame
//
//  Created by 何遵祖 on 12-5-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameScoreLayer : CCLayer {

}

-(id) initWithPosition:(CGPoint) pos;

-(void) setScore:(int) score;
-(void) setLine:(int) lc;
-(void) setgLevel:(int) gl;

@end
