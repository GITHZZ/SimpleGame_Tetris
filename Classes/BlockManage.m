//
//  BlockManage.m
//  Tetris_3
//
//  Created by 何遵祖 on 12-5-16.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BlockManage.h"
#import "GameMainLayer.h"

@interface BlockManage(PrivateMethod) 
-(void) initWithBlockType;
-(void) setGameLayer:(CCLayer *) layer;
-(void) setBlockCouple:(int *)pNewBlockCouple;
-(int*) getBlockCouple;
@end

@implementation BlockManage

@synthesize gLayer;

//初始化所有的精灵
-(id) initWithBlockScreen:(CCLayer *) layer{
	if ((self=[super init])) {
		[self setGameLayer:layer];
		for(int i=0;i<=GAME_LINE_ROW;i++){
			for(int j=0;j<=GAME_LINE_COL;j++){
				bSprite[i][j]=[BlockSprite initWithGameSprite:BLOCK_FILENAME];
				bSprite[i][j].anchorPoint=CGPointZero;
				bSprite[i][j].position=ccp(-bSprite[i][j].contentSize.width+bSprite[i][j].contentSize.width*j+5,
										   -2*bSprite[i][j].contentSize.height+bSprite[i][j].contentSize.height*i+5);
				[gLayer addChild:bSprite[i][j] z:-1];
			}
		}
		[self initWithBlockType];//初始化方块数据
	}
	return self;
}

-(void) setGameLayer:(CCLayer *) layer{
	gLayer=(GameMainLayer*)layer;
}

- (void) getNewBlockCoupleRotate:(int) ri withType:(BlockCoupleType)tp {
	//初始化方块对
	//此处设定方块的各种数值
	BlockCouple *blockCouple=[BlockCouple initWithBlockCouple:pBlockType blockRotate:ri withType:tp];
	int *pNewBlockCouple=[blockCouple getBlockCouple];
	[self setBlockCouple:pNewBlockCouple];
	
}

-(void) initWithBlockType{
	int blockType[]={
		1,5,9,13,//I型1
		4,5,6,7,//I型2
		1,5,9,13,//I型3
		4,5,6,7,//I型4
		
		0,4,5,9,//S型1
		1,2,4,5,//S型2
		0,4,5,9,//S型1
		1,2,4,5,//S型2
		
		1,4,5,8,//Z型1
		0,1,5,6,//Z型2
		1,4,5,8,//Z型1
		0,1,5,6,//Z型2
		
		1,2,6,10,//L型1
		0,1,2,4,//L型2
		1,5,9,10,//L型3
		2,4,5,6,//L型4
		
		0,1,4,8,//J型1
		0,4,5,6,//J型2
		1,5,8,9,//J型3
		0,1,2,6,//J型4
		
		0,1,4,5,//O型1
		0,1,4,5,//O型1
		0,1,4,5,//O型1
		0,1,4,5,//O型1
		
		1,4,5,6,//T型1
		1,4,5,9,//T型2
		4,5,6,9,//T型3
		1,5,6,9,//T型4
	};
	
	//初始化pBlockType指针并指向blockType数组
	pBlockType=(int*)malloc(sizeof(blockType));
	memcpy(pBlockType,blockType,sizeof(blockType));
}

- (void) createNewBlockCouple:(CGPoint) pos blockRotate:(int) ri withType:(BlockCoupleType) tp{
	//更新方块数值
	[self getNewBlockCoupleRotate:ri withType:tp];
	
	//将方块显示到屏幕上去
	int *pNewBlockCouple=[self getBlockCouple];//获取当前方块所有数据
	int bACount=0;
	
	for(int i=pos.y;i<BLOCK_LINE_COL+pos.y;i++){
		for(int j=pos.x;j<BLOCK_LINE_ROW+pos.x;j++){
			if (bSprite[i][j].blockType==Fix_Cell) {
				bSprite[i][j].blockType=Fix_Cell;
			}else {
				bSprite[i][j].blockType=pNewBlockCouple[bACount];
			}
			
			[bSprite[i][j] screenHaveBlock:bSprite[i][j].blockType];
			bACount++;
		}
	}	
	
}

