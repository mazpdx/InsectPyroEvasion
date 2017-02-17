//
//  Map.m
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 8/31/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import "Map.h"
#include <stdlib.h>

@implementation Map

-(id) init{
    self = [super init];
    int r;
    int c;
    int i;
    int q;
    for (r = 0; r < MAX_ROW; r++){
        for (c = 0; c < MAX_COL; c++){
            m_map[r][c] = [[Grid alloc] init];
        }
    }
    currentBug = [[Bug alloc] init];
    self.points = 0;
    self.placeFires = true;
    self.win = false;
    q = ((arc4random() % 10) + 5);
    for (i=0; i < q; i++){
        r = (arc4random() % (MAX_ROW - 10));
        c = (arc4random() % (MAX_COL - 10));
        [self rockLineRow: (r) Col: (c)];
    }
    [self placeBug: (currentBug)];
    return self;
}

-(BOOL) isFreeRow: (int) r Col: (int) c;{
    if (m_map[r][c].largeObject == nil){
        return true;
    }else{
        return false;
    
    }
}

-(void) placeBug: (id) bug;{
    //Places bug on the map at beginning of game.
    int r;
    int c;
    BOOL placed = false;
    while (!placed){
        r = (arc4random() % (MAX_ROW - 6)) + 3;
        c = (arc4random() % (MAX_COL - 6)) + 3;
        if ([self isFreeRow: r Col: c]){
            placed = true;
            [m_map[r][c] addObject: bug];
            [bug setPosRow: r Col: c];
        }
    }
    
}

-(int)getRowPos{
    //Returns bug position for display purposes.
    return currentBug.row;
}

-(int)getColPos{
    //Returns bug column for display purposes.
    return currentBug.column;
}

-(int)getPictureRow: (int) r Col: (int) c;{
    int direction;
    int rocktype;
    direction = [m_map[r][c].largeObject areYouBug];
    rocktype = [m_map[r][c].largeObject areYouRock];
    if (m_map[r][c].onFire == true){
        return 40;
    }else if (m_map[r][c].largeObject == nil && m_map[r][c].smallObject == nil) {
        if (m_map[r][c].moisture < 10) {
            return 1;
        } else if (m_map[r][c].moisture < 20) {
            return 2;
        } else if (m_map[r][c].moisture < 30) {
            return 3;
        } else if (m_map[r][c].moisture < 40) {
            return 4;
        } else {
            return 5;
        }
    } else if (direction != 0) {
        if (currentBug.dead == false){
            return ((floor(m_map[r][c].moisture /10) + 1) * 5 ) + direction;
        }else{
            return (floor(m_map[r][c].moisture / 10) + 50);
        }
    } else if (rocktype == 1){
        return (floor(m_map[r][c].moisture/10) + 30);
    } else if (rocktype == 2){
        return (floor(m_map[r][c].moisture/10) + 35);
    } else if ([m_map[r][c].smallObject areYouLeaf] == true){
        return (floor(m_map[r][c].moisture/10) + 45);
    }
return 0;
}

-(void) tellBugMove{
    BOOL changed;
    changed = false;
    if ([currentBug needMove] == true){
        changed = [currentBug changeDirection];
        if ((currentBug.direction == 1 && currentBug.row == 0) || (currentBug.direction == 2 && currentBug.column == (MAX_COL - 1)) || (currentBug.direction == 3 && currentBug.row == (MAX_ROW - 1)) || (currentBug.direction == 4 && currentBug.column == 0)){
            [currentBug queueChange];
            [currentBug cleanQueue];
                
        }else{
            if (changed == true && ((currentBug.direction == 1 && [m_map[currentBug.row - 1][currentBug.column].smallObject areYouLeaf] == true) || (currentBug.direction == 2 && [m_map[currentBug.row][currentBug.column + 1].smallObject areYouLeaf] == true) || (currentBug.direction == 3 && [m_map[currentBug.row + 1][currentBug.column].smallObject areYouLeaf] == true) || (currentBug.direction == 4 && [m_map[currentBug.row][currentBug.column - 1].smallObject areYouLeaf] == true))){
                [currentBug queueChange];
            }else{
                        if ((currentBug.direction == 1 && [self isFreeRow: (currentBug.row - 1) Col: (currentBug.column)] == true) || (currentBug.direction == 2 && [self isFreeRow: (currentBug.row) Col: (currentBug.column + 1)] == true) || (currentBug.direction == 3 && [self isFreeRow: (currentBug.row + 1) Col: (currentBug.column)] == true) || (currentBug.direction == 4 && [self isFreeRow: (currentBug.row) Col: (currentBug.column - 1)] == true)){
                            [self moveBugDir: (currentBug.direction)];
                            [currentBug queueChange];
                        }else{
                            [currentBug queueChange];
                            [currentBug cleanQueue];
                        }
            }
        }
    }
}

