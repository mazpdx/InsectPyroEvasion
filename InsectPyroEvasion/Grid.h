//
//  Grid.h
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 10/25/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rock.h"

@interface Grid : NSObject
{
    


}

@property (nonatomic) int moisture;

@property (strong, nonatomic) id largeObject;

@property (nonatomic) BOOL onFire;

@property (strong, nonatomic) id smallObject;

-(id) init;

-(BOOL) removeObject: (id) object;

-(BOOL) addObject: (id) object;

-(void) dry;

-(void) trySpread;

-(void) extinguish;

-(void) lightFire;


@end
