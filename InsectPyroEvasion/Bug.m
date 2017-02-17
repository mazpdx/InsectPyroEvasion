//
//  Bug.m
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 9/26/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import "Bug.h"

@implementation Bug

-(id)init{
    self = [super init];
    self.nutrition = NUTR_MAX;
    self.direction = 1;
    self.queueNum = 0;
    self.dead = false;
    return self;
    }
-(int)areYouBug{
    return self.direction;
    
}

-(void) setPosRow: (int) r Col: (int) c;{
    self.row = r;
    self.column = c;
}

-(void) tellMoveDir: (int) direction;{
    int i = 0;
    int queueposition;
    BOOL placed = false;
    queueposition = self.queueNum;
    while (!placed & (i < 10)){
        if (self->queue[queueposition] == 0){
            self->queue[queueposition] = direction;
            placed = true;
        }else{
            i++;
            if (queueposition == 9){
                queueposition = 0;
            }else{
                queueposition++;
            }
        }
    }
}

-(void) queueChange;{
    if (self->queue[self.queueNum] > 0){
        self->queue[self.queueNum] = 0;
        self.queueNum++;
        if (self.queueNum == 10){
            self.queueNum = 0;
        }
    }
}

-(BOOL) changeDirection{
    if (self.direction != self->queue[self.queueNum]){
        self.direction = self->queue[self.queueNum];
        return true;
    }else{
        return false;
    }
}

-(void) cleanQueue{
    BOOL different = false;
    while (different == false){
        if (self.direction == self->queue[self.queueNum] && self.direction != 0){
            [self queueChange];
        }else{
            different = true;
        }
    }
}

-(BOOL) needMove{
    if (self->queue[self.queueNum] != 0){
        return true;
    }else{
        return false;
    }
}

-(void) die{
  //  self.dead = true;
    
}

-(void) makeHungry{
    if (self.nutrition > 0){
        self.nutrition = self.nutrition - 1;
    }else{
        [self die];
    }
}

-(void) eat{
    self.nutrition = self.nutrition + 10;
    if (self.nutrition > NUTR_MAX){
        self.nutrition = NUTR_MAX;
    }
}



@end
