//
//  ArticleDetail.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coordinates;

/**
 * This object model class represents to an ArticleDetail object
 */
@interface ArticleDetail : NSObject <NSCoding, NSCopying>

/* The article description (html string) */
@property (nonatomic, strong) NSString *content;

/* The article id */
@property (nonatomic, strong) NSString *dataIdentifier;

/* The article title */
@property (nonatomic, strong) NSString *title;

/* The article image */
@property (nonatomic, strong) NSString *image;

/* The article created date */
@property (nonatomic, strong) NSString *date;

/* The article coordinates */
@property (nonatomic, strong) Coordinates *coordinates;

/* The article type */
@property (nonatomic, strong) NSString *type;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
