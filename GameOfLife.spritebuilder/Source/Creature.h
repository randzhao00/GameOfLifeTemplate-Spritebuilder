//
//  Creature.h
//  GameOfLife
//
//  Created by Randy on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

//stores the current state of the creature
@property(nonatomic,assign) BOOL isAlive;

//stores the amount of living neighborss
@property(nonatomic,assign)NSInteger livingNeighbors;

-(id)initCreature;

@end
