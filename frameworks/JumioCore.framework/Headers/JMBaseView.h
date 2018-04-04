//
//  NSWBaseView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

__attribute__((visibility("default"))) @interface JMBaseView : UIView {
    @protected
    BOOL _shouldUpdateViewConstraints;
    BOOL _shouldUpdateSuperViewConstraints;
}

- (void) initControl;
- (void) hideSensitiveData:(BOOL)hide;
- (void) updateViewForOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
