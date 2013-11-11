//
//  Constants.h
//  Heisenbug
//
//  Created by Ahmad Al-Ali on 8/14/13.
//  Copyright (c) 2013 Ahmad Al-Ali. All rights reserved.
//

#ifndef Heisenbug_Constants_h
#define Heisenbug_Constants_h



#pragma mark - Frames and Offsets

#define IS_IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568.0)

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


typedef enum {
    bugTypeButtonStateBug,
    bugTypeButtonStateFeature
} bugTypeButtonState;


#endif
