//
//  CardView.h
//  CardMatch
//
//  Created by Vivek Sivakumar on 2/12/15.
//  Copyright (c) 2015 Vivek Sivakumar. All rights reserved.
//
// ABSTRACT CLASS

#import <UIKit/UIKit.h>

@interface CardView : UIView

#pragma mark abstract methods
//For Subclasses
- (void)drawRect:(CGRect)rect;
- (void)setup;


@end