-(void) mapDo{
    if (currentBug.dead == false){
        [self tellBugMove];
    }
    if (arc4random() % 10 == 1){
        [self dryMap];
    }
    if (arc4random() % 3 == 1){
        [self worldFire];
    }
}

- (void) passBugDir: (int) direction{
    [currentBug tellMoveDir: (direction)];
}

-(int) getDirection{
    return currentBug.direction;
}

-(id)getObjectRow: (int) r Col: (int) c{
    if (m_map[r][c].largeObject != nil){
        return m_map[r][c].largeObject;
    }else{
        return m_map[r][c].smallObject;
    }
}

-(void) push{
    if (currentBug.direction == 1 && currentBug.row > 1){
        if ([self isFreeRow: (currentBug.row - 2) Col: (currentBug.column)] == true){
            [self moveRock: (m_map[currentBug.row - 1][currentBug.column].largeObject) Dir: (currentBug.direction) Row: (currentBug.row - 1) Col: (currentBug.column) ];
            [self moveBugDir: (currentBug.direction)];
        }
    }else if (currentBug.direction == 2 && currentBug.column < (MAX_COL - 2)){
        if ([self isFreeRow: (currentBug.row) Col: (currentBug.column + 2)] == true){
            [self moveRock: (m_map[currentBug.row][currentBug.column + 1].largeObject) Dir: (currentBug.direction) Row: (currentBug.row) Col: (currentBug.column + 1) ];
            [self moveBugDir: (currentBug.direction)];
        }
        
    }else if (currentBug.direction == 3 && currentBug.row < (MAX_ROW - 2)){
        if ([self isFreeRow: (currentBug.row + 2) Col: (currentBug.column)]){
            [self moveRock: (m_map[currentBug.row + 1][currentBug.column].largeObject) Dir: (currentBug.direction) Row: (currentBug.row + 1) Col: (currentBug.column) ];
            [self moveBugDir: (currentBug.direction)];
        }
        
    }else if (currentBug.direction == 4 && currentBug.column > 1){
        if ([self isFreeRow: (currentBug.row) Col: (currentBug.column - 2)]){
            [self moveRock: (m_map[currentBug.row][currentBug.column - 1].largeObject) Dir: (currentBug.direction) Row: (currentBug.row) Col: (currentBug.column - 1) ];
            [self moveBugDir: (currentBug.direction)];
        }
        
    }
}

-(void) moveBugDir: (int) direction{
    [m_map[currentBug.row][currentBug.column] removeObject: currentBug];
    if (currentBug.layRock == true){
        [m_map[currentBug.row][currentBug.column] addObject: ([[Rock alloc] init])];
        currentBug.layRock = false;
    }
    if (direction == 1){
        currentBug.row = currentBug.row - 1;
    }else if (direction == 2){
        currentBug.column++;
    }else if (direction == 3){
        currentBug.row++;
    }else if (direction == 4){
        currentBug.column = currentBug.column - 1;
    }
    [m_map[currentBug.row][currentBug.column] addObject: currentBug];
}

-(void) moveRock: (Rock*) rock Dir: (int) direction Row: (int) row Col: (int) column{
    [m_map[row][column] removeObject: rock];
    if (direction == 1){
        [m_map[row - 1][column] addObject: rock];
        if (m_map[row - 1][column].onFire == true){
            [m_map[row - 1][column] extinguish];
            self.points = self.points + 5;
        }
    }else if (direction == 2){
        [m_map[row][column + 1] addObject: rock];
        if (m_map[row][column + 1].onFire == true){
            [m_map[row][column + 1] extinguish];
            self.points = self.points + 5;
        }
    }else if (direction == 3){
        [m_map[row + 1][column] addObject: rock];
        if (m_map[row + 1][column].onFire == true){
            [m_map[row + 1][column] extinguish];
            self.points = self.points + 5;
        }
    }else if (direction == 4) {
        [m_map[row][column - 1] addObject: rock];
        if (m_map[row][column - 1].onFire == true){
            [m_map[row][column - 1] extinguish];
            self.points = self.points + 5;
        }
    }
    
}

- (void) dryMap{
    for (int r = 0; r < MAX_ROW; r++){
        for (int c = 0; c < MAX_COL; c++){
            [self->m_map[r][c] dry];
        }
    }
}

