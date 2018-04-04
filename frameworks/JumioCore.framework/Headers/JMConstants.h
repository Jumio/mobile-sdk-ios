//
//  JMConstants.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#ifndef JumioMobileSDK_JMConstants_h
#define JumioMobileSDK_JMConstants_h

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#define kJMFocusThreshold        20
#define kJMIntensityThreshold    70

// string comparison tolerance level
#define kJMStringCompareToleranceLevel 0.2

#define kJMImageQualityThresholdROI     0.12

#define kJMBaseInfoViewDefaultPortraitHeight 51.0f

#endif
