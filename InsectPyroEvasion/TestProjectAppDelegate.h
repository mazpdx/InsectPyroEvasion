//
//  TestProjectAppDelegate.h
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 3/29/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"

@interface TestProjectAppDelegate : UIResponder <UIApplicationDelegate>{
    
    Controller *m_ctrl;
    
}

@property (strong, nonatomic) UIWindow *window;

-(id)init;

@end
