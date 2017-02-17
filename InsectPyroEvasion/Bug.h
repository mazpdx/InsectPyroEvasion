//
//  Bug.h
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 9/26/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Largeobject.h"

#define NUTR_MAX  30

@interface Bug : Largeobject{
    
int queue[10];
    

};

@property (nonatomic) int column;
@property (nonatomic) int row;
@property (nonatomic) int direction;
@property (nonatomic) int nutrition;
@property (nonatomic) int queueNum;
@property (nonatomic) BOOL layRock;
@property (nonatomic) BOOL dead;



-(id) init;

-(int)areYouBug;

-(void)setPosRow: (int) r Col: (int) c;

-(void) tellMoveDir: (int) direction;

-(void)queueChange;

-(BOOL) changeDirection;

-(void) cleanQueue;

-(BOOL) needMove;

-(void) die;

-(void) makeHungry;

-(void) eat;


@end
