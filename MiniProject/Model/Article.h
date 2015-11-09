//
//  Article.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * This object model class represents to an Article object
 */
@interface Article : NSObject <NSCoding, NSCopying>

/* The article id */
@property (nonatomic, strong) NSString *articlesIdentifier;

/* The article title */
@property (nonatomic, strong) NSString *title;

/* The article image */
@property (nonatomic, strong) NSString *image;

/* The article short description */
@property (nonatomic, strong) NSString *shortDescription;

/* The article created date */
@property (nonatomic, strong) NSString *date;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
