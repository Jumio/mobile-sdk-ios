//
//  NetverifyStartViewController.h
//
//  Copyright © 2020 Jumio Corporation All rights reserved.
//

#import "StartViewController.h"

@interface NetverifyStartViewController : StartViewController

@property (nonatomic, weak) IBOutlet UISwitch *switchEnableVerification;
@property (nonatomic, weak) IBOutlet UISwitch *switchEnableIdentityVerification;

- (IBAction) startNetverify: (id) sender;

@end
