//
//  APIHelper.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/6/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIHelper : NSObject

/**
 * Get the web service base url.
 *
 * @return The base url.
 */
+ (NSString *)baseURL;


/**
 * Get the web service url for loading article list.
 *
 * @return The url for loading article list.
 */
+ (NSString *)loadArticlesURL;


/**
 * Get the web service url for detail related by article id.
 *
 * @param articleID The article id to get article detail.
 *
 * @return The url to get article detail.
 */
+ (NSString *)loadDetailURLWithArticleID:(NSString *)articleID;

@end
