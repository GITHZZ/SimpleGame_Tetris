//
//  GameEndLayer.m
//  TetrisGame
//
//  Created by 何遵祖 on 12-5-25.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameEndLayer.h"
#import "GameMainLayer.h"

@implementation GameEndLayer

+(CCScene *) scene{
	CCScene *sc=[CCScene node];
	
	GameEndLayer *ge=[GameEndLayer node];
	
	[sc addChild:ge];
	
	return sc;
}

-(id) init{
	if ((self=[super init])) {
		CGSize winSize=[[CCDirector sharedDirector]winSize];
		
		CCLabelTTF *gameEnd=[CCLabelTTF labelWithString:@"GAME OVER!" fontName:@"Georgia" fontSize:50];
		gameEnd.position=ccp(winSize.width/2,winSize.height-200);
		[self addChild:gameEnd];
		
		CCLabelTTF *reStart=[CCLabelTTF labelWithString:@"ReStart" fontName:@"Marker Felt" fontSize:50];
		CCMenuItemLabel *reStartLabel=[CCMenuItemLabel itemWithLabel:reStart target:self selector:@selector(restart:)];
		
		CCLabelTTF *menu=[CCLabelTTF labelWithString:@"Menu" fontName:@"Marker Felt" fontSize:50];
		CCMenuItemLabel *menuLabel=[CCMenuItemLabel itemWithLabel:menu target:self selector:@selector(goBackMenu:)];
		
		CCMenu *mn=[CCMenu menuWithItems:reStartLabel,menuLabel,nil];
		[mn alignItemsInColumns:
		 [NSNumber numberWithUnsignedInt:1],
		 [NSNumber numberWithUnsignedInt:1],
		 nil];
		
		[mn alignItemsVerticallyWithPadding:25];
		
		mn.position=ccp(winSize.width/2,250);
		
		CCFadeTo *fadeto=[CCFadeTo actionWithDuration:2.0f opacity:200];
		CCFadeTo *fadetoZero=[CCFadeTo actionWithDuration:2.0f opacity:0];
		CCSequence *seq=[CCSequence actions:fadeto,fadetoZero,nil];
		[mn runAction:[CCRepeatForever actionWithAction:seq]];
		
		[self addChild:mn];
		
	}
	return self;
}

-(void) restart:(id) sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:2.2f scene:[GameMainLayer scene]]];
}

-(void) goBackMenu:(id) sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:2.0f scene:[GameSelectLayer scene]]];
}

@end
