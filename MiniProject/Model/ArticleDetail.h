//
//  ArticleDetail.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coordinates;

@interface ArticleDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) Coordinates *coordinates;
@property (nonatomic, strong) NSString *type;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
