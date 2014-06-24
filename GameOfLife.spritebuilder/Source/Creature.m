//
//  Creature.m
//  GameOfLife
//
//  Created by Randy on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(instancetype)initCreature{
    //super refers to CCSprite
    self = [super initWithImageNamed:@"GameofLife/Assets/resources-phone/bubble.png"];
    
    if(self){
        self.isAlive = NO;
    }
    
    return self;
}
-(void)setIsAlive:(BOOL)newState{
    _isAlive = newState;
    self.visible = _isAlive;
}

@end
