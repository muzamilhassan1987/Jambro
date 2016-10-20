//
//  UIPlaceHolderTextView.h
//  ArtesianWells
//
//  Created by Akber Sayani on 6/21/14.
//  Copyright (c) 2014 Appnotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
