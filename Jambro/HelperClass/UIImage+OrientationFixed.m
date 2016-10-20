//
//  UIImage+OrientationFixed.m
//  ChoreSimple
//
//  Created by Akber Sayani on 8/19/14.
//  Copyright (c) 2014 faraz haider. All rights reserved.
//

#import "UIImage+OrientationFixed.h"

@implementation UIImage (OrientationFixed)

- (UIImage *)normalizedImage {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){0, 0, self.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

@end
