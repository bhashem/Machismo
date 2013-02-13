//
//  SettingsViewController.m
//  Machismo
//
//  Created by Basil Hashem on 2/10/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameResult.h"

@interface SettingsViewController ()
//@property (weak, nonatomic) IBOutlet UISegmentedControl *DefaultGameSegmentedControl;

@end

@implementation SettingsViewController


- (IBAction)resetGameScores {
    UIActionSheet *resetAllScoresConfirmation = [[UIActionSheet alloc]
        initWithTitle:@"Are you sure you want to reset all scores?"
        delegate:self
        cancelButtonTitle:@"Cancel"
        destructiveButtonTitle:@"Reset Scores"
        otherButtonTitles:nil];
    [resetAllScoresConfirmation setActionSheetStyle:UIActionSheetStyleDefault];
    [resetAllScoresConfirmation showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet
        clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: // Reset Scores
            [GameResult resetAllScores];
            break;
        case 1: // Cancel
            break;
    }
}

#define DEFAULT_GAME @"DefaultGame"

- (IBAction)selectDefaultGame:(UISegmentedControl *)sender {
    NSUInteger gameDefault;
    if (sender.selectedSegmentIndex) {
        NSLog(@"Setting Set game as default");
        gameDefault = 1;
    } else {
        NSLog(@"Setting Match game as default");
        gameDefault = 0;
    }
    // Save setting into userDefaults
    // Reset the starting view controller for the tabbar
    // Update the tabbar with the selected tab index
//    [[NSUserDefaults standardUserDefaults] setInteger:gameDefault forKey:DEFAULT_GAME];
//    [[NSUserDefaults standardUserDefaults] synchronize];

//    [self.tabBarController setSelectedIndex:gameDefault];
}

// When loading this view, we should read the NSUserDefaults and set
// the UISegementedControl to the value that is read from NSUserDefaults

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"OK, we loaded the setings view");

//    NSUInteger def_game = [[NSUserDefaults standardUserDefaults] integerForKey:DEFAULT_GAME];
//    NSLog(@"Def game = %d", def_game);
//    self.DefaultGameSegmentedControl.selectedSegmentIndex = def_game;
}

- (void)viewDidUnload {
//    [self setDefaultGameSegmentedControl:nil];
    [super viewDidUnload];
}
@end