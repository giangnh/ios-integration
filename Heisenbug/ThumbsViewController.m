//
//  SecondViewController.m
//  Heisenbug
//
//  Created by Ahmad Al-Ali on 8/12/13.
//  Copyright (c) 2013 Ahmad Al-Ali. All rights reserved.
//

#import "ThumbsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"

@interface ThumbsViewController ()<GMGridViewDataSource, GMGridViewActionDelegate>
{
   // __gm_weak GMGridView *_gmGridView;

    __gm_weak IBOutlet GMGridView *bugsGridView;
}
@property (nonatomic,strong)  NSArray *bugs;
@property (weak, nonatomic) IBOutlet UIView *bugDetailBgView;
@property (weak, nonatomic) IBOutlet UIButton *bugStateButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UISlider *prioritySlider;
@property (weak, nonatomic) IBOutlet UISlider *severitySlider;
@property (weak, nonatomic) IBOutlet UISlider *statusSlider;
@property (weak, nonatomic) IBOutlet UITextView *bugDetailTextView;

@property (nonatomic) NSInteger selectedBugIndex;
@property (nonatomic) bugTypeButtonState selectedBugState;


@end

@implementation ThumbsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Thumbs",nil);
        [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"btn-THUMBS-select"] withFinishedUnselectedImage:[UIImage imageNamed:@"btn-THUMBS"]];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self createTopBar];
    
    self.bugs = [NSArray arrayWithObjects:@"a",@"b",@"b",@"b",@"b",@"b", nil];
    [bugsGridView setBackgroundColor:[UIColor clearColor]];
    bugsGridView.scrollEnabled = YES;
    bugsGridView.showsHorizontalScrollIndicator = NO;
    bugsGridView.showsVerticalScrollIndicator = NO;
    bugsGridView.userInteractionEnabled = YES;
    bugsGridView.editing = NO;
    bugsGridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
    bugsGridView.itemSpacing = 2.5;
    bugsGridView.minEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    bugsGridView.centerGrid = YES;
    bugsGridView.actionDelegate = self;
    bugsGridView.dataSource = self;
    [bugsGridView reloadData];

    UIImage *sliderTrackImage = [[UIImage imageNamed: @"slider-scroll"] stretchableImageWithLeftCapWidth: 7 topCapHeight: 0];
    UIImage *sliderKnobImage = [UIImage imageNamed:@"slider-knob"];
    [self.prioritySlider setThumbImage:sliderKnobImage forState:UIControlStateNormal];
    [self.prioritySlider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.prioritySlider setMaximumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.severitySlider setThumbImage:sliderKnobImage forState:UIControlStateNormal];
    [self.severitySlider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.severitySlider setMaximumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.statusSlider setThumbImage:sliderKnobImage forState:UIControlStateNormal];
    [self.statusSlider setMinimumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    [self.statusSlider setMaximumTrackImage: sliderTrackImage forState: UIControlStateNormal];
    
    
    self.selectedBugState = bugTypeButtonStateBug;
    [self.bugStateButton setBackgroundImage:[UIImage imageNamed:@"btn-toggle-bug"] forState:UIControlStateNormal];
    [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn-rounded-orange"] forState:UIControlStateNormal];
    
    GMGridViewCell *cell = [bugsGridView cellForItemAtIndex:self.selectedBugIndex];
    ((UIImageView*)[cell.contentView viewWithTag:1010]).image = [UIImage imageNamed:@"thumbsquare-select"];
    
    
    self.bugDetailTextView.text = ((UILabel *)[cell viewWithTag:11]).text;

}
- (void)viewDidUnload {
    [self setBugDetailBgView:nil];
    bugsGridView = nil;
    [self setBugStateButton:nil];
    [self setDoneButton:nil];
    [self setPrioritySlider:nil];
    [self setSeveritySlider:nil];
    [self setStatusSlider:nil];
    [self setBugDetailTextView:nil];
    [super viewDidUnload];
}
-(void)createTopBar{
    
    UIView *topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [topBarView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgd-masthead"]];
    [bgImageView setContentMode:UIViewContentModeRedraw];
    [bgImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width - 100, 50)];
    bgImageView.center = topBarView.center;
    
    
    UIButton *HButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [HButton setFrame:CGRectMake(52.5, 5, 40, 37)];
    // [HButton setBackgroundImage:[UIImage imageNamed:@"logo-H"]  forState:UIControlStateNormal];
    [HButton addTarget:self action:@selector(HBarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newButton setFrame:CGRectMake(10, 5, 33, 33)];
    [newButton setBackgroundImage:[UIImage imageNamed:@"icon-new"]  forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(newBarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setFrame:CGRectMake(self.view.frame.size.width - 45, 5, 33, 33)];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"icon-delete"]  forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteBarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [topBarView addSubview:newButton];
    [topBarView addSubview:deleteButton];
    [topBarView addSubview:HButton];
    [topBarView addSubview:bgImageView];
    [self.view addSubview:topBarView];
    
}
#pragma mark - UIActions
-(void)newBarButtonTapped:(id)sender{
    
    
}
-(void)deleteBarButtonTapped:(id)sender{
    
    
}
-(void)HBarButtonTapped:(id)sender{
    
    
}

- (IBAction)bugTypeButtonTapped:(UIButton *)sender {
    
    
    if ( self.selectedBugState == bugTypeButtonStateBug){
        
        self.selectedBugState = bugTypeButtonStateFeature;
        [sender setBackgroundImage:[UIImage imageNamed:@"btn-toggle-feature"] forState:UIControlStateNormal];
    }else{
        
        self.selectedBugState = bugTypeButtonStateBug;
        [sender setBackgroundImage:[UIImage imageNamed:@"btn-toggle-bug"] forState:UIControlStateNormal];
    }
}

#pragma mark GMGridViewDataSource

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return 10;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    if ( IS_IPHONE_5){
        
        return CGSizeMake(100, 100);
        
    }else{
        
        return CGSizeMake(100, 80);

    }

}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    UILabel *titleLabel;
    UILabel *descriptionLabel;
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thumbsquare"]];
        bgImageView.tag = 1010;
        bgImageView.frame = view.frame;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, size.width, 12)];
        titleLabel.tag = 10;
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textAlignment = UITextAlignmentLeft;
        
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        descriptionLabel.tag = 11;
        descriptionLabel.textColor = [UIColor blackColor];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.font = [UIFont systemFontOfSize:12];
        descriptionLabel.textAlignment = UITextAlignmentLeft;
        descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
        descriptionLabel.numberOfLines = 0;

        [view addSubview:bgImageView];
        [view addSubview:titleLabel];
        [view addSubview:descriptionLabel];

        cell.contentView = view;
    }else{
        
        titleLabel = (UILabel*)[cell.contentView viewWithTag:10];
        descriptionLabel = (UILabel*)[cell.contentView viewWithTag:11];        
    }
    
    NSString *text = [NSString stringWithFormat:@"Thumb %d",index];
    for ( int i = 0 ; i < 6; i++){
        
        text = [text stringByAppendingString:text];
    }
    
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(size.width, size.height) lineBreakMode:UILineBreakModeWordWrap];
    
    [descriptionLabel setFrame:CGRectMake(5, titleLabel.frame.size.height + 5, textSize.width -10, textSize.height - 20)];
    
    titleLabel.text = @"title";
    descriptionLabel.text = text;
       
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return NO; //index % 2 == 0;
}

#pragma mark GMGridViewActionDelegate
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    GMGridViewCell *cell1 = [gridView cellForItemAtIndex:self.selectedBugIndex];
    ((UIImageView*)[cell1.contentView viewWithTag:1010]).image = [UIImage imageNamed:@"thumbsquare"];

    self.selectedBugIndex = position;
    GMGridViewCell *cell = [gridView cellForItemAtIndex:position];
    ((UIImageView*)[cell.contentView viewWithTag:1010]).image = [UIImage imageNamed:@"thumbsquare-select"];
    
    
    self.bugDetailTextView.text = ((UILabel *)[cell viewWithTag:11]).text;
    
    
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}



@end
