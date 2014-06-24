//
//  Grid.h
//  GameOfLife
//
//  Created by Randy on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"
@interface Grid : CCSprite
-(void)evolveStep;
-(void)countNeighbors;
-(void)updateCreatures;
@property(nonatomic,assign)int totalAlive;
@property(nonatomic, assign)int generation;

@end
