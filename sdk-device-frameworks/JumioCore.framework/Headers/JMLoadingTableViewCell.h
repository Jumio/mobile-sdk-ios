//
//  JMLoadingTableViewCell.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <JumioCore/JumioCore.h>

extern const CGFloat JMLoadingTableViewCellRightMargin;

@interface JMLoadingTableViewCell : JMBaseTableViewCell

@property (nonatomic, assign, getter=isLoading) BOOL loading;

@end
