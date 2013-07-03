//
//  ButtonLayer.m
//  Han's tower
//
//  Created by 何遵祖 on 12-3-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonLayer.h"

@implementation ButtonLayer

-(id) initWithPosition:(CGPoint) pos{
	if ((self=[super init])) {
		pointX=pos.x;
		pointY=pos.y;
		
		CCLabelTTF *menu=[CCLabelTTF labelWithString:@"Pause" fontName:@"Marker Felt" fontSize:20];
		menu.opacity=0;
		CCFadeTo *fadeto=[CCFadeTo actionWithDuration:2.0f opacity:100];
		CCFadeTo *fadetoZero=[CCFadeTo actionWithDuration:2.0f opacity:0];
		CCSequence *seq=[CCSequence actions:fadeto,fadetoZero,nil];
		[menu runAction:[CCRepeatForever actionWithAction:seq]];
		
		CCMenuItemLabel *menuLabel=[CCMenuItemLabel itemWithLabel:menu target:self selector:@selector(gameMenu:)];
		menuLabel.rotation=25;
		menuLabel.color=ccWHITE;
		
		CCMenu *mn=[CCMenu menuWithItems:menuLabel,nil];
		mn.position=ccp(pos.x,pos.y);
		[self addChild:mn];
	}
	return self;
}

-(void) gameMenu:(id) sender{
	CCScene *scene=[CCScene node];
	[scene addChild:[ButtonSelect node]];
	[[CCDirector sharedDirector] pushScene:scene];
}

-(void) draw{
	NSUInteger num=50;
	glColor4f(0.1f,0.2f,0.3f,0.0f);
	ccDrawCircle(ccp(pointX,pointY),30.0f,0.0f,num,NO);
}

@end
