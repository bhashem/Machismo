//
//  SetCard.h
//  Machismo
//
//  Created by Basil Hashem on 2/10/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

typedef enum {
    kHollow,
    kHalf,
    kFilled
} ShadingType;

typedef enum {
    kRed,
    kGreen,
    kBlue
} ColorType;

@property (nonatomic) NSUInteger number;
@property (strong,nonatomic) NSString *shape;
@property (nonatomic) ShadingType shading;
@property (nonatomic) ColorType color;

+ (NSArray *)validShapes;

@end


