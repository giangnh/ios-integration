//
//  FirstViewController.m
//  Heisenbug
//
//  Created by Ahmad Al-Ali on 8/12/13.
//  Copyright (c) 2013 Ahmad Al-Ali. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "RankViewController.h"
#import "BugCell.h"
#import "BRScrollBarController.h"
@interface RankViewController ()
@property (weak, nonatomic) IBOutlet UITableView *rankingTableView;
@property (weak, nonatomic) IBOutlet UITableView *trendingTableView;

@property (nonatomic,strong)  NSArray *bugs;

@end

@implementation RankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self.tabBarItem setTitle:NSLocalizedString(@"Rank",nil)];
        [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"btn-RANK-select"] withFinishedUnselectedImage:[UIImage imageNamed:@"btn-RANK"]];
        
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createTopBar];
    
    
    
//    UIColor *forColor = [UIColor colorWithRed:253.0/255.0 green:159.0/255.0 blue:70.0/255.0 alpha:1.0];
//    UIColor *bgColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:205.0/255.0 alpha:1.0];
//    
//    BRScrollBarController *rankingScrollbar = [[BRScrollBarController alloc] initForScrollView:self.rankingTableView inPosition:kIntBRScrollBarPositionRight];
//        
//    
//    rankingScrollbar.scrollBar.backgroundColor =bgColor;
//    rankingScrollbar.scrollBar.scrollHandle.backgroundColor = forColor;
//    rankingScrollbar.scrollBar.scrollHandle.alpha = 1;
//    
//  
//     BRScrollBarController *trendingScrollbar = [[BRScrollBarController alloc] initForScrollView:self.trendingTableView inPosition:kIntBRScrollBarPositionRight];
//    trendingScrollbar.scrollBar.backgroundColor =bgColor;
//    trendingScrollbar.scrollBar.scrollHandle.backgroundColor = forColor;
//    trendingScrollbar.scrollBar.scrollHandle.alpha = 1;
    
    
    self.bugs = [NSArray arrayWithObjects:@"a",@"b",@"b",@"b",@"b",@"b", nil];
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
- (void)viewDidUnload {
    [self setRankingTableView:nil];
    [self setTrendingTableView:nil];
    [super viewDidUnload];
}

#pragma mark - UITableView delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.bugs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	BugCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
    if ( !cell){
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BugCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
	
    cell.bugRankLabel.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
	return cell;
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
	
}


#pragma mark - UIActions
-(void)newBarButtonTapped:(id)sender{
    
    
}
-(void)deleteBarButtonTapped:(id)sender{
    
    
}
-(void)HBarButtonTapped:(id)sender{
 
    
}

@end
