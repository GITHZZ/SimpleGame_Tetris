//
//  GameScoreLayer.m
//  TetrisGame
//
//  Created by 何遵祖 on 12-5-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScoreLayer.h"

@implementation GameScoreLayer

-(id) initWithPosition:(CGPoint) pos{
	if ((self=[super init])) {
		//score
		CCLabelTTF *scoreLabel=[CCLabelTTF labelWithString:@"Score:" fontName:@"Georgia" fontSize:30];
		scoreLabel.opacity=50;
		scoreLabel.position=ccp(pos.x,pos.y);
		[self addChild:scoreLabel];
		
		CCLabelTTF *scoreCount=[CCLabelTTF labelWithString:@"0" fontName:@"Georgia" fontSize:30];
		scoreCount.opacity=50;
		scoreCount.position=ccp(pos.x+60,pos.y);
		[self addChild:scoreCount z:2 tag:GAME_SCORE_COUNT_TAG];
		
		//line
		CCLabelTTF *LineLabel=[CCLabelTTF labelWithString:@"Line:" fontName:@"Georgia" fontSize:30];
		LineLabel.opacity=50;
		LineLabel.position=ccp(pos.x,pos.y-50);
		[self addChild:LineLabel];
		
		CCLabelTTF *lineCount=[CCLabelTTF labelWithString:@"0" fontName:@"Georgia" fontSize:30];
		lineCount.opacity=50;
		lineCount.position=ccp(pos.x+60,pos.y-50);
		[self addChild:lineCount z:2 tag:GAME_LINE_COUNT_TAG];
		
		//Level
		CCLabelTTF *levelLabel=[CCLabelTTF labelWithString:@"Level:" fontName:@"Georgia" fontSize:30];
		levelLabel.opacity=50;
		levelLabel.position=ccp(pos.x,pos.y-100);
		[self addChild:levelLabel];
		
		CCLabelTTF *levelCount=[CCLabelTTF labelWithString:@"0" fontName:@"Georgia" fontSize:30];
		levelCount.opacity=50;
		levelCount.position=ccp(pos.x+60,pos.y-100);
		[self addChild:levelCount z:2 tag:GAME_LEVEL_COUNT_TAG];
	}
	return self;
}

-(void) setScore:(int) score{
	NSString *scoreStr=[NSString stringWithFormat:@"%d",score];
	CCNode *sNode=[self getChildByTag:GAME_SCORE_COUNT_TAG];
	CCLabelTTF *scoreCount=(CCLabelTTF *) sNode;
	[scoreCount setString:scoreStr];
}

-(void) setLine:(int) lc{
	NSString *lineStr=[NSString stringWithFormat:@"%d",lc];
	CCNode *lNode=[self getChildByTag:GAME_LINE_COUNT_TAG];
	CCLabelTTF *lineCount=(CCLabelTTF *) lNode;
	[lineCount setString:lineStr];
}

-(void) setgLevel:(int) gl{
	NSString *levelStr=[NSString stringWithFormat:@"%d",gl];
	CCNode *gNode=[self getChildByTag:GAME_LEVEL_COUNT_TAG];
	CCLabelTTF *levelCount=(CCLabelTTF *) gNode;
	[levelCount setString:levelStr];
}

-(void) dealloc{
	[super dealloc];
}

@end
