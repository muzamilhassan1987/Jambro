//
//  UITextField+FontSize.m
//  Newzgram
//
//  Created by Akber Sayani on 4/13/15.
//  Copyright (c) 2015 Xyz. All rights reserved.
//

#import "UITextField+FontSize.h"
#import "Constants.h"

@implementation UITextField (FontSize)

- (void)awakeFromNib {
    
    self.font = (IS_IPAD)?[UIFont fontWithName:self.font.familyName size:self.font.pointSize*2.0]:self.font;
}

@end
