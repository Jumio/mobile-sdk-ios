/****************************** UMoove iOS Eye API Engine Header **********************************************************************************\
 
 The UmooveEngine is the main interface to the Umoove tracking process, through it a client interacts with the Umoove process.
 
 Disclaimers:
 THE INFORMATION IS FURNISHED FOR INFORMATIONAL USE ONLY, IS SUBJECT TO CHANGE WITHOUT NOTICE,
 AND SHOULD NOT BE CONSTRUED AS A COMMITMENT BY UMOOVE.
 UMOOVE ASSUMES NO RESPONSIBILITY OR LIABILITY FOR ANY ERRORS OR INACCURACIES THAT MAY APPEAR IN THIS DOCUMENT
 OR ANY SOFTWARE THAT MAY BE PROVIDED IN ASSOCIATION WITH THIS DOCUMENT.
 THIS INFORMATION IS PROVIDED "AS IS" AND UMOOVE DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY,
 RELATING TO THE USE OF THIS INFORMATION INCLUDING WARRANTIES RELATING TO FITNESS FOR A PARTICULAR PURPOSE,
 COMPLIANCE WITH A SPECIFICATION OR STANDARD, MERCHANTABILITY OR NONINFRINGEMENT.
 
 Legal Notices:
 
 Copyright © 2013, UMOOVE.
 All Rights Reserved.
 The Umoove logo is a registered trademark of Umoove Company.
 Other brands and names are the property of their respective owners.
 
 \************************************************************************************************************************************************/

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

/* core v4 */

typedef enum {
    UM_NULL_MOVEMENT = 0, UM_FIXATION = 1, UM_SMOOTH_PURSUIT = 2, UM_SACCADE = 3, UM_MICRO = 4,
} UMEyeMovementType;

typedef enum {
    UM_READY = 0, UM_DETECTING = 1, UM_TRACKING = 2
} UMState;

typedef enum {
    UM_DETECTED = 1, UM_NOT_DETECTED = 2, UM_LOST = 3
} UMStateChange;

typedef enum {
    UM_DEFAULT = 0, UM_INDIVIDUALLY = 1, UM_LEFT_EYE = 2, UM_RIGHT_EYE = 3,
} UMIrisTrackingMode;

typedef struct {
    CGPoint headPositionPx;
    CGVector headMovementCm;
} UMHeadData;

typedef struct {
    
    int leftIrisPositionReliability;
    int rightIrisPositionReliability;

    CGVector leftIrisMovementReliability;
    CGVector rightIrisMovementReliability;
    
    CGPoint leftEstimatedIrisPosition;
    CGPoint rightEstimatedIrisPosition;
    
    CGVector leftIrisMovementCm;
    CGVector rightIrisMovementCm;

    float eyeLineAngle;
    
    UMEyeMovementType eyeMovementType;
    CGVector smoothPursuitVector;
    
    float oevrallQualityLeft;
    float oevrallQualityRight;
    /* temp */
    
    // the iris position in the cameras frame coordinates, in order to draw the position in the devices coordinates, the values should be converted. For example if the video is displayed on the whole screen, in the devices position would be leftIrisPositionPx * deviceDimension / frameDimension. If the setHighResFrame is enabled then the frame will be the devices maximum size.
    CGPoint leftIrisPositionPx;
    CGPoint rightIrisPositionPx;
    
    // the irises radius in frame coordinates, conversion is similar to the iris position if needed. This value can be used to draw a circle bordering the users irises.
    float irisRadiusPx;
    
} UMEyeData;

// Umoove Engine Protocol
@protocol umooveDelegate <NSObject>

/* core v2 */
- (void) UMJoystickUpdate: (int)x : (int)y;
- (void) UMDirectionsUpdate: (int)x : (int)y;
- (void) UMCursorUpdate: (float)x : (float)y;
- (void) UMGestureUpdate:(int)horizontal : (int)vertical;
- (void) UMAbsolutePosition:(float)x :(float)y;
- (void) UMLinearSpeedUpdate:(float)x : (float)y;
- (void) UMStatesUpdate:(int)state;
/* to enable drastic head movements alerts, gestures must be enabled.
 0 - no alerts
 1 - device not stable
 2 - drastic head movements */
- (void) UMAlertsUpdate:(int)alert;

/* core v4 */
- (void) UMDataUpdate:(UMState)state :(UMHeadData)headData :(UMEyeData)eyeData;
- (void) UMBlinkUpdate:(int)blink;
- (void) UMStateChangeUpdate:(UMStateChange)state;

// gaze
- (void) UMPointOfGazeUpdate:(float)x :(float)y;

@end

@interface UMooveEngine : NSObject {
    
