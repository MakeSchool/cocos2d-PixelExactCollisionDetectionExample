/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "MGWUPixelMaskSprite.h"

@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer {
    MGWUPixelMaskSprite *sprite;
    MGWUPixelMaskSprite *sprite2;
}

@synthesize helloWorldString, helloWorldFontName;
@synthesize helloWorldFontSize;

-(id) init
{
	if ((self = [super init]))
	{
		CCLOG(@"%@ init", NSStringFromClass([self class]));
				
		sprite = [MGWUPixelMaskSprite spriteWithFile:@"ship.png"];
		sprite.position = ccp(20, 50);
		[self addChild:sprite];
        
        sprite2 = [MGWUPixelMaskSprite spriteWithFile:@"ship.png"];
		sprite2.position = ccp(300, 40);
		[self addChild:sprite2];
		
		id moveRight = [CCMoveTo actionWithDuration:2.0f position:sprite2.position];
		[sprite runAction:moveRight];
        
        id moveLeft = [CCMoveTo actionWithDuration:2.0f position:sprite.position];
		[sprite2 runAction:moveLeft];
        
        [self scheduleUpdate];
	}

	return self;
}

- (void)update:(ccTime)delta {
    CGPoint pointA = CGPointZero;
    CGPoint pointB = CGPointZero;
    
    if ([sprite pixelMaskIntersectsNode:sprite2 collisionPointBodyA:&pointA collisionPointBodyB:&pointB]) {
        [sprite stopAllActions];
        [sprite2 stopAllActions];
        
        CCSprite *collisionMarker = [CCSprite spriteWithFile:@"cross.png"];
        [sprite addChild:collisionMarker];
        collisionMarker.position = pointA;
        
        [self unscheduleUpdate];
    }
}

@end
