//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Christine Wang on 12/2/13.
//  Copyright (c) 2013 Christine Wang. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *defaultTipLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;

- (void)initializeValues;
- (void)updateValues;

- (IBAction)onTap:(id)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self updateValues];
}

- (void)initializeValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int tipIndex = [defaults integerForKey:DEFAULT_TIP_INDEX_SETTING];
    
    float tipValue = [self.tipValues[tipIndex] floatValue];
    
    self.defaultTipLabel.text = [NSString stringWithFormat:@"%0.0f%%", tipValue * 100];
    self.defaultTipControl.selectedSegmentIndex = tipIndex;
}

- (void)updateValues {
    
    int tipIndex = self.defaultTipControl.selectedSegmentIndex;
    float tipValue = [self.tipValues[tipIndex] floatValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:tipIndex forKey:DEFAULT_TIP_INDEX_SETTING];
    [defaults synchronize];
    
    self.defaultTipLabel.text = [NSString stringWithFormat:@"%0.0f%%", tipValue * 100];
    self.defaultTipControl.selectedSegmentIndex = tipIndex;
}


@end
