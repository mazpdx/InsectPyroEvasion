//
//  Rock.m
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 11/27/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import "Rock.h"
#include <stdlib.h>

@implementation Rock

-(int) areYouRock{
    if (self.small == true){
        return 1;
    }else{
        return 2;
    }
}

-(id) init{
    self = [super init];
    if (arc4random() % 3 == 1){
        self.small = false;
    }else{
        self.small = true;
    }
    return self;
}


@end
