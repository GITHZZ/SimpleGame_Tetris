//
//  GameMainLayer.m
//  Tetris_2
//
//  Created by 何遵祖 on 12-5-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameMainLayer.h"

@interface GameMainLayer(PrivateMethod)
-(BOOL) initWithBlockScreen;
-(void) lineIsClear;
-(void) clearBlock:(int) row;
@end

@implementation GameMainLayer

@synthesize pos;
@synthesize blockRotate;
@synthesize isBlockMoving;
@synthesize origanInterval;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameMainLayer *layer = [GameMainLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		CCLOG(@"123");
		line=score=level=0;
		origanInterval=0.4f;
		gIsBegin=1;
		
		//添加控制层
		GameController *gcLayer=[[[GameController alloc]initWithGameLayer:self]autorelease];
		[self addChild:gcLayer z:2 tag:GAME_CONTROLLER_LAYER_TAG];
		
		manage=[[BlockManage alloc]initWithBlockScreen:self];//预加载所有的精灵
		
		//添加粒子系统
		CGSize winSize=[[CCDirector sharedDirector]winSize];
		CCParticleSystem *bgParticle=[CCParticleSystemQuad particleWithFile:@"bg_Particle.plist"];
		bgParticle.position=ccp(winSize.width/2,winSize.height/2);
		[self addChild:bgParticle z:2];
		
		//clock
		GameClock *gc=[[[GameClock alloc]initWithPosition:ccp(winSize.width-80,200)]autorelease];
		[self addChild:gc z:2];
		
		//score
		GameScoreLayer *gScore=[[GameScoreLayer alloc] initWithPosition:ccp(winSize.width-100,winSize.height-200)];
		[self addChild:gScore z:2 tag:GAME_SCORE_TAG];
	
		//menubutton
		ButtonLayer *bl=[[ButtonLayer alloc]initWithPosition:ccp(winSize.width-85,85)];
		[self addChild:bl z:2];
		
		//调用定时器
		[self blockUpdate];
		gtinterval=origanInterval;
		[self schedule:@selector(updatePosition:) interval:gtinterval];
		
		//判断是否能够移动
		isBlockMoving=0;
	}
	return self;
}

-(void) blockUpdate{
	CCNode *gcNode=[self getChildByTag:GAME_CONTROLLER_LAYER_TAG];
	GameController *gcLayer=(GameController *) gcNode;
	
	//创建新的方块组
	pos=ccp(BLOCK_BEGINING_POSX,BLOCK_BEGINING_POSY);
	blockRotate=gcLayer.gbRotate;
	
	//方块初始化操作
	if (gIsBegin) {
		blType=arc4random()%6+7;
		nextType=arc4random()%6+7;
		gIsBegin=0;
	}

    [manage createNewBlockCouple:pos blockRotate:blockRotate withType:blType];
    [manage createNewBlockCouple:ccp(17,21) blockRotate:blockRotate withType:nextType];
		
}

-(void) updatePosition:(ccTime) delta{
	CCNode *gcNode=[self getChildByTag:GAME_CONTROLLER_LAYER_TAG];
	GameController *gcLayer=(GameController *) gcNode;
	
	gtinterval=gcLayer.timeInterval;
	[self unschedule:@selector(updatePosition:)];
	[self schedule:@selector(updatePosition:) interval:gtinterval];
	
	//砖块位置
	int acturalX=gcLayer.pos.x;
	int acturalY=gcLayer.pos.y;
	
	//是否有旋转
	blockRotate=gcLayer.gbRotate;
	
	//移动砖块
	pos=[manage moveBlockCoupleorigin:pos actural:ccp(acturalX,acturalY-1)  
						  blockRotate:blockRotate withType:blType];
	
	//将gcLayer数据初始化为0
	gcLayer.gbRotate=0;
	gcLayer.pos=ccp(0,0);
	
	[self lineIsClear];
	
	if (pos.y<1) {
		blType=nextType;
		gcLayer.timeInterval=origanInterval;
		nextType=arc4random()%7+6;
		[self blockUpdate];//更新
	}
	
	//设置等级
	CCNode *sn=[self getChildByTag:GAME_SCORE_TAG];
	GameScoreLayer *gs=(GameScoreLayer *) sn;
	
	if (line>=4+level*10) {
		level++;
		[gs setgLevel:level];
		if (origanInterval>=0.1) {
			origanInterval=origanInterval-0.03;
		}
		gcLayer.timeInterval=origanInterval;
	}
	
	for(int i=0;i<=GAME_MOVING_MAX_X;i++){
		if ([manage getGameBlock:ccp(GAME_MOVING_MAX_Y,i)].blockType==Fix_Cell) {
			[self unschedule:@selector(updatePosition:)];
			[[CCDirector sharedDirector] replaceScene:[GameEndLayer scene]];
		}
	}
}

-(void) lineIsClear{
	int count=0;
	int lineCount=0;
	
	CCNode *sn=[self getChildByTag:GAME_SCORE_TAG];
	GameScoreLayer *gs=(GameScoreLayer *) sn;
	
	for(int i=0;i<GAME_LINE_ROW;i++){
		for(int j=0;j<GAME_LINE_COL;j++){
			if([manage getGameBlock:ccp(i,j)].blockType==Fix_Cell){
				count++;
				if (count==14) {
					lineCount+=2;
					[self clearBlock:i];
					
					score+=lineCount;
					line+=1;
					[gs setScore:score];
					[gs setLine:line];
					
					count=0;
				}
			}
		}
		count=0;
	}
}

-(void) clearBlock:(int) row{
	for(int i=0;i<GAME_MOVING_MAX_X;i++){
		[manage setGameBlock:ccp(row,i) withType:Empty_Cell];	
	}
	
	for(int i=row+1;i<GAME_LINE_ROW;i++){
		for(int j=0;j<GAME_MOVING_MAX_X;j++){
			[manage setGameBlock:ccp(i-1,j) 
						withType:[manage getGameBlock:ccp(i,j)].blockType];
		}
	}
}

-(void) draw{
	CGSize winSize=[[CCDirector sharedDirector]winSize];
	DrawingManager *myDrawing=[[DrawingManager alloc]init];
	
	CGRect screenRect2=CGRectMake(winSize.width-155,1,152, winSize.height-7);
	[myDrawing myDrawRect:4.0f red:0.8f green:0.3f blue:0.2f alpha:0.0f rect:screenRect2];
	
	CGRect screenRect=CGRectMake(1, 1, winSize.width-158, winSize.height-7);
	[myDrawing myDrawRect:4.0f red:0.0f green:0.0f blue:0.6f alpha:0.0f rect:screenRect];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
