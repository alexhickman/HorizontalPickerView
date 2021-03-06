//
//  ViewController.m
//  HorizontalPickerView
//
//  Created by Hickman on 3/14/16.
//  Copyright © 2016 Hickman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *pickerViewArray;
    NSMutableArray *pickerDataTen;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:151.0/255 green:80.0/255 blue:8.0/255 alpha:1.0f];

    UIImageView *keypad = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"keypad"]];
    pickerDataTen = [[NSMutableArray alloc]init];
    pickerDataTen = [self makeArrayOfStringsTo:10];
    [pickerDataTen addObject:keypad];
    
//    self.myPickerView.frame = CGRectZero;
    self.myPickerView.frame = CGRectMake(0, 0, 100, 300);
    self.myPickerView.delegate = self;
    self.myPickerView.showsSelectionIndicator = NO;
    self.myPickerView.backgroundColor = [UIColor clearColor];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [self.myPickerView setTransform:rotate];
    [self.myPickerView selectRow:[pickerDataTen count] inComponent:0 animated:NO];
    
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
        CGRect rect = CGRectMake(0, 0, 30, 30);
        UILabel *label = [[UILabel alloc]initWithFrame:rect];
        CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
        rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
        [label setTransform:rotate];
        label.text = [pickerDataTen objectAtIndex:(row % [pickerDataTen count])];
        label.font = [UIFont systemFontOfSize:25.0];
        label.textAlignment = 1;
        label.textColor = [UIColor yellowColor];
        label.backgroundColor = [UIColor clearColor];
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
