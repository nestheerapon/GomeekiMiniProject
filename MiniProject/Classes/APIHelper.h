//
//  APIHelper.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/6/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIHelper : NSObject

+ (NSString *)baseURL;
+ (NSString *)loadArticlesURL;
+ (NSString *)loadDetailURLWithArticleID:(NSString *)articleID;

@end
