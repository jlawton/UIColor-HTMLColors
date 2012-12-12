//
//  CMRColorInputViewController.m
//  HTMLColorsDemo
//
//  Created by James Lawton on 12/10/12.
//  Copyright (c) 2012 James Lawton. All rights reserved.
//

#import "CMRColorInputViewController.h"
#import "UIColor+HTMLColors.h"
#import "CMRNamedColorsViewController.h"


@interface CMRColorInputViewController ()
@property (nonatomic, strong) IBOutlet UITextField *colorInputField;
@property (nonatomic, strong) IBOutlet UIView *colorWell;
@property (nonatomic, strong) IBOutlet UILabel *hexLabel;
@property (nonatomic, strong) IBOutlet UILabel *rgbLabel;
@property (nonatomic, strong) IBOutlet UILabel *hslLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end


@implementation CMRColorInputViewController

- (void)dealloc
{
    [self.colorInputField removeTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self updateColorWithText:nil];
    [self.colorInputField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Named Colors" style:UIBarButtonItemStyleBordered target:self action:@selector(pushNamedColors)];

    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)pushNamedColors
{
    CMRNamedColorsViewController *namedColorsController = [[CMRNamedColorsViewController alloc] initWithStyle:UITableViewStylePlain];

    namedColorsController.colorSelected = ^(NSString *colorName) {
        [self.navigationController popViewControllerAnimated:YES];
        self.colorInputField.text = colorName;
        [self updateColorWithText:colorName];
    };

    [self.navigationController pushViewController:namedColorsController animated:YES];
}

- (void)updateColorWithText:(NSString *)text
{
    UIColor *color = [UIColor colorWithCSS:text];
    NSString *hex = [color hexStringValue];
    NSString *rgb = [color rgbStringValue];
    NSString *hsl = [color hslStringValue];

    self.colorWell.backgroundColor = color;
    self.hexLabel.text = hex;
    self.rgbLabel.text = rgb;
    self.hslLabel.text = hsl;
}

- (void)textChanged:(UITextField *)textField
{
    [self updateColorWithText:textField.text];
}

- (void)dismissKeyboard:(UITapGestureRecognizer *)tap
{
    [self.colorInputField resignFirstResponder];
}

@end
