//
//  BlockManage.h
//  Tetris_3
//
//  Created by 何遵祖 on 12-5-16.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BlockSprite.h"

@class GameMainLayer;

@interface BlockManage : NSObject {
	BlockSprite *bSprite[GAME_LINE_ROW][GAME_LINE_COL];
	int *pBlockType;
	int *gNewBlockCouple;
	GameMainLayer *gLayer;
}

@property (assign,nonatomic,readwrite) GameMainLayer *gLayer;

- (id) initWithBlockScreen:(CCLayer *) layer;

- (void) createNewBlockCouple:(CGPoint) pos blockRotate:(int) ri withType:(BlockCoupleType) tp;
- (CGPoint) moveBlockCoupleorigin:(CGPoint) pos1 actural:(CGPoint) pos2
				   blockRotate:(int) ri withType:(BlockCoupleType) tp;
- (void) setGameBlock:(CGPoint) pos withType:(blockState) by;
- (BlockSprite *) getGameBlock:(CGPoint) pos;

@end
