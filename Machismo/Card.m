//
//  Card.m
//  Machismo
//
//  Created by Basil Hashem on 1/26/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

- (NSAttributedString *)attributedContents
{
    return _attributedContents ? _attributedContents : [[NSAttributedString alloc] initWithString:self.contents];
}

@end
