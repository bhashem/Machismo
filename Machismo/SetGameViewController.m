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
#import "SetCard.h"

@interface SetGameViewController ()
@property (strong,nonatomic) Deck *deck;
@property (nonatomic) BOOL setgameStarted;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]
                                               cardsToMatch:3
                                               withGameName:@"Set"];
        NSLog(@"game: Calling init for Set game.");
    }
    return _game;
}


- (void) updateUI
{
    UIColor *blue = [UIColor blueColor];
    UIColor *blue_half = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.3];
    UIColor *red = [UIColor redColor];
    UIColor *red_half = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3];
    UIColor *green = [UIColor greenColor];
    UIColor *green_half = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.3];
    UIColor *hollow_color = [UIColor colorWithWhite:0.0 alpha:0.0];
    UIColor *chosen_color;

    NSLog(@"Calling Update UI for Set game");
    for (UIButton *cardButton in self.cardButtons) {
        // It's bad to cast, why do we need this?
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        NSLog(@"Slot %d: %@", [self.cardButtons indexOfObject:cardButton], [card description]);
        
        // Determine what color to use
        if (card.color == kRed) chosen_color = red;
        if (card.color == kBlue) chosen_color = blue;
        if (card.color == kGreen) chosen_color = green;
        NSMutableAttributedString *mat = [card.attributedContents mutableCopy];
        [mat addAttribute:NSStrokeColorAttributeName
                                        value:chosen_color
                                        range:NSMakeRange(0, [card.attributedContents length])];
        [mat addAttribute:NSStrokeWidthAttributeName
                    value:@-5
                    range:NSMakeRange(0, [card.attributedContents length])];

        // Deal with shading
        if (card.shading == kFilled) {
            [mat addAttribute:NSForegroundColorAttributeName
                        value:chosen_color
                        range:NSMakeRange(0, [card.attributedContents length])];
        }
        if (card.shading == kHalf) {
            UIColor *f_color;
            if (card.color == kRed) f_color = red_half;
            if (card.color == kBlue) f_color = blue_half;
            if (card.color == kGreen) f_color = green_half;

            [mat addAttribute:NSForegroundColorAttributeName
                    value:f_color
                    range:NSMakeRange(0, [card.attributedContents length])];
        }
        if (card.shading == kHollow) {
            [mat addAttribute:NSForegroundColorAttributeName
                        value:hollow_color
                        range:NSMakeRange(0, [card.attributedContents length])];
        }
        [cardButton setAttributedTitle:mat forState:UIControlStateNormal];
        cardButton.selected = card.faceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.0 : 1.0); // Really should make it disappear, change to 0.0
        
        [cardButton setBackgroundColor:(cardButton.isSelected) ? [UIColor lightGrayColor] : nil];
    }

    [super updateUI];
}

- (IBAction)dealCards:(UIButton *)sender {
    [self resetGame];
    [self updateUI];
    NSLog(@"Set Game: deal cards");
}

- (void) resetGame
{
    NSLog(@"Resetting Set game");
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]
                                               cardsToMatch:3
                                               withGameName:@"Set"];
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
