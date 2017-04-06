//
//  NVTableViewCell.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL shouldUpdateSuperViewConstraints;
@property (nonatomic, assign) BOOL shouldUpdateViewConstraints;

- (void) initCell;

@end
