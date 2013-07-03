//
//  GameSelectLayer.m
//  TetrisGame
//
//  Created by 何遵祖 on 12-5-25.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameSelectLayer.h"


@implementation GameSelectLayer

+(CCScene *) scene{
	CCScene *sc=[CCScene node];
	
	GameSelectLayer *gs=[GameSelectLayer node];
	
	[sc addChild:gs];
	
	return sc;
}

-(id) init{
	if ((self=[super init])) {
		//添加粒子系统
		CGSize winSize=[[CCDirector sharedDirector]winSize];
		CCParticleSystem *bgParticle=[CCParticleSystemQuad particleWithFile:@"bg_Particle.plist"];
		bgParticle.position=ccp(winSize.width/2,winSize.height/2);
		[self addChild:bgParticle z:2];
		
		//添加字体
		CCLabelTTF *title=[CCLabelTTF labelWithString:@"Tetris" fontName:@"Georgia" fontSize:75];
		title.opacity=70;
		title.position=ccp(140,winSize.height-120);
		title.rotation=-40;
		title.color=ccBLUE;
		[self addChild:title z:2];
		
		//添加按钮
		CCLabelTTF *playbtn=[CCLabelTTF labelWithString:@"Play" fontName:@"Georgia" fontSize:50];
		playbtn.opacity=0;
		CCFadeTo *fadeto=[CCFadeTo actionWithDuration:2.0f opacity:80];
		CCFadeTo *fadetoZero=[CCFadeTo actionWithDuration:2.0f opacity:0];
		CCSequence *seq=[CCSequence actions:fadeto,fadetoZero,nil];
		[playbtn runAction:[CCRepeatForever actionWithAction:seq]];
		CCMenuItem *gameStart=[CCMenuItemLabel itemWithLabel:playbtn
													  target:self 
													selector:@selector(gameStart:)];
		
		
		CCMenu *menu=[CCMenu menuWithItems:gameStart,nil];
		menu.position=ccp(winSize.width-150,130);
		[self addChild:menu z:2];
		
		//添加背景音乐
		//[[SimpleAudioEngine sharedEngine]playBackgroundMusic:BACKGROUND_MUSIC_FILENAME loop:YES];
	}
	return self;
}

-(void) gameStart:(id) sender{
	[[CCDirector sharedDirector]replaceScene:[CCTransitionRotoZoom transitionWithDuration:2.0f scene:[GameMainLayer scene]]];
}

-(void) draw{
	CGSize winSize=[[CCDirector sharedDirector]winSize];
	DrawingManager *myDrawing=[[DrawingManager alloc]init];
	
	CGRect screenRect=CGRectMake(1, 1, winSize.width-2, winSize.height-6);
	[myDrawing myDrawRect:6.0f red:0.5f green:0.3f blue:1.0f alpha:0.5f rect:screenRect];
}

-(void) dealloc{
	[super dealloc];
}

@end
