//
//  UIImageView+ThumbImage.m
//  ChoreSimple
//
//  Created by Akber Sayani on 9/11/14.
//  Copyright (c) 2014 faraz haider. All rights reserved.
//

#import "UIImageView+ThumbImage.h"
#import "UIImageView+AFNetworking.h"

#import "UtilitiesHelper.h"

#define IMAGEBASEURL @"http://newzgram.appnotech.com/app/webroot/thumb/_thumb.php?src="
@implementation UIImageView (ThumbImage)

- (void)setThumbImageWithName:(NSString *)imageName andMaskingImage:(UIImage*)maskingImage withPlaceholder:(UIImage*)placeHolderImage
{
    CGFloat imageFromServerWidth =(self.frame.size.width*2);
    CGFloat imageFromServerHeight= (self.frame.size.height*2);
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@&h=%fpx&w=%fpx",IMAGEBASEURL,imageName,imageFromServerHeight,imageFromServerWidth];
    
    __block UIImageView *displayImage = self;
    
    [self setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]]
                placeholderImage:nil
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                             
                             displayImage.image = [UtilitiesHelper maskImage:image withOverlayMask:maskingImage];;
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                             
                         }
     ];
}

- (void)setImageWithName:(NSString *)imageName AndPlaceholder:(UIImage*)placeHolderImage
{
    int imageFromServerWidth =(self.frame.size.width*2);
    int imageFromServerHeight= (self.frame.size.height*2);
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@&h=%dpx&w=%dpx",IMAGEBASEURL,imageName,imageFromServerHeight,imageFromServerWidth];
    
    [self setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeHolderImage];
}


- (void)setThumbImageWithName:(NSString *)imageName AndPlaceholder:(UIImage*)placeHolderImage
{
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@&h=%.0fpx&w=%.0fpx",
                          IMAGEBASEURL,
                          imageName,
                          placeHolderImage.size.height,
                          placeHolderImage.size.width];
    
    [self setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeHolderImage];
}




@end
