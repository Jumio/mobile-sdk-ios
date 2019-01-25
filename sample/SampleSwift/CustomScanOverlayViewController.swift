//
//  CustomScanOverlayViewController.swift
//
//  Copyright © 2019 Jumio Corporation All rights reserved.
//

import BAMCheckout

class CustomScanOverlayViewController : BAMCheckoutCustomScanOverlayViewController, BAMCheckoutCustomScanOverlayViewControllerDelegate {
    
    @IBOutlet weak var flashButton:UIButton!;
    @IBOutlet weak var cameraButton:UIButton!;
    @IBOutlet weak var closeButton:UIButton!;
    @IBOutlet weak var startStopButton:UIButton!;
    
    var isScanning:Bool;
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.isScanning = false
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        //To change the vertical card frame offset in portrait orientation, set the following property (default = 0).
        self.verticalCardFrameOffset = -100.0
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.flashButton.layer.cornerRadius = 20.0
        self.cameraButton.layer.cornerRadius = 20.0
        self.closeButton.layer.cornerRadius = 20.0
        self.startStopButton.layer.cornerRadius = 20.0
    }
    
    @IBAction func flashBtnTapped() -> Void {
        self.toggleFlash()
        
        let btnTitle:String = self.isFlashOn() ? "F+" : "F-"
        self.flashButton.setTitle(btnTitle, for: UIControlState.normal)
    }
    
    @IBAction func cameraBtnTapped() -> Void {
        self.switchCamera()
        
        let btnTitle:String = (self.currentCameraPosition() == JumioCameraPositionBack) ? "C^" : "Cv"
        self.cameraButton.setTitle(btnTitle, for: UIControlState.normal)
        
        if (self.hasFlash()) {
            self.flashButton.isHidden = false
        } else {
            self.flashButton.isHidden = true
        }
    }
    
    @IBAction func close() ->Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startStop() -> Void {
        if (self.isScanning) {
            self.stopScan()
        } else {
            self.retryScan()
        }
    }
    
    override func retryScan() {
        super.retryScan()
        
        self.isScanning = true
        self.updateCaptureButton()
    }
    
    override func stopScan() {
        super.stopScan()
        
        self.isScanning = false
        self.updateCaptureButton()
    }
    
    func updateCaptureButton() -> Void {
        if (self.isScanning) {
            self.startStopButton.setTitle(">", for: UIControlState.normal)
        } else {
            self.startStopButton.setTitle("||", for: UIControlState.normal)
        }
    }
    
    func bamCheckoutStoppedWithError(_ error: Error!, retryPossible: Bool) {
        
        let retryString = retryPossible ? "retry possible" : "no retry possible"
        
        let alertController:UIAlertController = UIAlertController.init(title: String(describing: error), message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction.init(title: retryString, style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
