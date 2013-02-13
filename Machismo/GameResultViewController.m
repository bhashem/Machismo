//
//  GameResultViewController.m
//  Machismo
//
//  Created by Basil Hashem on 2/6/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

-(void)updateUI:(NSArray *)anArray
{
    NSString *displayText = @"Score Game\tDate & Time\t\tDuration\n";
    for (GameResult *result in anArray) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d - h:mm a"];
        //        [dateFormatter setDateFormat:@"MMM d, yyyy - h:mm a"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
        NSString *newDate = [dateFormatter stringFromDate:result.end];
        displayText = [displayText stringByAppendingFormat:@"%7d %@\t%@\t%0g secs\n", result.score, result.game,newDate, round(result.duration)];
    }
    self.display.text = displayText;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI:[GameResult allGameResults]];
}

- (void) setup
{
    // initialization that can't wait until viewDidLoad
}

- (void)awakeFromNib
{
    [self setup];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)sortByScore:(UIButton *)sender {
    NSArray *sortedArray;
    sortedArray = [[GameResult allGameResults] sortedArrayUsingSelector:@selector(compareScore:)];
    [self updateUI:sortedArray];
}
- (IBAction)sortByDate {
    NSArray *sortedArray;
    sortedArray = [[GameResult allGameResults] sortedArrayUsingSelector:@selector(compareDate:)];
    [self updateUI:sortedArray];
}
- (IBAction)sortByDuration {
    NSArray *sortedArray;
    sortedArray = [[GameResult allGameResults] sortedArrayUsingSelector:@selector(compareDuration:)];
    [self updateUI:sortedArray];
}

//compareDuration


- (void)viewDidUnload {
    [self setDisplay:nil];
    [super viewDidUnload];
}
@end
