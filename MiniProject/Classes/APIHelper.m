//
//  APIHelper.m
//  MiniProject
//
//  Created by Nes Theerapon on 11/6/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper

+ (NSString *)baseURL
{
    return @"http://mobiletest.gomeekisystems.com";
}

+ (NSString *)loadArticlesURL
{
    return [NSString stringWithFormat:@"%@/category_sport.json", [self baseURL]];
}

+ (NSString *)loadDetailURLWithArticleID:(NSString *)articleID
{
    return [NSString stringWithFormat:@"%@/%@.json", [self baseURL], articleID];
}

@end
