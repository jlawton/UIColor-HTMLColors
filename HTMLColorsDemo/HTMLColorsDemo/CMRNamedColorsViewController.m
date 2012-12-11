//
//  CMRNamedColorsViewController.m
//  HTMLColorsDemo
//
//  Created by James Lawton on 12/10/12.
//  Copyright (c) 2012 James Lawton. All rights reserved.
//

#import "CMRNamedColorsViewController.h"
#import "UIColor+HTMLColors.h"

static NSString *CellIdentifier = @"Cell";

// A simple table cell with a color square, textLabel and detailTextLabel
@interface CMRNamedColorTableViewCell : UITableViewCell
@property (nonatomic, strong) UIColor *color;
@end


@interface CMRNamedColorsViewController ()
@property (nonatomic, strong) NSArray *colorNames;
@end


@implementation CMRNamedColorsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.colorNames = [UIColor W3CColorNames];

    [self.tableView registerClass:[CMRNamedColorTableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.colorNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMRNamedColorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSString *colorName = self.colorNames[indexPath.row];
    UIColor *color = [UIColor colorWithW3CNamedColor:colorName];
    NSString *hexColor = [color hexStringValue];

    cell.color = color;
    cell.textLabel.text = colorName;
    cell.detailTextLabel.text = hexColor;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.colorSelected) {
        self.colorSelected(self.colorNames[indexPath.row]);
    }
}

@end


@implementation CMRNamedColorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView.image = [UIImage imageNamed:@"Transparent22"];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.color = nil;
}

- (UIColor *)color
{
    return self.imageView.backgroundColor;
}

- (void)setColor:(UIColor *)color
{
    self.imageView.backgroundColor = color;
}

@end
