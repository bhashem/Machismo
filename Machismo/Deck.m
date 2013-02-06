//
//  Deck.m
//  Machismo
//
//  Created by Basil Hashem on 1/26/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}



- (void)addCard:(id)card atTop:(BOOL)atTop
{
    if (card) {
        if (atTop) {
            [self.cards insertObject:card atIndex:0];
        } else {
            [self.cards addObject:card];
        }
    }
}


- (Card *)drawRandomCard
{
    Card *randomCard = nil;

    if (self.cards.count) {
        
    unsigned index = arc4random() % self.cards.count;
    randomCard = self.cards[index];
//    NSLog(@"Extracted card #%i of %i\n", index, self.cards.count);
    [self.cards removeObjectAtIndex:index];
    }

    return randomCard;
}

@end
