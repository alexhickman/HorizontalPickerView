//
//  ViewController.h
//  HorizontalPickerView
//
//  Created by Hickman on 3/14/16.
//  Copyright © 2016 Hickman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

@end

