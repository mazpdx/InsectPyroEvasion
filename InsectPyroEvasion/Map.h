//
//  Map.h
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 8/31/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grid.h"
#import "Bug.h"
#import "Rock.h"
#import "Leaf.h"


#define MAX_ROW     50
#define MAX_COL     50

typedef struct {
    short row;
    short col;
} Coord;

typedef enum {
    NORTH,
    NORTHEAST,
    EAST,
    SOUTHEAST,
    SOUTH,
    SOUTHWEST,
    WEST,
    NORTHWEST,
} Direction;

@interface Map : NSObject{
    
Bug *currentBug;
    
Grid * m_map[MAX_ROW][MAX_COL];
};

@property (nonatomic) int points;

@property (nonatomic) BOOL placeFires;

@property (nonatomic) int fireCount;

@property (nonatomic) BOOL win;


-(BOOL)isFreeRow: (int) r Col: (int) c;

-(id) init;

-(void) placeBug: (id) bug;

-(int)getRowPos;
-(int)getColPos;

-(int)getPictureRow: (int) r Col: (int) c;

-(void)tellBugMove;

-(void)mapDo;

-(void) passBugDir: (int) direction;

-(id) getObjectRow: (int) r Col: (int) c;

-(int) getDirection;

-(void) push;

-(void) moveBugDir: (int) direction;

-(void) moveRock: (Rock*) rock Dir: (int) direction Row: (int) row Col: (int) column;

-(void) dryMap;

-(void) worldFire;

-(void) layrock;

-(void) rockLineRow: (int) r Col: (int) c;

-(int) getFireCount;

-(void) removeRock;

-(int) getHunger;

-(void) makeHungry;

-(void) eat;

-(BOOL) isBugDead;

@end
