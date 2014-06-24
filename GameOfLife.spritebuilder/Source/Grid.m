//
//  Grid.m
//  GameOfLife
//
//  Created by Randy on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int grid_row = 8;
static const int grid_col = 10;
@implementation Grid
{
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}
-(void)onEnter{
    [super onEnter];
    [self setupGrid];
    //accepts touches on the grid
    self.userInteractionEnabled = YES;
    
}
-(void)setupGrid{
    //divide the grid's size by the noumber of col/rows to figure out the cight width and height of each cell
    _cellWidth = self.contentSize.width / grid_col;
    _cellHeight = self.contentSize.height / grid_row;
    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array]; //blank array
    for(int i = 0; i < grid_row; i++){
        _gridArray[i] = [NSMutableArray array];
        x=0;
    
        for(int j = 0; j< grid_col; j++){
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            //access array inside an array
            _gridArray[i][j] = creature;
            //make creature visible test
            //creature.isAlive = YES;
            x += _cellWidth;
        }
        y += _cellHeight;
    }
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    //get the Creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    //invert it's state - kill it if it's alive, bring it to life if it's dead.
    creature.isAlive = !creature.isAlive;
}
-(Creature *)creatureForTouchPosition:(CGPoint)touchPosition {
    int row_touched = (touchPosition.y)/(_cellHeight);
    int col_touched = (touchPosition.x)/(_cellWidth);
    return _gridArray[row_touched][col_touched];
}
-(void)evolveStep{
    //update each Creature's neighbor count
    [self countNeighbors];
    
    //update each Creature's state
    [self updateCreatures];
    
    //update the generation so the label's text will display the correct generation
    _generation++;
}
-(void)countNeighbors{
    // iterate through the rows
    // note that NSArray has a method 'count' that will return the number of elements in the array
    for (int i = 0; i < [_gridArray count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            // access the creature in the cell that corresponds to the current row/column
            Creature *currentCreature = _gridArray[i][j];
            
            // remember that every creature has a 'livingNeighbors' property that we created earlier
            currentCreature.livingNeighbors = 0;
            
            // now examine every cell around the current one
            
            // go through the row on top of the current cell, the row the cell is in, and the row past the current cell
            for (int x = (i-1); x <= (i+1); x++)
            {
                // go through the column to the left of the current cell, the column the cell is in, and the column to the right of the current cell
                for (int y = (j-1); y <= (j+1); y++)
                {
                    // check that the cell we're checking isn't off the screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    // skip over all cells that are off screen AND the cell that contains the creature we are currently updating
                    if (!((x == i) && (y == j)) && isIndexValid)
                    {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
            }
        }
    }
}
-(void)updateCreatures{
    int num_Alive=0;
    for(int i = 0; i < [_gridArray count]; i++){
        for(int j =0; j < [_gridArray[i] count]; j++){
            Creature *currentCreature = _gridArray[i][j];
            if(currentCreature.livingNeighbors == 3){
                currentCreature.isAlive =true;
                num_Alive++;
            }
            else{
                if(currentCreature.livingNeighbors<= 1 || currentCreature.livingNeighbors >= 4){
                    currentCreature.isAlive =false;
                }
            }
            
        }
    }
    _totalAlive = num_Alive;
}
- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= grid_row || y >= grid_col)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}
@end
