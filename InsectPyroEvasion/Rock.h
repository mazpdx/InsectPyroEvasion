//
//  Rock.h
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 11/27/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Largeobject.h"

@interface Rock : Largeobject{
    
}
@property (nonatomic) BOOL small;

-(int) areYouRock;

-(id) init;

@end
