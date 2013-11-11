//
//  CurrencyRateCell.h
//  Burgan
//
//  Created by AHMAD AL-ALI on 5/20/13.
//
//

#import <UIKit/UIKit.h>

@interface BugCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bugRankLabel;

@property (weak, nonatomic) IBOutlet UILabel *bugTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bugDetailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *speedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *advanceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mileStoneImageView;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@end
