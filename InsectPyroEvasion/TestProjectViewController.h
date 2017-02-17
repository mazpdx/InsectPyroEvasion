//
//  TestProjectViewController.h
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 3/29/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Map.h"
#import "Bug.h"

@interface TestProjectViewController : UIViewController
{
    NSTimer *mainTimer;
    int counter;
    Map *map;
    BOOL pause;
};

@property (strong, nonatomic) IBOutlet UILabel *CounterLabel;
@property (strong, nonatomic) IBOutlet UIImageView *Screen00;
@property (strong, nonatomic) IBOutlet UIImageView *Screen01;
@property (strong, nonatomic) IBOutlet UIImageView *Screen02;
@property (strong, nonatomic) IBOutlet UIImageView *Screen03;
@property (strong, nonatomic) IBOutlet UIImageView *Screen04;
@property (strong, nonatomic) IBOutlet UIImageView *Screen05;
@property (strong, nonatomic) IBOutlet UIImageView *Screen06;
@property (strong, nonatomic) IBOutlet UIImageView *Screen10;
@property (strong, nonatomic) IBOutlet UIImageView *Screen11;
@property (strong, nonatomic) IBOutlet UIImageView *Screen12;
@property (strong, nonatomic) IBOutlet UIImageView *Screen13;
@property (strong, nonatomic) IBOutlet UIImageView *Screen14;
@property (strong, nonatomic) IBOutlet UIImageView *Screen15;
@property (strong, nonatomic) IBOutlet UIImageView *Screen16;
@property (strong, nonatomic) IBOutlet UIImageView *Screen20;
@property (strong, nonatomic) IBOutlet UIImageView *Screen21;
@property (strong, nonatomic) IBOutlet UIImageView *Screen22;
@property (strong, nonatomic) IBOutlet UIImageView *Screen23;
@property (strong, nonatomic) IBOutlet UIImageView *Screen24;
@property (strong, nonatomic) IBOutlet UIImageView *Screen25;
@property (strong, nonatomic) IBOutlet UIImageView *Screen26;
@property (strong, nonatomic) IBOutlet UIImageView *Screen30;
@property (strong, nonatomic) IBOutlet UIImageView *Screen31;
@property (strong, nonatomic) IBOutlet UIImageView *Screen32;
@property (strong, nonatomic) IBOutlet UIImageView *Screen33;
@property (strong, nonatomic) IBOutlet UIImageView *Screen34;
@property (strong, nonatomic) IBOutlet UIImageView *Screen35;
@property (strong, nonatomic) IBOutlet UIImageView *Screen36;
@property (strong, nonatomic) IBOutlet UIImageView *Screen40;

@property (strong, nonatomic) IBOutlet UIImageView *Screen41;

@property (strong, nonatomic) IBOutlet UIImageView *Screen42;
@property (strong, nonatomic) IBOutlet UIImageView *Screen43;
@property (strong, nonatomic) IBOutlet UIImageView *Screen44;
@property (strong, nonatomic) IBOutlet UIImageView *Screen45;
@property (strong, nonatomic) IBOutlet UIImageView *Screen46;
@property (strong, nonatomic) IBOutlet UIImageView *Screen50;
@property (strong, nonatomic) IBOutlet UIImageView *Screen51;
@property (strong, nonatomic) IBOutlet UIImageView *Screen52;
@property (strong, nonatomic) IBOutlet UIImageView *Screen53;
@property (strong, nonatomic) IBOutlet UIImageView *Screen54;
@property (strong, nonatomic) IBOutlet UIImageView *Screen55;
@property (strong, nonatomic) IBOutlet UIImageView *Screen56;
@property (strong, nonatomic) IBOutlet UIImageView *Screen60;
@property (strong, nonatomic) IBOutlet UIImageView *Screen61;
@property (strong, nonatomic) IBOutlet UIImageView *Screen62;
@property (strong, nonatomic) IBOutlet UIImageView *Screen63;
@property (strong, nonatomic) IBOutlet UIImageView *Screen64;
@property (strong, nonatomic) IBOutlet UIImageView *Screen65;
@property (strong, nonatomic) IBOutlet UIImageView *Screen66;
@property (strong, nonatomic) IBOutlet UIButton *DownButton;
@property (strong, nonatomic) IBOutlet UIButton *UpButton;

@property (strong, nonatomic) IBOutlet UIButton *RightButton;

@property (strong, nonatomic) IBOutlet UIButton *LeftButton;


-(void)timerController;

-(void)updateScreenRow: (int) r Col: (int) c;


@end
