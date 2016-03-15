//
//  TableViewController.m
//  HorizontalPickerView
//
//  Created by Hickman on 3/14/16.
//  Copyright © 2016 Hickman. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
{
    NSArray *pickerViewArray;
    NSMutableArray *pickerDataTen;
}

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:151.0/255 green:80.0/255 blue:8.0/255 alpha:1.0f];

    UIImageView *keypad = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"keypad"]];
    pickerDataTen = [[NSMutableArray alloc]init];
    pickerDataTen = [self makeArrayOfStringsTo:10];
    [pickerDataTen addObject:keypad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"testCell";
    testTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"testTableViewCell" bundle:nil] forCellReuseIdentifier:@"testCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    }
    
    cell.pickerView.frame = CGRectMake(0, 0, 100, 200);
    cell.pickerView.delegate = self;
    cell.pickerView.dataSource = self;
    cell.pickerView.showsSelectionIndicator = NO;
    cell.pickerView.backgroundColor = [UIColor clearColor];
    cell.pickerView.center = CGPointMake(cell.frame.size.width*0.75f, cell.frame.size.height/2);
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [cell.pickerView setTransform:rotate];
    cell.pickerView.center = CGPointMake(cell.frame.size.width - (cell.pickerView.frame.size.width/2), cell.frame.size.height/2);
    [cell.pickerView selectRow:[pickerDataTen count] inComponent:0 animated:NO];
    cell.backgroundColor = [UIColor colorWithRed:151.0/255 green:80.0/255 blue:8.0/255 alpha:1.0f];


    cell.labelName.text = @"woot";
    
    return cell;
}

-(NSMutableArray *)makeArrayOfStringsTo:(int)number
{
    NSMutableArray *arrayOfNumbers = [[NSMutableArray alloc]init];
    for (int i=0; i <= number; i++)
    {
        NSString *aValue = [NSString stringWithFormat:@"%d", i];
        [arrayOfNumbers addObject:aValue];
    }
    return arrayOfNumbers;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if ((row % [pickerDataTen count]) == ([pickerDataTen count]-1)) {
        UIView *myView = (UIImageView *)pickerDataTen[(row % [pickerDataTen count])];
        [myView setFrame:CGRectMake(0, 0, 30, 30)];
        CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
        rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
        [myView setTransform:rotate];
        // first convert to a UIImage
        UIGraphicsBeginImageContextWithOptions(myView.bounds.size, NO, 0);
        [myView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // then convert back to a UIImageView and return it
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        return imageView;
    }
    else
    {
        CGRect rect = CGRectMake(0, 0, 50, 50);
        UILabel *label = [[UILabel alloc]initWithFrame:rect];
        CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
        rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
        [label setTransform:rotate];
        label.text = [pickerDataTen objectAtIndex:(row % [pickerDataTen count])];
        label.font = [UIFont systemFontOfSize:35.0];
        label.textAlignment = 1;
        label.textColor = [UIColor yellowColor];
//        label.backgroundColor = [UIColor clearColor];
        label.backgroundColor = [UIColor colorWithRed:151.0/255 green:80.0/255 blue:8.0/255 alpha:1.0f];

        label.clipsToBounds = YES;
        return label;
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerDataTen count]*3;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //we want the selection to always be in the SECOND set (so that it looks like it has stuff before and after)
    if (row < [pickerDataTen count] || row >= (2 * [pickerDataTen count]) )
    {
        row = row % [pickerDataTen count];
        row += [pickerDataTen count];
        [pickerView selectRow:row inComponent:component animated:NO];
    }
}

@end
