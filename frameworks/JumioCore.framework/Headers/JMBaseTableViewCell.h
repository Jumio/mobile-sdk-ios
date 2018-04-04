//
//  NVTableViewCell.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

__attribute__((visibility("default"))) @interface JMBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL shouldUpdateSuperViewConstraints;
@property (nonatomic, assign) BOOL shouldUpdateViewConstraints;

- (void) initCell;

@end
