//
//  NSWBaseView.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMBaseView : UIView {
    @protected
    BOOL _shouldUpdateViewConstraints;
    BOOL _shouldUpdateSuperViewConstraints;
}

- (void) initControl;
- (void) hideSensitiveData:(BOOL)hide;
- (void) updateViewForOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
