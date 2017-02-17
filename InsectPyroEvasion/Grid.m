//
//  Grid.m
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 10/25/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import "Grid.h"
#include <stdlib.h>
#import "Bug.h"
#import "Leaf.h"

@implementation Grid


- (id) init{
    self = [super init];
    self.moisture = arc4random() % 50;
    self.onFire = false;
    if (arc4random() % 8 == 1){
        [self addObject: ([[Rock alloc] init])];
    }
    if (arc4random() % 20 == 1){
        self.smallObject = [[Leaf alloc] init];
        self.moisture = 49;
    }
    return self;
}

-(BOOL) addObject: (id) object{
    if (self.largeObject == nil){
        self.largeObject = object;
        return true;
    }else{
        return false;
    }
}

-(BOOL) removeObject: (id) object{
    if (self.largeObject == object){
        self.largeObject = nil;
        return true;
    }else{
        return false;
    }
}

-(void) dry{
    if (self.moisture > 0){
        if ([self.smallObject areYouLeaf] == false){
            self.moisture = self.moisture - 1;
        }else{
            if (arc4random() % 7 == 1){
                self.moisture = self.moisture - 1;
            }
        }
    }
}

-(void) trySpread{
    if (self.onFire == false && [self.largeObject areYouRock] == 0){
        if (arc4random() % ((self.moisture) + 3) == 1){
            [self lightFire];
        }
    }
}

-(void) lightFire{
    if ([self.largeObject areYouBug] > 0){
        [self.largeObject die];
    }
    if ([self.smallObject areYouLeaf] == true){
        self.smallObject = nil;
    }
    self.moisture = 0;
    self.onFire = true;
}

-(void) extinguish{
    self.onFire = false;
    self.moisture = 25;
    if (arc4random() % 60 == 1){
        self.smallObject = [[Leaf alloc] init];
        self.moisture = 49;
    }
}


@end
