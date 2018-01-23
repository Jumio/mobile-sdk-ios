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
 
 Copyright © 2017, UMOOVE.
 All Rights Reserved.
 The Umoove logo is a registered trademark of Umoove Company.
 Other brands and names are the property of their respective owners.

 Framework version 4.13.8
 
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

    
} UMEyeData;

// Umoove Engine Protocol
@protocol umooveDelegate <NSObject>


/* core v4 */
- (void) UMDataUpdate:(UMState)state :(UMHeadData)headData :(UMEyeData)eyeData;
- (void) UMBlinkUpdate:(int)blink;
- (void) UMStateChangeUpdate:(UMStateChange)state;


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
//v4 unity
- (int) getBlink;
- (float) getHeadPositionPxX;
- (float) getHeadPositionPxY;
- (float) getHeadMovementCmX;
- (float) getHeadMovementCmY;
- (int) getLeftIrisPositionReliability;
- (int) getRightIrisPositionReliability;
- (float) getLeftIrisMovementReliabilityX;
- (float) getLeftIrisMovementReliabilityY;
- (float) getRightIrisMovementReliabilityX;
- (float) getRightIrisMovementReliabilityY;
- (float) getLeftEstimatedIrisPositionX;
- (float) getLeftEstimatedIrisPositionY;
- (float) getRightEstimatedIrisPositionX;
- (float) getRightEstimatedIrisPositionY;
- (float) getEyeLineAngle;
- (float) getLeftIrisMovementCmX;
- (float) getLeftIrisMovementCmY;
- (float) getRightIrisMovementCmX;
- (float) getRightIrisMovementCmY;
- (int) getEyeMovementType;
- (float) getSmoothPursuitVectorX;
- (float) getSmoothPursuitVectorY;





- (NSString*)getVersion;

// funtions used when the client send the frames and are not initiated internally
- (id) initWithExternalFrames:(BOOL)externalFrames withGBRAformat:(BOOL)GBRAformat withKey:(uint32_t)key dynamicLibCode:(uint64_t)code;
- (void) processFrame:(uint8_t*)frame withWidth:(int)width withHeight:(int)height;

@end
