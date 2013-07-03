//
//  ButtonSelect.m
//  Han's tower
//
//  Created by 何遵祖 on 12-3-15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonSelect.h"


@implementation ButtonSelect

-(id) init{
	if ((self=[super initWithColor:ccc4(255, 255, 255, 0)])) {
		CGSize winSize=[[CCDirector sharedDirector]winSize];
		
		CCLabelTTF *gameContinue=[CCLabelTTF labelWithString:@"continue" fontName:@"Marker Felt" fontSize:50];
		gameContinue.opacity=0;
		CCMenuItemLabel *continueLabel=[CCMenuItemLabel itemWithLabel:gameContinue target:self selector:@selector(gContinue:)];

		CCLabelTTF *reStart=[CCLabelTTF labelWithString:@"ReStart" fontName:@"Marker Felt" fontSize:50];
		reStart.opacity=0;
		CCMenuItemLabel *reStartLabel=[CCMenuItemLabel itemWithLabel:reStart target:self selector:@selector(restart:)];
									   
		CCLabelTTF *menu=[CCLabelTTF labelWithString:@"Menu" fontName:@"Marker Felt" fontSize:50];
		menu.opacity=0;
		CCMenuItemLabel *menuLabel=[CCMenuItemLabel itemWithLabel:menu target:self selector:@selector(goBackMenu:)];
		
		CCMenu *mn=[CCMenu menuWithItems:continueLabel,reStartLabel,menuLabel,nil];
		[mn alignItemsInColumns:
		 [NSNumber numberWithUnsignedInt:1],
		 [NSNumber numberWithUnsignedInt:1],
		 [NSNumber numberWithUnsignedInt:1],
		 nil];
		
		[mn alignItemsVerticallyWithPadding:25];
	
		CCFadeTo *fadeto=[CCFadeTo actionWithDuration:2.0f opacity:200];
	    CCFadeTo *fadetoZero=[CCFadeTo actionWithDuration:2.0f opacity:0];
		CCSequence *seq=[CCSequence actions:fadeto,fadetoZero,nil];
		[mn runAction:[CCRepeatForever actionWithAction:seq]];
		
		mn.position=ccp(winSize.width/2,winSize.height/2);
		[self addChild:mn];
	}
	return self;
}

-(void) gContinue:(id) sender{
	[[CCDirector sharedDirector]popScene];
}

-(void) restart:(id) sender{
	[[CCDirector sharedDirector] popScene];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:2.2f scene:[GameMainLayer scene]]];
}

-(void) goBackMenu:(id) sender{
	[[CCDirector sharedDirector] popScene];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:2.0f scene:[GameSelectLayer scene]]];
}

@end
