//
//  testTableViewCell.h
//  HorizontalPickerView
//
//  Created by Hickman on 3/14/16.
//  Copyright © 2016 Hickman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface testTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end
