//
//  UIImageView+URLImage.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (URLImage)

/**
 * Set the imageView 'image' with an 'url' and a placeholder.
 *
 * @param url         The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 */
- (void)setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholderImage;

@end
