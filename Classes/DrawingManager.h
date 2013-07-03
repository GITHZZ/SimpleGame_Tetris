//
//  DrawingManager.h
//  Tetris
//
//  Created by 何遵祖 on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DrawingManager : CCLayer {
}

-(void) myDrawRect:(float)lineWidth red:(float)r green:(float)b blue:(float)b alpha:(float)a 
			  rect:(CGRect)rect;

@end
