//
//  BlockSprite.h
//  Tetris_2
//
//  Created by 何遵祖 on 12-5-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BlockManage;

@interface BlockSprite : CCSprite {
	blockState blockType;
	BlockRunState runningState;//砖块运动状态
}

@property (readwrite) blockState blockType;

+ (id) initWithGameSprite : (NSString *) fileName;
- (void) screenHaveBlock : (BlockRunState) blockTag;

- (void) setRunningState:(BlockRunState) rs;
- (BlockRunState) getRunningState;

@end



@interface BlockCouple : CCSprite{
	int *pNewBlockCouple;
	int rotateIndex;//旋转序号，为0不旋转。
    BlockCoupleType blockCoupleType;//砖块组的种类
}


@property (readwrite) int rotateIndex;
@property (readwrite) BlockCoupleType blockCoupleType;

+(id) initWithBlockCouple:(int *) gBlockType blockRotate:(int) ri withType:(BlockCoupleType) tp;
-(id) initwithRotate:(int)ri andType:(BlockCoupleType)tp;
-(void) setNewBlockType:(int *) gBlockType;
-(int *) getBlockCouple;

@end