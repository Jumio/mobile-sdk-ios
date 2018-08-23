//
//  JMScanMockHelper.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMCaptureSessionManager;

__attribute__((visibility("default"))) @interface JMScanMockHelper : NSObject

- (instancetype _Nullable) initWithCaptureSessionManager:(JMCaptureSessionManager * _Nonnull)captureSessionManager;

- (BOOL) shouldDisplayRecordButton;
- (BOOL) isExtendedDebuggingEnabled;

- (NSString * _Nullable) videoMockWriterPath;
- (void) addRecordButtonToView:(UIView * _Nonnull)view;
- (void) recordButtonTapped;
- (void) stopRecording;
- (void) startMocking;
- (void) stopMocking;
- (NSString * _Nullable) mockPath;

@end
