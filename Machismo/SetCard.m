//
//  SetCard.m
//  Machismo
//
//  Created by Basil Hashem on 2/10/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//
// ☐△◯

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // Code to match 3 cards
    SetCard *c1 = otherCards[0];
    SetCard *c2 = otherCards[1];
    
    // Detect what kind of matches there are for each attribute
    BOOL numbersMatch = ((c1.number == self.number) &&
                         (c2.number == self.number));
    BOOL shapeMatch = ([c1.shape isEqualToString:self.shape]) &&
                         ([c2.shape isEqualToString:self.shape]);
    BOOL shadingMatch = ((c1.shading == self.shading) &&
                         (c2.shading == self.shading));
    BOOL colorMatch = ((c1.color == self.color) &&
                         (c2.color == self.color));
    
    // Try AND'ing the various combinations
    if (numbersMatch && shapeMatch && shadingMatch) score = 4;
    if (numbersMatch && shapeMatch && colorMatch) score = 4;
    if (numbersMatch && shadingMatch && colorMatch) score = 4;
    if (shapeMatch && shadingMatch && colorMatch) score = 4;

    // Support the wacky match where everything is different
    if (numbersMatch && shapeMatch && shadingMatch && colorMatch) score = 8;
    
    return score;
}

- (NSString *) contents
{
    return [@"" stringByPaddingToLength:self.number withString: self.shape startingAtIndex:0];
}

// Class Method to valide shape content values
+ (NSArray *)validShapes
{
    return @[@"☐",@"△",@"◯"];
}


@synthesize shape = _shape; // because we provide setter AND getter

- (void) setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (NSString *) shape
{
    return _shape ? _shape : @"?";
}


@end
