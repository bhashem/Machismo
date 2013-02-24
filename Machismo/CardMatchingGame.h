//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Basil Hashem on 1/30/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
           cardsToMatch:(NSUInteger) cardCount
           withGameName:(NSString *)gameName;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (readonly,nonatomic) NSString *lastFlipMessage;
@property (nonatomic) NSMutableAttributedString *lastFlipMessageAttributed;
@property (strong,nonatomic) NSString *gameName;

@end
