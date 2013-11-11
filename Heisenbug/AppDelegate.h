//
//  AppDelegate.h
//  Heisenbug
//
//  Created by Ahmad Al-Ali on 8/12/13.
//  Copyright (c) 2013 Ahmad Al-Ali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic,strong)  NSMutableData *data;

@end
