//
//  JMAutolayoutUtilities.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

@interface JMAutolayoutUtilities : NSObject

+ (UIView*)autolayoutView;
+ (UILabel*)autolayoutLabel;
+ (UILabel*)autolayoutLabelWithJustifiedParagraphStyleText: (NSString *) text;
+ (UIImageView*)autolayoutImageView;
+ (UIActivityIndicatorView*)autolayoutActivityIndicatorView;
+ (UIButton*)autolayoutButton;
+ (UITableView *)autolayoutTableViewWithTableViewStyle:(UITableViewStyle) tableViewStyle;

@end
