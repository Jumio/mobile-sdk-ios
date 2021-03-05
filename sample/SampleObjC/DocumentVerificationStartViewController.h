//
//  DocumentVerificationStartViewController.h
//
//  Copyright © 2021 Jumio Corporation All rights reserved.
//

#import "StartViewController.h"

@interface DocumentVerificationStartViewController : StartViewController

- (IBAction) startDocumentVerification: (id) sender;

@property (nonatomic, retain) IBOutlet UISwitch *enableExtraction;

@end
