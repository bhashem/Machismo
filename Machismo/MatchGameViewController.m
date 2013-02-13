//
//  MatchGameViewController.m
//  Machismo
//
//  Created by Basil Hashem on 2/12/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "MatchGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface MatchGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) NSUInteger cardsForMatch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchStyleControl;
@property (nonatomic) BOOL gameStarted;

@end

@implementation MatchGameViewController

- (CardMatchingGame *)game
{
    [self checkMatchStatus];
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                               cardsToMatch:self.cardsForMatch];
        NSLog(@"game: Calling init with %i cards to match.",self.cardsForMatch);
    }
    return _game;
}

- (void) checkMatchStatus
{
    if (!self.cardsForMatch) self.cardsForMatch = 2;
    if (self.matchStyleControl.selectedSegmentIndex) {
        self.cardsForMatch = 3;
    } else {
        self.cardsForMatch = 2;
    }
}

- (void)updateUI
{
    self.matchStyleControl.enabled = !self.gameStarted;
    [super updateUI];
}

- (IBAction)matchStyleChanged:(UISegmentedControl *)sender {
    [self checkMatchStatus];
    [self resetGame];
}

- (IBAction)dealCards:(UIButton *)sender {
    [self checkMatchStatus];
    [self resetGame];
    [super updateUI];
    
}
- (void) resetGame
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                               cardsToMatch:self.cardsForMatch];
    [super resetGame];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMatchStyleControl:nil];
    [super viewDidUnload];
}

@end
