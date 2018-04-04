//
//  JMLoadingTableViewCell.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <JumioCore/JumioCore.h>

extern const CGFloat JMLoadingTableViewCellRightMargin;

__attribute__((visibility("default"))) @interface JMLoadingTableViewCell : JMBaseTableViewCell

@property (nonatomic, assign, getter=isLoading) BOOL loading;

@end
