//
//  SetGameViewController.m
//  Machismo
//
//  Created by Basil Hashem on 2/10/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface SetGameViewController ()
@property (strong,nonatomic) Deck *deck;
@property (nonatomic) BOOL setgameStarted;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetGameViewController

@synthesize game = _game;

- (IBAction)dealCards:(UIButton *)sender {
    [self resetGame];
    [self updateUI];
    NSLog(@"Set Game: deal cards");
}


- (CardMatchingGame *)game
{
    NSLog(@"game: Calling init for Set game");
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]
                                               cardsToMatch:3];
        NSLog(@"game: Calling init for Set game.");
    }
    return _game;
}


- (void) updateUI
{
    NSLog(@"Calling Update UI for Set game");
    [super updateUI];
}

- (IBAction)flipCard:(UIButton *)sender
{
    NSLog(@"Calling flipCard for Set game");
}

- (void) resetGame
{
    NSLog(@"Resetting Set game");
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]
                                               cardsToMatch:3];
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
    // REALLY SHOULD RESET THE GAME SO THAT THE SCORES DON'T MIX
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCardButtons:nil];
    [super viewDidUnload];
}
@end
