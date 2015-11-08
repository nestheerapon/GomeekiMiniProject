//
//  UIImageView+URLImage.m
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import "UIImageView+URLImage.h"

@interface UIImageView ()

@end

@implementation UIImageView (URLImage)

- (void)setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholderImage
{
    self.image = placeholderImage;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       
                                                       if (error != nil) {
                                                           if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection) {
                                                               abort();
                                                           }
                                                       }
                                                       
                                                       [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                                                           
                                                           UIImage *image = [[UIImage alloc] initWithData:data];
                                                           
                                                           if (image) {
                                                               self.image = image;
                                                           } else {
                                                               self.image = placeholderImage;
                                                           }
                                                           
                                                           [self setNeedsLayout];
                                                       }];
                                                   }];
    
    [sessionTask resume];
}

@end
