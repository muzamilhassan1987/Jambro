//
//  UIButton+FontSize.m
//  Newzgram
//
//  Created by Akber Sayani on 4/13/15.
//  Copyright (c) 2015 Xyz. All rights reserved.
//

#import "UIButton+FontSize.h"
#import "Constants.h"

@implementation UIButton (FontSize)

- (void)awakeFromNib {
    
    self.titleLabel.font = (IS_IPAD)?[UIFont fontWithName:self.titleLabel.font.familyName size:self.titleLabel.font.pointSize*2.0]:self.titleLabel.font;
}


@end
