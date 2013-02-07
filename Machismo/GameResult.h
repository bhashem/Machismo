//
//  GameResult.h
//  Machismo
//
//  Created by Basil Hashem on 2/6/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; // of GameResults

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

// sortItemsUsing Selector ; selector is compare in game result
//
@end
