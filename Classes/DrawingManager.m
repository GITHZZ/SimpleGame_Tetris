//
//  DrawingManager.m
//  Tetris
//
//  Created by 何遵祖 on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DrawingManager.h"

@interface DrawingManager(PrivateMethods)
-(void) drawRect:(CGRect) rect;
@end

@implementation DrawingManager

-(void) drawRect:(CGRect) rect{
	CGPoint pos1,pos2,pos3,pos4;
	
	pos1=ccp(rect.origin.x,rect.origin.y);
	pos2=ccp(rect.origin.x,rect.origin.y+rect.size.height);
	pos3=ccp(rect.origin.x+rect.size.width,rect.origin.y+rect.size.height);
	pos4=ccp(rect.origin.x+rect.size.width,rect.origin.y);
	
	ccDrawLine(pos1, pos2);
	ccDrawLine(pos2, pos3);
	ccDrawLine(pos3, pos4);
	ccDrawLine(pos4, pos1);
}

-(void) myDrawRect:(float)lineWidth red:(float)r green:(float)g blue:(float)b 
			 alpha:(float)a rect:(CGRect)rect{
	glLineWidth(lineWidth);
	glColor4f(r,g,b,a);
	CGRect screenRect=rect;
	[self drawRect:screenRect];
}

@end
