//
//  PlayingCard.h
//  Machismo
//
//  Created by Basil Hashem on 1/26/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
