//
//  CustomScanOverlayViewController.m
//
//  Copyright © 2019 Jumio Corporation All rights reserved.
//

#import "CustomScanOverlayViewController.h"

@interface CustomScanOverlayViewController ()

@property (nonatomic, strong) IBOutlet UIButton *flashButton;
@property (nonatomic, strong) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (nonatomic, assign) BOOL isScanning;

@end

@implementation CustomScanOverlayViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //To change the vertical card frame offset in portrait orientation, set the following property (default = 0).
        self.verticalCardFrameOffset = -100.0;
        
        self.delegate = self;
        self.isScanning = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    _flashButton.layer.cornerRadius = 20.0;
    _cameraButton.layer.cornerRadius = 20.0;
    _closeButton.layer.cornerRadius = 20.0;
    _startStopButton.layer.cornerRadius = 20.0;
}

//Once viewWillAppear is called within your BAMCheckoutCustomScanOverlayViewController, you can perform the following actions:
// - Get location and dimension of card frame
// - Check if front and back camera available
// - Get camera position (front or back)
// - Switch between front and back camera
// - Check if flash available
// - Check if flash enabled
// - Switch flash mode (on or off)
// - Restart card scanning if retry possible
// - Stop card scanning

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![self hasFlash]) _flashButton.hidden = YES;
    if (![self hasMultipleCameras]) _cameraButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)flashBtnTapped:(id)sender {
    [self toggleFlash];
    
    NSString *btnTitle = ([self isFlashOn]) ? @"F+" : @"F-";
    [_flashButton setTitle:btnTitle forState:UIControlStateNormal];
}

- (IBAction)cameraBtnTapped:(id)sender {
    [self switchCamera];
    
    NSString *btnTitle = ([self currentCameraPosition] == JumioCameraPositionBack) ? @"C^" : @"Cv";
    [_cameraButton setTitle:btnTitle forState:UIControlStateNormal];
    
    if ([self hasFlash]) {
        _flashButton.hidden = NO;
    } else {
        _flashButton.hidden = YES;
    }
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startStop:(id)sender {
    if (self.isScanning) {
        [self stopScan];
    } else {
        [self retryScan];
    }
}

- (void) retryScan {
    [super retryScan];
    
    self.isScanning = YES;
    [self updateCaptureButton];
}

- (void) stopScan {
    [super stopScan];
    
    self.isScanning = NO;
    [self updateCaptureButton];
}

- (void) updateCaptureButton {
    if (self.isScanning) {
        [_startStopButton setTitle:@">" forState:UIControlStateNormal];
    } else {
        [_startStopButton setTitle:@"||" forState:UIControlStateNormal];
    }
}


#pragma mark - BAMCheckoutCustomScanOverlayViewControllerDelegate

/**
 * This method is called when an error occured while the ScanViewController is opend
 * @param error The error codes 200, 210, 220, 240, 300 and 320 will be returned.
 * @param retryPossible indicates whether [self retryScan] can be called or not
 **/
- (void) bamCheckoutStoppedWithError:(NSError *)error retryPossible:(BOOL)retryPossible {
    NSString *retryString = (retryPossible) ? @"retry possible" : @"no retry possible";

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%ld", (long)error.code]
                                                                             message:error.localizedDescription
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
     [alertController addAction:[UIAlertAction actionWithTitle:@"close" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:retryString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self retryScan];
    }]];

    
     [self presentViewController:alertController animated:YES completion:nil];

}

@end
