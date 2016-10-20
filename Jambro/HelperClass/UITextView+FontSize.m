//
//  UITextView+FontSize.m
//  Newzgram
//
//  Created by Akber Sayani on 4/13/15.
//  Copyright (c) 2015 Xyz. All rights reserved.
//

#import "UITextView+FontSize.h"
#import "Constants.h"

@implementation UITextView (FontSize)

- (void)awakeFromNib {
    
    self.font = (IS_IPAD)?[UIFont fontWithName:self.font.familyName size:self.font.pointSize*2.0]:self.font;
}

@end
