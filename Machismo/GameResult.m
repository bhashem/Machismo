//
//  GameResult.m
//  Machismo
//
//  Created by Basil Hashem on 2/6/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult


#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"


+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    return allGameResults;
}

- (NSComparisonResult)compareDate:(GameResult *)otherObject {
    return [self.start compare:otherObject.start];
}

- (NSComparisonResult)compareScore:(GameResult *)otherObject {
    int diff =  self.score - otherObject.score;
	if (diff > 0) return NSOrderedDescending;
	if (diff < 0) return NSOrderedAscending;
	return NSOrderedSame;
}

- (NSComparisonResult)compareDuration:(GameResult *)otherObject {
    NSTimeInterval diff =  self.duration - otherObject.duration;
	if (diff > 0) return NSOrderedDescending;
	if (diff < 0) return NSOrderedAscending;
	return NSOrderedSame;
}

//convenience initializer
- (id) initFromPropertyList: (id)plist
{
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *) plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            if (!_start || !_end) self = nil;
        }
    }
    return self;
}

-(void) synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList
{
    return @{ START_KEY: self.start, END_KEY : self.end, SCORE_KEY : @(self.score) };
}

// designated initializer
- (id)init
{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (NSTimeInterval) duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

- (void) setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

@end
