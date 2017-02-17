//
//  TestProjectViewController.m
//  InsectPyroEvasion
//
//  Created by Rachel Zuhl2 on 3/29/13.
//  Copyright (c) 2013 Rachel Zuhl2. All rights reserved.
//

#import "TestProjectViewController.h"


@interface TestProjectViewController ()
@property (strong, nonatomic) IBOutlet UIButton *ActionButton;

@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *FireLabel;
@property (strong, nonatomic) IBOutlet UIView *HungerBar;
@property (strong, nonatomic) IBOutlet UIButton *EatButton;
@property (strong, nonatomic) IBOutlet UILabel *InfoLabel;
@end

@implementation TestProjectViewController
- (IBAction)testButton:(id)sender {
    counter++;
    self.CounterLabel.text = [[NSString alloc] initWithFormat: (@"%d"), counter];
}
- (IBAction)leftMove:(id)sender {
    BOOL dead;
    dead = [map isBugDead];
    if (dead == false && pause == false){
        [map passBugDir: (4)];
    }
}
- (IBAction)upMove:(id)sender {
    BOOL dead;
    dead = [map isBugDead];
    if (dead == false && pause == false){
        [map passBugDir: (1)];
    }
}
- (IBAction)rightMove:(id)sender {
    BOOL dead;
    dead = [map isBugDead];
    if (dead == false && pause == false){
        [map passBugDir: (2)];
    }
}
- (IBAction)downMove:(id)sender {
    BOOL dead;
    dead = [map isBugDead];
    if (dead == false && pause == false){
        [map passBugDir: (3)];
    }
}
- (IBAction)act:(id)sender {
    BOOL dead;
    dead = [map isBugDead];
    if (dead == false && pause == false){
        [map push];
        _ActionButton.hidden = YES;
    }
}
- (IBAction)act2:(id)sender {
    BOOL dead;
    dead = [map isBugDead];
    if (dead == false && pause == false){
        [map layrock];
    }
}
- (IBAction)removeRock:(id)sender {
    BOOL dead;
    dead = [map isBugDead];
    if (dead == false && pause == false){
        [map removeRock];
    }
}
- (IBAction)eatLeaf:(id)sender {
    BOOL dead;
    dead = [map isBugDead];
    if (dead == false && pause == false){
        [map eat];
    }
}




- (void)viewDidLoad;
{
   [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //map = [[Map alloc] init];
    pause = false;
    mainTimer = [[NSTimer alloc] init];
    mainTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(timerController)
                                               userInfo:nil
                                                repeats:YES];
    counter = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)timerController{
    int r;
    int c;
    int direction;
    int fires;
    id frontobject;
    BOOL noObjectLook;
    int hunger;
    BOOL dead;
    //if (pause == false){
        CGRect temp = self.HungerBar.frame;
        counter++;
        dead = [map isBugDead];
        [map mapDo];
        if (counter % 10 == 0 && dead == false && map.win == false){
            [map makeHungry];
        }
        self.CounterLabel.text = [[NSString alloc] initWithFormat:(@"%d"), counter];
        r = map.getRowPos;
        c = map.getColPos;
        self.pointsLabel.text = [[NSString alloc] initWithFormat:(@"Points: %d"), map.points];
        fires = [map getFireCount];
        self.FireLabel.text = [[NSString alloc] initWithFormat:(@"Fires: %d"), (fires)];
        hunger = [map getHunger];
        if (map.win == true){
            self.InfoLabel.text = @"You have won the game!";
        }else if (counter < 30 && dead == false){
            self.InfoLabel.text = @"Push rocks to build a shelter!";
        }else if (hunger < 5 && dead == false){
            self.InfoLabel.text = @"Eat some leaves!";
        }else{
            self.InfoLabel.text = @"";
        }
        temp.size.height = (hunger * 2);
        temp.origin.y = 300 + (60 - (hunger * 2));
        self.HungerBar.frame = temp;
        direction = map.getDirection;
        noObjectLook = false;
        /*if (dead == true){
            _UpButton.enabled = NO;
            _RightButton.enabled = NO;
            _DownButton.enabled = NO;
            _LeftButton.enabled = NO;
            _ActionButton.enabled = NO;
            _EatButton.enabled = NO;
        }else{*/
            if (direction == 1 && r == 0){
                _UpButton.enabled = NO;
                noObjectLook = true;
            }else{
                _UpButton.enabled = YES;
            }
            if (direction == 2 && c == (MAX_COL - 1)){
                _RightButton.enabled = NO;
                noObjectLook = true;
            }else{
                _RightButton.enabled = YES;
            }
            if (direction == 3 && r == (MAX_ROW - 1)){
                _DownButton.enabled = NO;
                noObjectLook = true;
            }else{
                _DownButton.enabled = YES;
            }
            if (direction == 4 && c == 0){
                _LeftButton.enabled = NO;
                noObjectLook = true;
            }else{
                _LeftButton.enabled = YES;
            }
            _ActionButton.hidden = YES;
            _EatButton.hidden = YES;
            if (noObjectLook == false){
                if (direction == 1){
                    frontobject = [map getObjectRow: (r - 1) Col: (c)];
                }else if (direction == 2){
                    frontobject = [map getObjectRow: (r) Col: (c + 1)];
                }else if (direction == 3){
                    frontobject = [map getObjectRow: (r + 1) Col: (c)];
                }else if (direction == 4){
                    frontobject = [map getObjectRow: (r) Col: (c - 1)];
                }
            }
            if ([frontobject areYouRock] != 0){
                _ActionButton.hidden = NO;
            }else if ([frontobject areYouLeaf] == true){
                _EatButton.hidden = NO;
            }
        //}
        [self updateScreenRow: (r) Col: (c)];
    //}
    
}

