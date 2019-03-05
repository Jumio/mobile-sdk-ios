//
//  AuthenticationStartViewController.h
//
//  Copyright © 2019 Jumio Corporation. All rights reserved.
//

#import "StartViewController.h"

@interface AuthenticationStartViewController : StartViewController

@property (weak, nonatomic) IBOutlet UITextField *transactionReferenceTextField;

- (IBAction)startAuthentication;
- (IBAction)transactionRefernece_onDone;

@end