//将方块状态改为FIX_CELL
- (void) BlockStateIsFix: (CGPoint) pos{
	//用于变化状态（计划需要优化)
	for(int i=pos.y;i<BLOCK_LINE_COL+pos.y;i++){
		for(int j=pos.x;j<BLOCK_LINE_ROW+pos.x;j++){
			if (bSprite[i][j].blockType==Alive_Cell) {
				bSprite[i][j].blockType=Fix_Cell;
			}else if (bSprite[i][j].blockType==Fix_Cell) {
				bSprite[i][j].blockType=Fix_Cell;
			}else{
				bSprite[i][j].blockType=Empty_Cell;
			}
			[bSprite[i][j] screenHaveBlock:bSprite[i][j].blockType];
		}
	}

}

- (CGPoint) moveBlockCoupleorigin:(CGPoint) pos1 actural:(CGPoint) pos2
				      blockRotate:(int) ri withType:(BlockCoupleType) tp{
	for(int i=pos1.y;i<BLOCK_LINE_COL+pos1.y;i++){
		for(int j=pos1.x;j<BLOCK_LINE_ROW+pos1.x;j++){
			//判断是否过界（左边）
			if ((bSprite[i][j].blockType==Alive_Cell&&pos2.x==-1&&j<=1)
				||(bSprite[i][j].blockType==Alive_Cell&&bSprite[i][j-1].blockType==Fix_Cell)) 
			{pos2.x=0;}
			//判断是否过界（右边）
			if (bSprite[i][j].blockType==Alive_Cell&&pos2.x==1&&j>GAME_MOVING_MAX_X
				||(bSprite[i][j].blockType==Alive_Cell&&bSprite[i][j+1].blockType==Fix_Cell)) 
			{pos2.x=0;}
			//判断是否过界 (底部)
			if ((bSprite[i][j].blockType==Alive_Cell&&i<=ORIGIN_BUTTOM_POINTX)||
				(i<=ORIGIN_BUTTOM_POINTX-1)) {
				[self BlockStateIsFix:pos1];
				return ccp(0,0);
			}
			//判断是否有碰撞到其它方块
			for(int i=pos1.y;i<BLOCK_LINE_COL+pos1.y;i++){
				for(int j=pos1.x;j<BLOCK_LINE_ROW+pos1.x;j++){
					if (bSprite[i-1][j].blockType==Fix_Cell&&bSprite[i][j].blockType==Alive_Cell) {
						[self BlockStateIsFix:pos1];
						return ccp(0,0);
					}
				}
			}
			
			if (bSprite[i][j].blockType==Fix_Cell) {
				bSprite[i][j].blockType=Fix_Cell;
			}else {
				bSprite[i][j].blockType=Empty_Cell;
			}
			[bSprite[i][j] screenHaveBlock:bSprite[i][j].blockType];
		}
	}
	
	CGPoint newPos=ccpAdd(pos1, pos2);
	//判断是否能够旋转
	if (newPos.x<1) {ri=0;}
	if (newPos.y<2) {ri=0;}
	if (newPos.x>=GAME_MOVING_MAX_X||(tp==I&&newPos.x>=GAME_MOVING_MAX_X-1)) {ri=0;}
	
	//重新渲染
	[self createNewBlockCouple:newPos blockRotate:ri withType:tp];
	return newPos;
}

//设置和读取方块数据
-(void) setBlockCouple:(int *)pNewBlockCouple{
	gNewBlockCouple=pNewBlockCouple; 
}
-(int*) getBlockCouple{
	return gNewBlockCouple;
}

//得到和设置一个方块数据
-(void) setGameBlock:(CGPoint) pos withType:(blockState) by{
	int posX=pos.x;
	int posY=pos.y;
	
	bSprite[posX][posY].blockType=by;
	[bSprite[posX][posY] screenHaveBlock:bSprite[posX][posY].blockType];
}
-(BlockSprite *) getGameBlock:(CGPoint) pos{
	int posX=pos.x;
	int posY=pos.y;
	
	return bSprite[posX][posY];
}

-(void) dealloc{
	[super dealloc];
}

@end