    // Umoove Engine Members
    id<umooveDelegate> umooveDelegate;
    int directionsX;
    int directionsY;
    float cursorX, cursorY, absolutePositionX, absolutePositionY;
    int joystickX, joystickY;
    int gestureX, gestureY;
    int state, alert;
    bool stateFlag, _gbraFormat, _externalFrames;
    
}

// Umoove Engine Properties
@property (assign) id<umooveDelegate> umooveDelegate;
@property (readwrite, assign) AVCaptureSession *captureSession;
@property (nonatomic, retain) NSString *deviceType;

// general methods
//- (id) initWithKey:(uint32_t)key;
- (id) initWithKey:(uint32_t)key dynamicLibCode:(uint64_t)code;
- (void) start:(BOOL)autoStart;
- (void) startWithPositions:(CGRect)leftEyeRectPosition rightEyeRectPosition:(CGRect) rightEyeRectPosition variance:(float)variance;
- (void) stop;
- (void) pause;
- (void) terminate;
- (void) reset;
- (void) stopSensors;
- (void) startSensors;

// setters
- (void) setAutoStart:(BOOL)autoStart;
- (void) setStableStart:(BOOL)stableStart;
- (void) setHighResFrame:(BOOL)isHighResFrame;
- (void) setFrontCamera:(BOOL)isFront;
- (void) setStrictEyeMovement:(BOOL)isStrict;

// getters
- (int) getState;
- (int) getAlert;

-(float) getDistance;

// enable functions with their setters

/* core v2 */
- (void) enableJoystick: (BOOL)isOn;

- (void) enableCursor: (BOOL)isOn;
- (void) setCursorSensitivity: (float)sensitivity HorizontalInitialPosition: (float)x VerticalInitialPosition: (float)y;

- (void) enableDirections: (BOOL)isOn;
- (void) setDirectionsSensitivity: (float)sensitivity CenterZone: (float)centerZone Levels: (int)levels;

- (void) enableGestures: (BOOL)isOn;
- (void) setGestureSensitivity: (float)sensitivity PreferenceRatio: (float)ratio AllowConsecutiveGestures: (BOOL)allow;

- (void) enableYesNo: (BOOL)isOn;
- (void) setYesNoSensitivity: (float)sensitivity AmountOfMovements: (int)amount;

- (void) enableLinearSpeed:(BOOL)isOn;

- (void) enableAbsolutePosition:(BOOL)isOn;

- (void) setLossSensitivity:(int)lossSensitivity;

/* core v4 */

- (void) enableEstimatedIrisPosition:(BOOL)isOn;

- (void) enableIrisMovement: (BOOL)isOn;

- (void) enableDistanceBetweenEyes:(BOOL)isOn;

- (void) enableHeadPosition:(BOOL)isOn;

- (void) enableHeadMovement:(BOOL)isOn;

- (void) enableBlink:(BOOL)isOn;

- (void) enablePointOfGaze:(BOOL)isOn;
- (void) calibratePointOfGaze;

- (void) enableHeadAngle:(BOOL)isOn;

- (void) enableEyeMovementType: (BOOL)isOn;

- (void) setIrisRadius:(float)radiusCm;
- (void) setEyeBallRadius:(float)radiusCm;
- (void) setDistanceBetweenEyes:(float)distanceCm;
- (void) setIrisTrackingMode:(UMIrisTrackingMode)mode;
- (void) setNonStrictMode:(BOOL)isOn;

// function when using for Unity using polling method
- (id) initWithPullingMethodWithKey:(uint32_t)key dynamicLibCode:(uint64_t)code;
- (int)getJoystickX;
- (int)getJoystickY;
- (int)getDirectionsX;
- (int)getDirectionsY;
- (int)getCursorX;
- (int)getCursorY;
- (float)getAbsolutePositionX;
- (float)getAbsolutePositionY;
- (float)getYflight;
- (int)getHorizontalGesture;
- (int)getVerticalGesture;
- (BOOL)getStateFlag;
- (void) resetStateFlag;
- (void) resetAlerts;
- (uint8_t*) getFrame;
- (int) getFrameWidth;
- (int) getFrameHeight;
- (void) subSessionStarted;
- (void) subSessionEnded;
- (void) setRGBformat:(BOOL)isRGB;

- (NSString*)getVersion;

// funtions used when the client send the frames and are not initiated internally
- (id) initWithExternalFrames:(BOOL)externalFrames withGBRAformat:(BOOL)GBRAformat withKey:(uint32_t)key dynamicLibCode:(uint64_t)code;
- (void) processFrame:(uint8_t*)frame withWidth:(int)width withHeight:(int)height;

@end
