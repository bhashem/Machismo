//
//  CardGameViewController.m
//  Machismo
//
//  Created by Basil Hashem on 1/24/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "CardGameViewController.h"
#import "GameResult.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipLabel;
@property (nonatomic) BOOL gameStarted;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) NSMutableArray *history; // of flip message strings
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

- (GameResult *) gameResult
{
    if (!_gameResult ) {
        _gameResult = [[GameResult alloc] init];
    }
    return _gameResult;
}

- (NSMutableArray *) history
{
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}


- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void) updateUI
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastFlipLabel.alpha = 1;
    self.lastFlipLabel.text = self.game.lastFlipMessage;
}

- (void) resetGame
{
    //    NSLog(@"Resetting game with %i cards to match.",self.cardsForMatch);
    self.flipCount = 0;
    self.gameStarted = NO;
    self.gameResult = nil;
    self.history = [[NSMutableArray alloc] init];
    
    [self.historySlider setValue:0 animated:YES];
    self.historySlider.enabled = NO;
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    if (!self.gameStarted) self.gameStarted = YES;
    [self updateUI];
    self.gameResult.score = self.game.score;
    [self.history addObject:[[NSString alloc] initWithString:self.game.lastFlipMessage]];
    self.historySlider.enabled = YES;
    [self.historySlider setMaximumValue:[self.history count]]; // Set the max size of the slide to the number of messages previously shown
    [self.historySlider setValue:self.historySlider.maximumValue animated:YES];

}

- (IBAction)sliderMoved:(UISlider *)sender {
    NSString *msg;
    
    //    NSLog(@"Value of slider is: %f",sender.value);
    NSUInteger step = (NSUInteger)roundf(sender.value);
    //    NSLog(@"Step value is: %i",step);
    //    NSLog(@"Array size is: %i",[self.history count]);
    if (step) {
        msg = [self.history objectAtIndex:step-1];
    } else {
        msg = @" ";
    }
    self.lastFlipLabel.alpha = 0.4;
    self.lastFlipLabel.text = msg;
}

// In ViewDidLoad
    // REALLY SHOULD RESET THE GAME SO THAT THE SCORES DON'T MIX

- (void)viewDidUnload {
    [self setCardButtons:nil];
    [self setScoreLabel:nil];
    [self setLastFlipLabel:nil];
    [self setHistorySlider:nil];
    [super viewDidUnload];
}

@end