-(void) worldFire{
    self.fireCount = 0;
    for (int r = 0; r < MAX_ROW; r++){
        for (int c = 0; c < MAX_COL; c++){
            if (m_map[r][c].onFire == true){
                self.fireCount++;
                if (r > 0){
                    [m_map[r - 1][c] trySpread];
                }
                if (c < (MAX_COL - 1)){
                    [m_map[r][c + 1] trySpread];
                }
                if (r < (MAX_ROW - 1)){
                    [m_map[r + 1][c] trySpread];
                }
                if (c > 0){
                    [m_map[r][c - 1] trySpread];
                }
                if (arc4random() % 40 == 1){
                    [m_map[r][c] extinguish];
                }
            }else if (arc4random() % 10000 == 1 && (self.placeFires == true)){
                [m_map[r][c] trySpread];
            }
        }
    }
    if ((self.fireCount / (MAX_ROW * MAX_COL)) > 0.3){
        self.placeFires = false;
    }
    if (self.placeFires == false && self.fireCount == 0){
        self.win = true;
    }
}

-(void) layrock{
    if (self.points > 9){

        self.points = self.points - 10;
        currentBug.layRock = true;
    }
}

-(void) rockLineRow: (int) r Col: (int) c{
    int length;
    length = (arc4random() % 8) + 3;
    if ((arc4random() % 2) == 1){
        while (r < (MAX_ROW - 1) && length > 0){
            if ([self isFreeRow: (r) Col: (c)] == true){
                [m_map[r][c] addObject: ([[Rock alloc] init])];
            }
            r++;
            length = length - 1;
        }
    }else{
        while (c < (MAX_COL - 1) && length > 0){
            if ([self isFreeRow: (r) Col: (c)] == true){
                [m_map[r][c] addObject: ([[Rock alloc] init])];
            }
            c++;
            length = length - 1;
        }
    }
}

-(int) getFireCount{
    return self.fireCount;
}

-(void) removeRock{
    int r;
    int c;
    BOOL onMap;
    onMap = false;
    if (self.points > 19){
        r = currentBug.row;
        c = currentBug.column;
        if (currentBug.direction == 1){
            if (currentBug.row > 0){
                r = r - 1;
                onMap = true;
            }
            
        }else if (currentBug.direction == 2){
            if (currentBug.column < (MAX_COL - 1)){
                c++;
                onMap = true;
            }
        
        }else if (currentBug.direction == 3){
            if (currentBug.row < (MAX_ROW - 1)){
                r++;
                onMap = true;
            }
        }else if (currentBug.direction == 4){
            if (currentBug.column > 0){
                c = c - 1;
                onMap = true;
            }
        }
        if (onMap == true){
            if ([m_map[r][c].largeObject areYouRock] > 0){
                m_map[r][c].largeObject = nil;
                self.points = self.points - 20;
            }
        }
    }
}

-(int) getHunger{
    return currentBug.nutrition;
}

-(void) makeHungry{
    [currentBug makeHungry];
}

-(void) eat{
    if ((currentBug.direction == 1 && currentBug.row == 0) || (currentBug.direction == 2 && currentBug.column == (MAX_COL - 1)) || (currentBug.direction == 3 && currentBug.row == (MAX_ROW - 1)) || (currentBug.direction == 4 && currentBug.column == 0)){
    }else{
        if (currentBug.direction == 1){
            if ([m_map[currentBug.row - 1][currentBug.column].smallObject areYouLeaf] == true){
                m_map[currentBug.row - 1][currentBug.column].smallObject = nil;
                [currentBug eat];
            }
        }else if (currentBug.direction == 2){
            if ([m_map[currentBug.row][currentBug.column + 1].smallObject areYouLeaf] == true){
                m_map[currentBug.row][currentBug.column + 1].smallObject = nil;
                [currentBug eat];
            }
            
        }else if (currentBug.direction == 3){
            if ([m_map[currentBug.row + 1][currentBug.column].smallObject areYouLeaf] == true){
                m_map[currentBug.row + 1][currentBug.column].smallObject = nil;
                [currentBug eat];
                
            }
            
        }else if (currentBug.direction == 4){
            if ([m_map[currentBug.row][currentBug.column - 1].smallObject areYouLeaf] == true){
                m_map[currentBug.row][currentBug.column - 1].smallObject = nil;
                [currentBug eat];
                
            }
            
        }
    }
}

-(BOOL) isBugDead{
    if (currentBug.dead == true){
        return true;
    }else{
        return false;
    }
}

@end
