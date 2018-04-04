//
//  JMAutolayoutUtilities.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

__attribute__((visibility("default"))) @interface JMAutolayoutUtilities : NSObject

+ (UIView*)autolayoutView;
+ (UILabel*)autolayoutLabel;
+ (UILabel*)autolayoutLabelWithJustifiedParagraphStyleText: (NSString *) text;
+ (UIImageView*)autolayoutImageView;
+ (UIActivityIndicatorView*)autolayoutActivityIndicatorView;
+ (UIButton*)autolayoutButton;
+ (UITableView *)autolayoutTableViewWithTableViewStyle:(UITableViewStyle) tableViewStyle;

@end
