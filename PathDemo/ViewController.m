//
//  ViewController.m
//  PathDemo
//
//  Created by Mudasir Ahmed on 6/13/14.
//  Copyright (c) 2014 MudasirWare. All rights reserved.
//

#import "ViewController.h"
#import "ScaleBounceController.h"

@interface ViewController ()
{
    int _originalW, _originalH;
}

@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@property (weak, nonatomic) IBOutlet UIImageView *plusButton;
@property (nonatomic) BOOL big;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _originalW = self.buttonsView.frame.size.width / 5;
    _originalH = self.buttonsView.frame.size.height / 5;
    
    self.buttonsView.frame = CGRectMake(self.buttonsView.frame.origin.x,
                                        self.buttonsView.frame.origin.y,
                                        _originalW,
                                        _originalH);
    self.big = false;
    
    for (UIButton *button in self.allButtons) {
        button.layer.cornerRadius = button.frame.size.width / 2;
        button.clipsToBounds = YES;
        button.layer.borderColor=[UIColor colorWithRed:104.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1].CGColor;
        button.layer.borderWidth=0.5f;
    }
    
    self.plusButton.layer.borderColor=[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102./255.0 alpha:1].CGColor;
    self.plusButton.layer.borderWidth=0.5f;
    self.plusButton.layer.cornerRadius =  self.plusButton.frame.size.width / 2;
    self.plusButton.clipsToBounds = YES;
    
    self.plusButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandPlus:)];
    [self.plusButton addGestureRecognizer:tapGesture1];
}

- (void)expandPlus:(UITapGestureRecognizer*)sender {
    
    if (!self.big) {
        [self performSelector:@selector(moveButtonsIntoPlace) withObject:nil afterDelay:0.3];
        self.big = TRUE;
    } else {
        [self performSelector:@selector(moveButtonsBackToOriginal) withObject:nil afterDelay:0.3];
        self.big = FALSE;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    
    for (UIButton *button in self.allButtons) {
        [button.layer removeAllAnimations];
    }
    
    // Set Face's coordinates
    self.plusButton.frame = CGRectMake(160, 346, 60, 60);
    self.plusButton.center = CGPointMake(60, [UIScreen mainScreen].applicationFrame.size.height - 60);
    
    self.buttonsView.center = self.plusButton.center;
    [self.view sendSubviewToBack:self.buttonsView];
}

- (void)moveButtonsBackToOriginal {
    
    id finalValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    // Make a Bounce Animation
    SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"transform"];
    bounceAnimation.fromValue = [NSValue valueWithCATransform3D:self.buttonsView.layer.transform];
    bounceAnimation.toValue = finalValue;
    bounceAnimation.duration = 0.5f;
    bounceAnimation.numberOfBounces = 1;
    bounceAnimation.shouldOvershoot = YES;
    
    // Add a bounce animation
    [self.buttonsView.layer addAnimation:bounceAnimation forKey:@"bounceUp"];
    [self.buttonsView.layer setValue:finalValue forKeyPath:@"transform"];
}

- (void)moveButtonsIntoPlace {
    id finalValue = [NSValue valueWithCATransform3D:CATransform3DScale(self.buttonsView.layer.transform, 5.0, 5.0, 5.0)];
    
    // Make a Bounce Animation
    SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"transform"];
    bounceAnimation.fromValue = [NSValue valueWithCATransform3D:self.buttonsView.layer.transform];
    bounceAnimation.toValue = finalValue;
    bounceAnimation.duration = 0.5f;
    bounceAnimation.numberOfBounces = 4;
    bounceAnimation.shouldOvershoot = YES;
    
    // Add a bounce animation
    [self.buttonsView.layer addAnimation:bounceAnimation forKey:@"bounceUp"];
    [self.buttonsView.layer setValue:finalValue forKeyPath:@"transform"];
}

@end
