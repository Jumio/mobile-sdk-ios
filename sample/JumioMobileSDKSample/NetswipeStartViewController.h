//
//  NetswipeStartViewController.h
//
//  Copyright © 2017 Jumio Corporation All rights reserved.
//

#import "StartViewController.h"

@interface NetswipeStartViewController : StartViewController

@property (nonatomic, weak) IBOutlet UISwitch* switchCvvRequired;

- (IBAction) startNetswipe: (id) sender;

@end
