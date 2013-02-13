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
                                               cardsToMatch:self.cardsForMatch
                                               withGameName:@"Matching"];
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
    // If the game has started, then disable the match style control. If the game is reset or hasn't started, ensure that it's enabled
    self.matchStyleControl.enabled = !self.gameStarted;
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    
    // Iterate through the card buttons and set the various attributes
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        // We set the title when the card is selected
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        // ... and also when the card is selected and disabled - need both statements
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(10, 8, 10, 2);
        if (cardButton.isSelected) {
            [cardButton setImage:nil forState:UIControlStateNormal];
            [cardButton setImage:nil forState:UIControlStateSelected];
        } else {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
            [cardButton setImage:nil forState:UIControlStateSelected];
        }
        
    }

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
                                               cardsToMatch:self.cardsForMatch
                                               withGameName:@"Matching"];
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
