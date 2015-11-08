//
//  UIImageView+URLImage.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (URLImage)

- (void)setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholderImage;

@end
