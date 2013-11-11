//
//  ListViewController.m
//  Heisenbug
//
//  Created by Ahmad Al-Ali on 8/17/13.
//  Copyright (c) 2013 Ahmad Al-Ali. All rights reserved.
//

#import "ListViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ListViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;

@property (weak, nonatomic) IBOutlet UIView *bugDetailBgView;
@property (weak, nonatomic) IBOutlet UIButton *bugStateButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UISlider *prioritySlider;
@property (weak, nonatomic) IBOutlet UISlider *severitySlider;
@property (weak, nonatomic) IBOutlet UISlider *statusSlider;
@property (weak, nonatomic) IBOutlet UITextView *bugDetailTextView;

@property (nonatomic) NSInteger selectedBugIndex;
@property (nonatomic) bugTypeButtonState selectedBugState;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.tabBarItem setTitle:NSLocalizedString(@"List",nil)];
        [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"btn-LIST-select"] withFinishedUnselectedImage:[UIImage imageNamed:@"btn-LIST"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createTopBar];
    
   // [self.tableHeaderView.layer setBorderColor:[UIColor whiteColor].CGColor];
   // [self.tableHeaderView.layer setBorderWidth:1.2f];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [self.tableHeaderView addGestureRecognizer:panGestureRecognizer];
    
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

    
}
- (void)viewDidUnload {
    [self setTableHeaderView:nil];
    [self setTableView:nil];
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
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];

    if ( self.tableHeaderView.frame.origin.y + translation.y <= 50){
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.tableHeaderView.frame = CGRectMake(self.tableHeaderView.frame.origin.x, 50, self.tableHeaderView.frame.size.width, self.tableHeaderView.frame.size.height);
            
            CGRect tableFrame = self.tableView.frame;
            tableFrame.origin = CGPointMake(0, 50 + self.tableHeaderView.frame.size.height);
            self.tableView.frame = tableFrame;
            
            
            [recognizer removeTarget:self action:NULL];
            
        } completion:nil];
    }

    
    CGRect tableHeaderFrame = self.tableHeaderView.frame;
    tableHeaderFrame.origin.y += translation.y;
    self.tableHeaderView.frame = tableHeaderFrame;
    
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.origin.y += translation.y;
    tableFrame.size.height = self.view.frame.size.height - self.tableHeaderView.frame.size.height - 50 ;
    self.tableView.frame = tableFrame;
    
    
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        

        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{

            self.tableHeaderView.frame = CGRectMake(self.tableHeaderView.frame.origin.x, 50, self.tableHeaderView.frame.size.width, self.tableHeaderView.frame.size.height);
           
            CGRect tableFrame = self.tableView.frame;
            tableFrame.origin = CGPointMake(0, 50 + self.tableHeaderView.frame.size.height);
            self.tableView.frame = tableFrame;
            
         
            [recognizer removeTarget:self action:NULL];

        } completion:nil];
        
    }

    
}
#pragma mark - UIActions
-(void)newBarButtonTapped:(id)sender{
    
    
}
-(void)deleteBarButtonTapped:(id)sender{
    
    
}
-(void)HBarButtonTapped:(id)sender{
    
    
}




@end
