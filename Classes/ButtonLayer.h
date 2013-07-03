//
//  ButtonLayer.h
//  Han's tower
//
//  Created by 何遵祖 on 12-3-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ButtonSelect.h"

@interface ButtonLayer : CCLayer {
	float pointX;
	float pointY;
}

-(id) initWithPosition:(CGPoint) pos;

@end
