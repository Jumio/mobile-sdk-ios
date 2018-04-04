//
//  BAMCheckoutStartViewController.h
//
//  Copyright © 2018 Jumio Corporation All rights reserved.
//

#import "StartViewController.h"

@interface BAMCheckoutStartViewController : StartViewController

@property (nonatomic, weak) IBOutlet UISwitch* switchCvvRequired;

- (IBAction) startBAMCheckout: (id) sender;

@end
