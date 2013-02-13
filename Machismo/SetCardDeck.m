//
//  SetCardDeck.m
//  Machismo
//
//  Created by Basil Hashem on 2/11/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(id) init
{
    self = [super init];
    
    if (self) {
        for (NSUInteger number=1; number <= 3; number++) {
            for (NSString *shape in [SetCard validShapes]) {
                for (NSUInteger color=kRed;color <= kBlue; color++) {
                    for (NSUInteger shading=kHollow;shading <=kFilled;shading++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.shape = shape;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}
    
@end