-(void)updateScreenRow: (int) r Col: (int) c{
    int picnum;
    if (r < 3){
        r = 3;
    }else if (r > (MAX_ROW - 4)){
        r = MAX_ROW - 4;
    }
    if (c < 3){
        c = 3;
    }else if (c > (MAX_COL - 4)){
        c = MAX_COL - 4;
    }
    picnum = [map getPictureRow: (r - 3) Col: (c - 3)];
    if (picnum == 1){
        _Screen00.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen00.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen00.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen00.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen00.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen00.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen00.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen00.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen00.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen00.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen00.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen00.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen00.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen00.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen00.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen00.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen00.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen00.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen00.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen00.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen00.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen00.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen00.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen00.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen00.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen00.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen00.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen00.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen00.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen00.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen00.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen00.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen00.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen00.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen00.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen00.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen00.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen00.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen00.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen00.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen00.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen00.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen00.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen00.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen00.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen00.Image = [UIImage imageNamed: @"Dead5.png"];
    }
                           
    
    
   picnum = [map getPictureRow: (r - 3) Col: (c - 2)];
    if (picnum == 1){
        _Screen01.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen01.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen01.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen01.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen01.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen01.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen01.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen01.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen01.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen01.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen01.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen01.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen01.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen01.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen01.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen01.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen01.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen01.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen01.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen01.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen01.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen01.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen01.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen01.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen01.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen01.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen01.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen01.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen01.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen01.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen01.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen01.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen01.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen01.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen01.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen01.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen01.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen01.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen01.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen01.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen01.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen01.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen01.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen01.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen01.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen01.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 3) Col: (c - 1)];
    if (picnum == 1){
        _Screen02.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen02.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen02.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen02.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen02.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen02.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen02.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen02.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen02.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen02.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen02.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen02.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen02.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen02.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen02.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen02.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen02.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen02.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen02.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen02.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen02.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen02.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen02.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen02.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen02.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen02.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen02.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen02.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen02.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen02.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen02.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen02.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen02.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen02.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen02.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen02.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen02.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen02.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen02.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen02.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen02.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen02.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen02.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen02.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen02.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen02.Image = [UIImage imageNamed: @"Dead5.png"];
    }

    
    picnum = [map getPictureRow: (r - 3) Col: (c)];
    if (picnum == 1){
        _Screen03.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen03.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen03.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen03.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen03.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen03.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen03.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen03.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen03.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen03.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen03.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen03.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen03.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen03.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen03.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen03.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen03.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen03.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen03.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen03.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen03.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen03.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen03.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen03.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen03.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen03.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen03.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen03.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen03.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen03.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen03.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen03.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen03.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen03.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen03.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen03.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen03.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen03.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen03.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen03.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen03.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen03.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen03.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen03.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen03.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen03.Image = [UIImage imageNamed: @"Dead5.png"];
    }

    
    
    picnum = [map getPictureRow: (r - 3) Col: (c + 1)];
    if (picnum == 1){
        _Screen04.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen04.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen04.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen04.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen04.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen04.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen04.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen04.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen04.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen04.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen04.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen04.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen04.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen04.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen04.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen04.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen04.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen04.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen04.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen04.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen04.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen04.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen04.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen04.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen04.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen04.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen04.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen04.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen04.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen04.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen04.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen04.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen04.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen04.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen04.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen04.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen04.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen04.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen04.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen04.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen04.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen04.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen04.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen04.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen04.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen04.Image = [UIImage imageNamed: @"Dead5.png"];
    }

    picnum = [map getPictureRow: (r - 3) Col: (c + 2)];
    if (picnum == 1){
        _Screen05.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen05.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen05.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen05.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen05.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen05.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen05.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen05.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen05.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen05.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen05.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen05.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen05.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen05.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen05.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen05.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen05.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen05.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen05.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen05.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen05.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen05.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen05.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen05.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen05.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen05.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen05.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen05.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen05.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen05.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen05.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen05.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen05.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen05.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen05.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen05.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen05.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen05.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen05.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen05.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen05.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen05.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen05.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen05.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen05.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen05.Image = [UIImage imageNamed: @"Dead5.png"];
    }

    
    picnum = [map getPictureRow: (r - 3) Col: (c + 3)];
    if (picnum == 1){
        _Screen06.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen06.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen06.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen06.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen06.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen06.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen06.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen06.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen06.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen06.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen06.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen06.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen06.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen06.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen06.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen06.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen06.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen06.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen06.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen06.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen06.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen06.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen06.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen06.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen06.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen06.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen06.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen06.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen06.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen06.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen06.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen06.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen06.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen06.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen06.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen06.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen06.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen06.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen06.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen06.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen06.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen06.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen06.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen06.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen06.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen06.Image = [UIImage imageNamed: @"Dead5.png"];
    }

    
    
    picnum = [map getPictureRow: (r - 2) Col: (c - 3)];
    if (picnum == 1){
        _Screen10.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen10.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen10.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen10.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen10.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen10.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen10.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen10.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen10.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen10.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen10.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen10.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen10.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen10.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen10.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen10.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen10.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen10.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen10.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen10.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen10.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen10.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen10.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen10.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen10.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen10.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen10.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen10.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen10.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen10.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen10.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen10.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen10.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen10.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen10.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen10.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen10.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen10.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen10.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen10.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen10.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen10.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen10.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen10.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen10.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen10.Image = [UIImage imageNamed: @"Dead5.png"];
    }

    
    
    picnum = [map getPictureRow: (r - 2) Col: (c - 2)];
    if (picnum == 1){
        _Screen11.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen11.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen11.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen11.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen11.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen11.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen11.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen11.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen11.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen11.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen11.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen11.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen11.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen11.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen11.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen11.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen11.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen11.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen11.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen11.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen11.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen11.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen11.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen11.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen11.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen11.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen11.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen11.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen11.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen11.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen11.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen11.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen11.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen11.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen11.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen11.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen11.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen11.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen11.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen11.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen11.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen11.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen11.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen11.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen11.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen11.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 2) Col: (c - 1)];
    if (picnum == 1){
        _Screen12.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen12.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen12.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen12.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen12.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen12.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen12.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen12.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen12.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen12.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen12.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen12.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen12.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen12.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen12.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen12.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen12.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen12.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen12.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen12.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen12.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen12.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen12.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen12.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen12.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen12.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen12.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen12.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen12.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen12.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen12.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen12.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen12.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen12.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen12.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen12.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen12.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen12.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen12.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen12.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen12.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen12.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen12.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen12.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen12.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen12.Image = [UIImage imageNamed: @"Dead5.png"];
        
    }
    
    
    picnum = [map getPictureRow: (r - 2) Col: (c)];
    if (picnum == 1){
        _Screen13.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen13.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen13.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen13.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen13.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen13.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen13.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen13.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen13.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen13.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen13.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen13.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen13.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen13.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen13.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen13.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen13.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen13.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen13.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen13.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen13.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen13.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen13.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen13.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen13.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen13.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen13.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen13.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen13.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen13.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen13.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen13.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen13.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen13.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen13.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen13.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen13.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen13.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen13.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen13.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen13.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen13.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen13.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen13.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen13.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen13.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    
    picnum = [map getPictureRow: (r - 2) Col: (c + 1)];
    if (picnum == 1){
        _Screen14.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen14.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen14.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen14.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen14.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen14.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen14.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen14.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen14.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen14.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen14.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen14.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen14.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen14.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen14.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen14.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen14.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen14.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen14.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen14.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen14.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen14.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen14.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen14.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen14.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen14.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen14.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen14.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen14.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen14.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen14.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen14.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen14.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen14.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen14.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen14.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen14.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen14.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen14.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen14.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen14.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen14.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen14.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen14.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen14.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen14.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 2) Col: (c + 2)];
    if (picnum == 1){
        _Screen15.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen15.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen15.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen15.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen15.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen15.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen15.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen15.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen15.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen15.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen15.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen15.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen15.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen15.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen15.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen15.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen15.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen15.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen15.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen15.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen15.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen15.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen15.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen15.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen15.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen15.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen15.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen15.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen15.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen15.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen15.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen15.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen15.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen15.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen15.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen15.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen15.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen15.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen15.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen15.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen15.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen15.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen15.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen15.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen15.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen15.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 2) Col: (c + 3)];
    if (picnum == 1){
        _Screen16.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen16.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen16.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen16.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen16.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen16.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen16.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen16.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen16.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen16.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen16.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen16.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen16.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen16.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen16.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen16.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen16.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen16.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen16.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen16.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen16.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen16.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen16.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen16.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen16.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen16.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen16.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen16.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen16.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen16.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen16.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen16.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen16.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen16.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen16.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen16.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen16.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen16.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen16.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen16.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen16.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen16.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen16.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen16.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen16.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen16.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    
    picnum = [map getPictureRow: (r - 1) Col: (c - 3)];
    if (picnum == 1){
        _Screen20.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen20.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen20.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen20.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen20.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen20.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen20.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen20.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen20.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen20.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen20.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen20.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen20.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen20.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen20.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen20.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen20.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen20.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen20.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen20.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen20.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen20.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen20.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen20.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen20.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen20.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen20.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen20.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen20.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen20.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen20.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen20.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen20.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen20.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen20.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen20.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen20.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen20.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen20.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen20.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen20.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen20.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen20.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen20.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen20.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen20.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 1) Col: (c - 2)];
    if (picnum == 1){
        _Screen21.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen21.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen21.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen21.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen21.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen21.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen21.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen21.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen21.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen21.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen21.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen21.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen21.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen21.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen21.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen21.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen21.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen21.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen21.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen21.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen21.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen21.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen21.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen21.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen21.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen21.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen21.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen21.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen21.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen21.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen21.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen21.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen21.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen21.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen21.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen21.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen21.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen21.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen21.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen21.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen21.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen21.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen21.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen21.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen21.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen21.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 1) Col: (c - 1)];
    if (picnum == 1){
        _Screen22.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen22.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen22.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen22.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen22.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen22.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen22.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen22.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen22.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen22.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen22.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen22.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen22.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen22.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen22.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen22.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen22.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen22.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen22.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen22.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen22.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen22.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen22.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen22.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen22.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen22.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen22.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen22.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen22.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen22.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen22.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen22.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen22.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen22.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen22.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen22.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen22.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen22.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen22.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen22.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen22.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen22.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen22.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen22.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen22.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen22.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 1) Col: (c)];
    if (picnum == 1){
        _Screen23.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen23.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen23.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen23.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen23.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen23.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen23.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen23.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen23.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen23.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen23.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen23.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen23.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen23.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen23.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen23.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen23.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen23.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen23.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen23.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen23.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen23.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen23.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen23.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen23.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen23.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen23.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen23.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen23.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen23.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen23.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen23.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen23.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen23.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen23.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen23.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen23.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen23.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen23.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen23.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen23.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen23.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen23.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen23.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen23.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen23.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    
    picnum = [map getPictureRow: (r - 1) Col: (c + 1)];
    if (picnum == 1){
        _Screen24.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen24.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen24.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen24.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen24.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen24.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen24.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen24.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen24.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen24.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen24.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen24.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen24.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen24.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen24.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen24.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen24.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen24.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen24.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen24.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen24.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen24.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen24.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen24.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen24.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen24.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen24.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen24.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen24.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen24.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen24.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen24.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen24.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen24.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen24.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen24.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen24.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen24.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen24.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen24.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen24.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen24.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen24.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen24.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen24.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen24.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 1) Col: (c + 2)];
    if (picnum == 1){
        _Screen25.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen25.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen25.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen25.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen25.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen25.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen25.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen25.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen25.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen25.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen25.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen25.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen25.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen25.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen25.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen25.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen25.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen25.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen25.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen25.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen25.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen25.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen25.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen25.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen25.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen25.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen25.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen25.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen25.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen25.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen25.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen25.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen25.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen25.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen25.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen25.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen25.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen25.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen25.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen25.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen25.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen25.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen25.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen25.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen25.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen25.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r - 1) Col: (c + 3)];
    if (picnum == 1){
        _Screen26.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen26.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen26.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen26.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen26.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen26.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen26.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen26.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen26.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen26.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen26.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen26.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen26.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen26.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen26.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen26.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen26.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen26.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen26.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen26.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen26.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen26.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen26.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen26.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen26.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen26.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen26.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen26.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen26.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen26.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen26.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen26.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen26.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen26.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen26.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen26.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen26.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen26.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen26.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen26.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen26.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen26.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen26.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen26.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen26.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen26.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    
    picnum = [map getPictureRow: (r) Col: (c - 3)];
    if (picnum == 1){
        _Screen30.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen30.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen30.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen30.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen30.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen30.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen30.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen30.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen30.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen30.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen30.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen30.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen30.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen30.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen30.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen30.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen30.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen30.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen30.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen30.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen30.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen30.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen30.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen30.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen30.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen30.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen30.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen30.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen30.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen30.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen30.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen30.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen30.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen30.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen30.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen30.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen30.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen30.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen30.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen30.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen30.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen30.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen30.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen30.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen30.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen30.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r) Col: (c - 2)];
    if (picnum == 1){
        _Screen31.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen31.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen31.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen31.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen31.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen31.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen31.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen31.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen31.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen31.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen31.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen31.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen31.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen31.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen31.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen31.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen31.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen31.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen31.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen31.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen31.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen31.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen31.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen31.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen31.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen31.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen31.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen31.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen31.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen31.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen31.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen31.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen31.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen31.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen31.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen31.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen31.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen31.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen31.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen31.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen31.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen31.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen31.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen31.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen31.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen31.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r) Col: (c - 1)];
    if (picnum == 1){
        _Screen32.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen32.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen32.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen32.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen32.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen32.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen32.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen32.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen32.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen32.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen32.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen32.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen32.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen32.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen32.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen32.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen32.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen32.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen32.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen32.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen32.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen32.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen32.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen32.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen32.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen32.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen32.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen32.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen32.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen32.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen32.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen32.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen32.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen32.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen32.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen32.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen32.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen32.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen32.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen32.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen32.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen32.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen32.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen32.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen32.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen32.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r) Col: (c)];
    if (picnum == 1){
        _Screen33.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen33.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen33.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen33.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen33.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen33.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen33.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen33.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen33.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen33.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen33.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen33.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen33.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen33.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen33.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen33.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen33.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen33.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen33.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen33.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen33.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen33.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen33.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen33.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen33.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen33.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen33.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen33.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen33.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen33.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen33.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen33.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen33.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen33.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen33.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen33.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen33.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen33.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen33.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen33.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen33.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen33.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen33.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen33.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen33.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen33.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    
    picnum = [map getPictureRow: (r) Col: (c + 1)];
    if (picnum == 1){
        _Screen34.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen34.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen34.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen34.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen34.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen34.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen34.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen34.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen34.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen34.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen34.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen34.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen34.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen34.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen34.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen34.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen34.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen34.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen34.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen34.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen34.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen34.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen34.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen34.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen34.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen34.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen34.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen34.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen34.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen34.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen34.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen34.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen34.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen34.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen34.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen34.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen34.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen34.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen34.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen34.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen34.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen34.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen34.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen34.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen34.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen34.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r) Col: (c + 2)];
    if (picnum == 1){
        _Screen35.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen35.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen35.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen35.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen35.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen35.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen35.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen35.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen35.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen35.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen35.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen35.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen35.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen35.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen35.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen35.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen35.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen35.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen35.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen35.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen35.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen35.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen35.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen35.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen35.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen35.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen35.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen35.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen35.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen35.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen35.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen35.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen35.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen35.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen35.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen35.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen35.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen35.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen35.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen35.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen35.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen35.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen35.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen35.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen35.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen35.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r) Col: (c + 3)];
    if (picnum == 1){
        _Screen36.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen36.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen36.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen36.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen36.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen36.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen36.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen36.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen36.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen36.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen36.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen36.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen36.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen36.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen36.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen36.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen36.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen36.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen36.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen36.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen36.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen36.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen36.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen36.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen36.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen36.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen36.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen36.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen36.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen36.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen36.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen36.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen36.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen36.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen36.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen36.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen36.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen36.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen36.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen36.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen36.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen36.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen36.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen36.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen36.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen36.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    
    picnum = [map getPictureRow: (r + 1) Col: (c - 3)];
    if (picnum == 1){
        _Screen40.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen40.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen40.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen40.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen40.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen40.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen40.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen40.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen40.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen40.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen40.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen40.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen40.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen40.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen40.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen40.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen40.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen40.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen40.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen40.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen40.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen40.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen40.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen40.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen40.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen40.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen40.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen40.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen40.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen40.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen40.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen40.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen40.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen40.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen40.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen40.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen40.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen40.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen40.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen40.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen40.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen40.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen40.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen40.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen40.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen40.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 1) Col: (c - 2)];
    if (picnum == 1){
        _Screen41.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen41.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen41.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen41.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen41.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen41.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen41.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen41.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen41.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen41.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen41.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen41.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen41.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen41.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen41.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen41.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen41.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen41.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen41.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen41.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen41.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen41.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen41.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen41.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen41.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen41.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen41.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen41.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen41.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen41.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen41.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen41.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen41.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen41.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen41.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen41.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen41.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen41.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen41.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen41.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen41.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen41.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen41.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen41.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen41.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen41.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 1) Col: (c - 1)];
    if (picnum == 1){
        _Screen42.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen42.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen42.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen42.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen42.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen42.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen42.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen42.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen42.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen42.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen42.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen42.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen42.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen42.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen42.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen42.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen42.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen42.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen42.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen42.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen42.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen42.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen42.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen42.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen42.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen42.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen42.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen42.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen42.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen42.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen42.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen42.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen42.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen42.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen42.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen42.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen42.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen42.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen42.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen42.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen42.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen42.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen42.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen42.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen42.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen42.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 1) Col: (c)];
    if (picnum == 1){
        _Screen43.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen43.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen43.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen43.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen43.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen43.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen43.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen43.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen43.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen43.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen43.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen43.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen43.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen43.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen43.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen43.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen43.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen43.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen43.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen43.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen43.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen43.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen43.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen43.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen43.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen43.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen43.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen43.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen43.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen43.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen43.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen43.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen43.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen43.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen43.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen43.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen43.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen43.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen43.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen43.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen43.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen43.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen43.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen43.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen43.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen43.Image = [UIImage imageNamed: @"Dead5.png"];
        
    }
    
    
    
    picnum = [map getPictureRow: (r + 1) Col: (c + 1)];
    if (picnum == 1){
        _Screen44.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen44.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen44.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen44.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen44.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen44.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen44.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen44.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen44.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen44.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen44.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen44.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen44.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen44.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen44.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen44.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen44.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen44.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen44.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen44.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen44.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen44.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen44.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen44.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen44.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen44.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen44.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen44.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen44.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen44.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen44.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen44.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen44.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen44.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen44.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen44.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen44.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen44.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen44.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen44.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen44.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen44.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen44.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen44.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen44.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen44.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 1) Col: (c + 2)];
    if (picnum == 1){
        _Screen45.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen45.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen45.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen45.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen45.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen45.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen45.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen45.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen45.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen45.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen45.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen45.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen45.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen45.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen45.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen45.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen45.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen45.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen45.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen45.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen45.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen45.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen45.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen45.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen45.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen45.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen45.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen45.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen45.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen45.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen45.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen45.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen45.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen45.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen45.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen45.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen45.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen45.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen45.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen45.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen45.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen45.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen45.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen45.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen45.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen45.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 1) Col: (c + 3)];
    if (picnum == 1){
        _Screen46.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen46.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen46.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen46.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen46.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen46.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen46.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen46.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen46.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen46.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen46.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen46.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen46.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen46.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen46.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen46.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen46.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen46.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen46.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen46.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen46.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen46.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen46.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen46.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen46.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen46.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen46.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen46.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen46.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen46.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen46.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen46.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen46.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen46.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen46.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen46.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen46.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen46.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen46.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen46.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen46.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen46.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen46.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen46.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen46.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen46.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 2) Col: (c - 3)];
    if (picnum == 1){
        _Screen50.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen50.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen50.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen50.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen50.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen50.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen50.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen50.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen50.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen50.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen50.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen50.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen50.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen50.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen50.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen50.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen50.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen50.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen50.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen50.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen50.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen50.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen50.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen50.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen50.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen50.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen50.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen50.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen50.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen50.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen50.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen50.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen50.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen50.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen50.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen50.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen50.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen50.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen50.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen50.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen50.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen50.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen50.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen50.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen50.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen50.Image = [UIImage imageNamed: @"Dead5.png"];
    }

    
    
    picnum = [map getPictureRow: (r + 2) Col: (c - 2)];
    if (picnum == 1){
        _Screen51.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen51.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen51.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen51.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen51.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen51.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen51.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen51.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen51.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen51.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen51.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen51.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen51.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen51.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen51.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen51.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen51.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen51.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen51.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen51.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen51.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen51.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen51.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen51.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen51.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen51.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen51.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen51.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen51.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen51.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen51.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen51.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen51.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen51.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen51.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen51.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen51.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen51.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen51.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen51.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen51.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen51.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen51.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen51.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen51.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen51.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 2) Col: (c - 1)];
    if (picnum == 1){
        _Screen52.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen52.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen52.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen52.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen52.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen52.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen52.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen52.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen52.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen52.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen52.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen52.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen52.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen52.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen52.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen52.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen52.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen52.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen52.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen52.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen52.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen52.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen52.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen52.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen52.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen52.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen52.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen52.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen52.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen52.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen52.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen52.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen52.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen52.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen52.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen52.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen52.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen52.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen52.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen52.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen52.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen52.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen52.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen52.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen52.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen52.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 2) Col: (c)];
    if (picnum == 1){
        _Screen53.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen53.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen53.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen53.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen53.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen53.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen53.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen53.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen53.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen53.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen53.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen53.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen53.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen53.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen53.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen53.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen53.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen53.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen53.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen53.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen53.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen53.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen53.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen53.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen53.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen53.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen53.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen53.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen53.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen53.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen53.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen53.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen53.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen53.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen53.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen53.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen53.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen53.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen53.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen53.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen53.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen53.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen53.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen53.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen53.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen53.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    
    picnum = [map getPictureRow: (r + 2) Col: (c + 1)];
    if (picnum == 1){
        _Screen54.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen54.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen54.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen54.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen54.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen54.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen54.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen54.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen54.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen54.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen54.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen54.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen54.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen54.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen54.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen54.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen54.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen54.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen54.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen54.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen54.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen54.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen54.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen54.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen54.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen54.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen54.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen54.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen54.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen54.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen54.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen54.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen54.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen54.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen54.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen54.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen54.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen54.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen54.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen54.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen54.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen54.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen54.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen54.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen54.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen54.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 2) Col: (c + 2)];
    if (picnum == 1){
        _Screen55.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen55.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen55.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen55.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen55.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen55.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen55.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen55.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen55.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen55.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen55.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen55.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen55.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen55.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen55.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen55.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen55.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen55.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen55.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen55.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen55.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen55.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen55.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen55.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen55.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen55.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen55.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen55.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen55.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen55.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen55.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen55.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen55.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen55.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen55.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen55.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen55.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen55.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen55.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen55.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen55.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen55.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen55.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen55.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen55.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen55.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 2) Col: (c + 3)];
    if (picnum == 1){
        _Screen56.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen56.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen56.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen56.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen56.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen56.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen56.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen56.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen56.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen56.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen56.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen56.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen56.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen56.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen56.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen56.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen56.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen56.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen56.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen56.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen56.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen56.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen56.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen56.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen56.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen56.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen56.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen56.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen56.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen56.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen56.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen56.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen56.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen56.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen56.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen56.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen56.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen56.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen56.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen56.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen56.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen56.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen56.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen56.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen56.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen56.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 3) Col: (c - 3)];
    if (picnum == 1){
        _Screen60.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen60.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen60.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen60.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen60.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen60.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen60.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen60.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen60.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen60.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen60.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen60.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen60.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen60.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen60.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen60.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen60.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen60.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen60.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen60.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen60.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen60.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen60.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen60.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen60.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen60.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen60.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen60.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen60.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen60.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen60.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen60.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen60.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen60.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen60.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen60.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen60.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen60.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen60.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen60.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen60.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen60.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen60.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen60.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen60.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen60.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 3) Col: (c - 2)];
    if (picnum == 1){
        _Screen61.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen61.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen61.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen61.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen61.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen61.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen61.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen61.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen61.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen61.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen61.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen61.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen61.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen61.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen61.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen61.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen61.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen61.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen61.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen61.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen61.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen61.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen61.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen61.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen61.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen61.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen61.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen61.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen61.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen61.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen61.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen61.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen61.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen61.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen61.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen61.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen61.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen61.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen61.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen61.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen61.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen61.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen61.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen61.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen61.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen61.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 3) Col: (c - 1)];
    if (picnum == 1){
        _Screen62.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen62.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen62.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen62.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen62.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen62.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen62.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen62.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen62.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen62.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen62.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen62.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen62.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen62.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen62.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen62.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen62.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen62.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen62.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen62.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen62.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen62.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen62.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen62.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen62.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen62.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen62.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen62.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen62.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen62.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen62.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen62.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen62.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen62.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen62.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen62.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen62.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen62.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen62.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen62.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen62.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen62.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen62.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen62.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen62.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen62.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 3) Col: (c)];
    if (picnum == 1){
        _Screen63.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen63.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen63.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen63.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen63.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen63.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen63.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen63.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen63.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen63.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen63.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen63.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen63.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen63.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen63.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen63.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen63.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen63.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen63.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen63.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen63.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen63.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen63.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen63.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen63.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen63.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen63.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen63.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen63.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen63.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen63.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen63.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen63.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen63.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen63.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen63.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen63.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen63.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen63.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen63.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen63.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen63.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen63.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen63.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen63.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen63.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    
    picnum = [map getPictureRow: (r + 3) Col: (c + 1)];
    if (picnum == 1){
        _Screen64.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen64.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen64.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen64.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen64.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen64.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen64.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen64.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen64.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen64.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen64.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen64.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen64.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen64.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen64.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen64.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen64.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen64.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen64.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen64.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen64.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen64.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen64.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen64.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen64.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen64.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen64.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen64.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen64.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen64.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen64.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen64.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen64.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen64.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen64.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen64.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen64.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen64.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen64.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen64.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen64.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen64.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen64.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen64.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen64.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen64.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 3) Col: (c + 2)];
    if (picnum == 1){
        _Screen65.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen65.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen65.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen65.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen65.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen65.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen65.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen65.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen65.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen65.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen65.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen65.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen65.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen65.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen65.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen65.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen65.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen65.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen65.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen65.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen65.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen65.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen65.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen65.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen65.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen65.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen65.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen65.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen65.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen65.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen65.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen65.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen65.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen65.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen65.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen65.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen65.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen65.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen65.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen65.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen65.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen65.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen65.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen65.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen65.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen65.Image = [UIImage imageNamed: @"Dead5.png"];
    }
    
    
    picnum = [map getPictureRow: (r + 3) Col: (c + 3)];
    if (picnum == 1){
        _Screen66.Image = [UIImage imageNamed: @"DirtE.png"];
    }else if (picnum == 2){
        _Screen66.Image = [UIImage imageNamed: @"DirtE2.png"];
    }else if (picnum == 3){
        _Screen66.Image = [UIImage imageNamed: @"DirtE3.png"];
    }else if (picnum == 4){
        _Screen66.Image = [UIImage imageNamed: @"DirtE4.png"];
    }else if (picnum == 5){
        _Screen66.Image = [UIImage imageNamed: @"DirtE5.png"];
    }else if (picnum == 6){
        _Screen66.Image = [UIImage imageNamed: @"Bug.png"];
    }else if (picnum == 7){
        _Screen66.Image = [UIImage imageNamed: @"BugRight.png"];
    }else if (picnum == 8){
        _Screen66.Image = [UIImage imageNamed: @"BugDown.png"];
    }else if (picnum == 9){
        _Screen66.Image = [UIImage imageNamed: @"BugLeft.png"];
    }else if (picnum == 11){
        _Screen66.Image = [UIImage imageNamed: @"Bug2Up.png"];
    }else if (picnum == 12){
        _Screen66.Image = [UIImage imageNamed: @"Bug2Right.png"];
    }else if (picnum == 13){
        _Screen66.Image = [UIImage imageNamed: @"Bug2Down.png"];
    }else if (picnum == 14){
        _Screen66.Image = [UIImage imageNamed: @"Bug2Left.png"];
    }else if (picnum == 16){
        _Screen66.Image = [UIImage imageNamed: @"Bug3Up.png"];
    }else if (picnum == 17){
        _Screen66.Image = [UIImage imageNamed: @"Bug3Right.png"];
    }else if (picnum == 18){
        _Screen66.Image = [UIImage imageNamed: @"Bug3Down.png"];
    }else if (picnum == 19){
        _Screen66.Image = [UIImage imageNamed: @"Bug3Left.png"];
    }else if (picnum == 21){
        _Screen66.Image = [UIImage imageNamed: @"Bug4Up.png"];
    } else if (picnum == 22){
        _Screen66.Image = [UIImage imageNamed: @"Bug4Right.png"];
    }else if (picnum == 23){
        _Screen66.Image = [UIImage imageNamed: @"Bug4Down.png"];
    }else if (picnum == 24){
        _Screen66.Image = [UIImage imageNamed: @"Bug4Left.png"];
    }else if (picnum == 26){
        _Screen66.Image = [UIImage imageNamed: @"Bug5Up.png"];
    }else if (picnum == 27){
        _Screen66.Image = [UIImage imageNamed: @"Bug5Right.png"];
    }else if (picnum == 28){
        _Screen66.Image = [UIImage imageNamed: @"Bug5Down.png"];
    }else if (picnum == 29){
        _Screen66.Image = [UIImage imageNamed: @"Bug5Left.png"];
    }else if (picnum == 30){
        _Screen66.Image = [UIImage imageNamed: @"Rock1.png"];
    }else if (picnum == 31){
        _Screen66.Image = [UIImage imageNamed: @"Rock2.png"];
    }else if (picnum == 32){
        _Screen66.Image = [UIImage imageNamed: @"Rock3.png"];
    }else if (picnum == 33){
        _Screen66.Image = [UIImage imageNamed: @"Rock4.png"];
    }else if (picnum == 34){
        _Screen66.Image = [UIImage imageNamed: @"Rock5.png"];
    }else if (picnum == 35){
        _Screen66.Image = [UIImage imageNamed: @"RockLarge1.png"];
    }else if (picnum == 36){
        _Screen66.Image = [UIImage imageNamed: @"RockLarge2.png"];
    }else if (picnum == 37){
        _Screen66.Image = [UIImage imageNamed: @"RockLarge3.png"];
    }else if (picnum == 38){
        _Screen66.Image = [UIImage imageNamed: @"RockLarge4.png"];
    }else if (picnum == 39){
        _Screen66.Image = [UIImage imageNamed: @"RockLarge5.png"];
    }else if (picnum == 40){
        _Screen66.Image = [UIImage imageNamed: @"Fire.png"];
    }else if (picnum == 45){
        _Screen66.Image = [UIImage imageNamed: @"Leaf1.png"];
    }else if (picnum == 46){
        _Screen66.Image = [UIImage imageNamed: @"Leaf2.png"];
    }else if (picnum == 47){
        _Screen66.Image = [UIImage imageNamed: @"Leaf3.png"];
    }else if (picnum == 48){
        _Screen66.Image = [UIImage imageNamed: @"Leaf4.png"];
    }else if (picnum == 49){
        _Screen66.Image = [UIImage imageNamed: @"Leaf5.png"];
    }else if (picnum == 50){
        _Screen66.Image = [UIImage imageNamed: @"Dead1.png"];
    }else if (picnum == 51){
        _Screen66.Image = [UIImage imageNamed: @"Dead2.png"];
    }else if (picnum == 52){
        _Screen66.Image = [UIImage imageNamed: @"Dead3.png"];
    }else if (picnum == 53){
        _Screen66.Image = [UIImage imageNamed: @"Dead4.png"];
    }else if (picnum == 54){
        _Screen66.Image = [UIImage imageNamed: @"Dead5.png"];
    }
}


@end
