//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Basil Hashem on 1/30/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@property (readwrite, nonatomic) NSString *lastFlipMessage;
@property (nonatomic) NSUInteger cardsToMatch;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    int moreScore;

    if (self.cardsToMatch == 2) {
    // Two Card Logic
        if (card && !card.isUnplayable) {
            if (!card.isFaceUp) {
                self.lastFlipMessage = [NSString stringWithFormat:@"Flipped up %@\nThat cost 1 point", card.contents];
            NSMutableAttributedString *mat1 = [[NSMutableAttributedString alloc] initWithString:@"Flipped up "];
            [mat1 appendAttributedString:card.attributedContents];
            [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"\nThat cost 1 point"]];
                self.lastFlipMessageAttributed = mat1;
                
                for (Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp & !otherCard.isUnplayable) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            card.unplayable = YES;
                            otherCard.unplayable = YES;
                            moreScore = matchScore * MATCH_BONUS;
                            self.score += moreScore;
                            self.lastFlipMessage = [NSString stringWithFormat:@"Matched %@ and %@\nAdding %d points", otherCard.contents, card.contents, moreScore];
                            NSMutableAttributedString *mat1 = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
                            [mat1 appendAttributedString:otherCard.attributedContents];
                            [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"and "]];
                            [mat1 appendAttributedString:card.attributedContents];
                            [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"\nAdding %d points", moreScore]]];
                            self.lastFlipMessageAttributed = mat1;
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.lastFlipMessage = [NSString stringWithFormat:@"%@ and %@ don't match!\n%d point penalty", otherCard.contents, card.contents, MISMATCH_PENALTY];
                            NSMutableAttributedString *mat1 = [[NSMutableAttributedString alloc] initWithAttributedString:otherCard.attributedContents];
                            [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
                            [mat1 appendAttributedString:card.attributedContents];
                            [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"don't match!\n%d point penalty", MISMATCH_PENALTY]]];
                            self.lastFlipMessageAttributed = mat1;
                        }
                        break;
                    }
                }
                self.score -= FLIP_COST;
            }
            card.faceUp = !card.isFaceUp;
        }
    } else {
    // Three Card Logic
        int faceUpCount = 0;
        NSMutableArray *upCards = [NSMutableArray array];
/*    When a card is flipped:
      If it was faced up, face it down.
      If it was faced down, and there are <2 other cards faced up, face it up.
      If it was faced down, and there are 2 other cards faced up, compute the match.
      It they match, update score and make all 3 cards unplayable.
      If they do not match, face down the 2 cards faced up and face up the card you last flipped. */
        if (card && !card.isUnplayable) {
            if (card.isFaceUp) {
                // Card was face up, just put it back, no penalty
                card.faceUp = NO;
            } else {
                // Count number of face up cards
                faceUpCount = 0;
                for (Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        [upCards addObject:otherCard];
                        faceUpCount++;
                    }
                }
                if (faceUpCount < 2) {
                    card.faceUp = YES;
                    self.lastFlipMessage = [NSString stringWithFormat:@"Flipped up %@\nThat cost 1 point", card.contents];
                NSMutableAttributedString *mat1 = [[NSMutableAttributedString alloc] initWithString:@"Flipped up "];
                [mat1 appendAttributedString:card.attributedContents];
                [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"\nThat cost 1 point"]];
                self.lastFlipMessageAttributed = mat1;
                    self.score -= FLIP_COST;                    
                } else {
                    int matchScore = [card match:upCards];
                    Card *c1 = upCards[0];
                    Card *c2 = upCards[1];
                    if (!matchScore) {
                        self.score -= MISMATCH_PENALTY;
                        self.lastFlipMessage = [NSString stringWithFormat:@"%@, %@ and %@ don't match!\n%d point penalty", c1.contents, c2.contents, card.contents, MISMATCH_PENALTY];
                        
                        NSMutableAttributedString *mat1 = [[NSMutableAttributedString alloc] initWithAttributedString:c1.attributedContents];
                        [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
                        [mat1 appendAttributedString:c2.attributedContents];
                        [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
                        [mat1 appendAttributedString:card.attributedContents];
                        [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"don't match!\n%d point penalty", MISMATCH_PENALTY]]];
                        self.lastFlipMessageAttributed = mat1;

                        card.faceUp = YES;
                        c1.faceUp = NO;
                        c2.faceUp = NO;
                    } else {
                        moreScore = matchScore * MATCH_BONUS;
                        self.score += moreScore;
                        self.lastFlipMessage = [NSString stringWithFormat:@"Matched %@, %@ and %@\nAdding %d points", c1.contents, c2.contents, card.contents, moreScore];
                        NSMutableAttributedString *mat1 = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
                        [mat1 appendAttributedString:c1.attributedContents];
                        [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
                        [mat1 appendAttributedString:c2.attributedContents];
                        [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
                        [mat1 appendAttributedString:card.attributedContents];
                        [mat1 appendAttributedString:[[NSAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"\nAdding %d points", moreScore]]];
                        self.lastFlipMessageAttributed = mat1;

                        card.faceUp = YES;
                        card.unplayable = YES;
                        c1.unplayable = YES;
                        c2.unplayable = YES;
                    }
                }
            }
        }
    }
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
           cardsToMatch:(NSUInteger) cardCount
           withGameName:(NSString *)gameName
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
//                NSLog(@"Adding card - %@",[card description]);
            } else {
                self = nil;
                break;
            }
        }
        self.lastFlipMessage = @" ";
        self.lastFlipMessageAttributed = nil;
        self.cardsToMatch = cardCount;
        self.gameName = gameName;
    }
    return self;
}

- (NSString *) description
{
    NSString *cstr;
    cstr = @"";
    for (Card *c in self.cards) {
        [cstr stringByAppendingFormat:@"%@\n",[c description]];
    }
    return [NSString stringWithFormat:@"Name=%@ Score=%d CardsToMatch=%d\nMsg:%@\n%@",self.gameName, self.score, self.cardsToMatch, self.lastFlipMessage, cstr];
}

@end
