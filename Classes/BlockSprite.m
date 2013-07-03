//
//  BlockSprite.m
//  Tetris_2
//
//  Created by 何遵祖 on 12-5-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BlockSprite.h"
#import "BlockManage.h"

@interface BlockSprite(PrivateMethod)
- (id) initWithSprite:(NSString *) fileName;
@end

@implementation BlockSprite

@synthesize blockType;

+ (id) initWithGameSprite : (NSString *) fileName{
	return [[self alloc]initWithSprite:fileName];
}

- (id) initWithSprite : (NSString *) fileName{
	if ((self=[super initWithFile:fileName])) {
		self.blockType=Empty_Cell;//不显示标志为Empty_Cell;
		[self screenHaveBlock:self.blockType];
	}
	return self;
}

- (void) screenHaveBlock : (BlockRunState) blockTag{
	if (blockTag==Alive_Cell) 	{
		self.opacity=200;
		[self setRunningState:Cell_Falling];
	}
	else if(blockTag==Empty_Cell){
		self.opacity=0;
		[self setRunningState:Cell_Static];
	}
	else if(blockTag==Fix_Cell){
		self.color=ccGREEN;
		self.opacity=200;
		[self setRunningState:Cell_Static];
	}
}

//设置和读取运动状态
- (void) setRunningState:(BlockRunState) rs{
	runningState=rs;
}
- (BlockRunState) getRunningState{
	return runningState;
}

- (void) dealloc{
	[super dealloc];
}

@end



@implementation BlockCouple

@synthesize rotateIndex;
@synthesize blockCoupleType;

-(id) initwithRotate:(int)ri andType:(BlockCoupleType)tp{
	if ((self=[super init])) {
		static int rotateCount=0;
		rotateCount+=ri;
		rotateIndex=rotateCount;
		blockCoupleType=tp;
	}
	return self;
}

+(id) initWithBlockCouple:(int *) gBlockType blockRotate:(int) ri withType:(BlockCoupleType) tp{
	
	BlockCouple *blockCouple=[[BlockCouple alloc]initwithRotate:ri andType:tp];
    [blockCouple setNewBlockType:gBlockType];
	return blockCouple;
}

-(void) setNewBlockType:(int *) gBlockType{
	int newBlockCouple[BLOCK_LINE_ROW][BLOCK_LINE_COL];
	
	//将数组初始化均为Empty_Cell
	for(int i=0;i<BLOCK_LINE_COL;i++){
		for(int j=0;j<BLOCK_LINE_ROW;j++){
			newBlockCouple[i][j]=Empty_Cell;
		}
	}
	
	int blockCount=((blockCoupleType-6)*4)+rotateIndex%4;//此处决定了旋转和砖块类型

	//创建一个方块组
	for(int i=4*blockCount;i<4+4*blockCount;i++){
		int posX=gBlockType[i]/4;
		int posY=gBlockType[i]%4;
		
		newBlockCouple[posX][posY]=Alive_Cell;
	}
		
	pNewBlockCouple=(int *) malloc(sizeof(newBlockCouple));
	memcpy(pNewBlockCouple,newBlockCouple,sizeof(newBlockCouple));
}

-(int *) getBlockCouple{
	return pNewBlockCouple;
}

-(void) dealloc{
	[super dealloc];
}

@end
