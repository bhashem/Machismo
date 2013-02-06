//
//  CardGameViewController.m
//  Machismo
//
//  Created by Basil Hashem on 1/24/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//


// setTitle:forState:


#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong,nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipLabel;
@property (nonatomic) BOOL gameStarted;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchStyleControl;
@property (nonatomic) NSUInteger cardsForMatch;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) NSMutableArray *history; // of flip message strings
@property BOOL musicPlaying;


@end

@implementation CardGameViewController

- (NSMutableArray *) history
{
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (CardMatchingGame *)game
{
    [self checkMatchStatus];
//    NSLog(@"game: Calling init with %i cards to match.",self.cardsForMatch);
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc] init]
                                                       cardsToMatch:self.cardsForMatch];
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) updateUI
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
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastFlipLabel.alpha = 1;
    self.lastFlipLabel.text = self.game.lastFlipMessage;
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    if (!self.gameStarted) self.gameStarted = YES;
    [self updateUI];
    [self.history addObject:[[NSString alloc] initWithString:self.game.lastFlipMessage]];
    self.historySlider.enabled = YES;
    [self.historySlider setMaximumValue:[self.history count]]; // Set the max size of the slide to the number of messages previously shown
    [self.historySlider setValue:self.historySlider.maximumValue animated:YES];

}

- (IBAction)dealCards:(UIButton *)sender {
    [self checkMatchStatus];
    [self resetGame];
    [self updateUI];
    
}

- (void) resetGame
{
//    NSLog(@"Resetting game with %i cards to match.",self.cardsForMatch);
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                               cardsToMatch:self.cardsForMatch];
    self.flipCount = 0;
    self.gameStarted = NO;
    self.history = [[NSMutableArray alloc] init];

    [self.historySlider setValue:0 animated:YES];
    self.historySlider.enabled = NO;
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

- (IBAction)matchStyleChanged:(UISegmentedControl *)sender {
    [self checkMatchStatus];
    [self resetGame];
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


- (void)viewDidUnload {
    [self setCardButtons:nil];
    [self setScoreLabel:nil];
    [self setLastFlipLabel:nil];
    [self setMatchStyleControl:nil];
    [self setHistorySlider:nil];
    [super viewDidUnload];
}
@end
