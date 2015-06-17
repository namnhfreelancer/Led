//
//  ViewController.m
//  RunningLED
//
//  Created by Nam Titan on 6/17/15.
//  Copyright © 2015 Nam Titan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin;
    CGFloat _marginH;
    int _numberOfBall;
    CGFloat _space;
    CGFloat _ballDiameter;
    NSTimer * _timer;
    int lastOnLED;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0;
    _marginH = 100;
    _ballDiameter = 24.0;
    lastOnLED = _numberOfBall;
    _numberOfBall = 3;
    [self checkSizeOfApp];
    [self numberOfBallVsSpace];
    [self drawRowOfBall:_numberOfBall];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(runningLED) userInfo:nil repeats:true];

}
-(void) runningLED{
    if (lastOnLED!= -1) {
        [self turnOFFLed:lastOnLED];
    }
    if (lastOnLED!= 0){
        lastOnLED --;
    } else {
        lastOnLED = _numberOfBall -1;
    }
    [self turnONLed:lastOnLED];
    NSLog(@"cuoi:%d", lastOnLED);
}
-(void) turnONLed:(int) index {
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}
-(void) turnOFFLed:(int) index {
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"gray"];
    }
}

-(void) placeGrayBallAtX : (CGFloat) x
                    andY : (CGFloat) y
                  withTag: (int)tag
{
    UIImageView *ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gray"]];
    ball.center = CGPointMake(x, y);
    ball.tag   = tag;
    [self.view addSubview:ball];
    NSLog(@"w=%3.0f,h=%3.0f",ball.bounds.size.width,ball.bounds.size.height);
}
-(CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnow: (int) n {
    return (self.view.bounds.size.width -2 * _margin)/ (n - 1);
    
}
-(CGFloat)spaceBetweenRowBallCenterWhenNumberBallIsKnown: (int)n{
    return (self.view.bounds.size.height - 2 * _marginH ) / (n -1);
}

-(void) numberOfBallVsSpace {
    bool stop = false;
    int n =3 ;
    while (!stop) {
        CGFloat space =  [self spaceBetweenBallCenterWhenNumberBallIsKnow: n];
        if (space< _ballDiameter) {
            stop= true;
        } else {
            NSLog(@"number  of ball %d, space between ball center %3.0f",n,space);
        }
        n++;
    }
}

-(void) drawRowOfBall: (int) numberBalls{
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnow: numberBalls];
    CGFloat spaceCol = [self spaceBetweenRowBallCenterWhenNumberBallIsKnown: numberBalls];
    
    for (int j =0; j < numberBalls; j++) {
        for (int i = 0; i < numberBalls; i++){
            [self placeGrayBallAtX: _margin + i* space  andY:_marginH +j*spaceCol  withTag: i +100];
        }
    }
}

-(void) checkSizeOfApp{
    CGSize size =self.view.bounds.size;
    NSLog(@"width = %3.0f. height = %3.0f",size.width, size.height);
}

@end
