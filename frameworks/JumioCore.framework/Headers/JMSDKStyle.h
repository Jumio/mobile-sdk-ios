//
//  NSWAppStyle.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define JMColor_ExtraDarkGray RGBCOLOR(51.f, 51.f, 51.f)
#define JMColor_DarkGray RGBCOLOR(102.f, 102.f, 102.f)
#define JMColor_GrayTextColor RGBCOLOR(160.f,160.f,160.f)
#define JMColor_CellBackground_Enabled [UIColor colorWithWhite:1.f alpha:.8f]
#define JMColor_CellBackground_Disabled [UIColor colorWithWhite:1.f alpha:.3f]

#define JMColor_JumioGreen RGBCOLOR(151.0, 190.0, 13.0)
#define JMColor_ButtonDisabled RGBCOLOR(127.0, 127.0, 127.0)
#define JMColor_FlashIndicator [UIColor whiteColor]
#define JMColor_JumioWashedWhiteTitleColor RGBCOLOR(211.0, 211.0, 211.0)
#define JMColor_white RGBCOLOR(255.0, 255.0, 255.0)
#define JMColor_lightCellBackground RGBACOLOR(255.0, 255.0, 255.0, .3f)
#define JMColor_DarkGrayBackground RGBACOLOR(127.0, 127.0, 127.0, 0.6)

#define JMColor_cancelButton RGBCOLOR(103.0, 103.0, 103.0)
#define JMColor_cancelButtonHighlighted [UIColor darkGrayColor]
#define JMColor_cancelButtonDisabled [UIColor lightGrayColor]

#define JMColor_NVTextColor [UIColor colorWithWhite: 0.0 alpha: 0.65]
#define JMColor_NVTextColorDarker [UIColor colorWithWhite: 0.0 alpha: 0.8]
#define JMColor_NVLightTextColor [UIColor colorWithWhite: 1.0 alpha: 0.65]

#define JMColor_BAMTextColor [UIColor colorWithWhite: 0.0 alpha: 0.8]
#define JMColor_BAMTextColorDarker [UIColor colorWithWhite: 0.0 alpha: 0.85]
