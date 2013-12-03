//
//  TipViewController.m
//  tipcalculator
//
//  Created by Christine Wang on 12/2/13.
//  Copyright (c) 2013 Christine Wang. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"
#import "Constants.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)initializeValues;
- (void)onSettingsButton;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    [self initializeValues];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)initializeValues {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int tipIndex = [defaults integerForKey:DEFAULT_TIP_INDEX_SETTING];
    self.tipControl.selectedSegmentIndex = tipIndex;
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];    
    float tipAmount = billAmount * [self.tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    settingsViewController.tipValues = self.tipValues;
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self initializeValues];
    [self updateValues];
}

@end
