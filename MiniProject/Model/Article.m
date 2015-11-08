//
//  Article.m
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import "Article.h"


NSString *const kArticlesId = @"id";
NSString *const kArticlesTitle = @"title";
NSString *const kArticlesImage = @"image";
NSString *const kArticlesShortDescription = @"short_description";
NSString *const kArticlesDate = @"date";


@interface Article ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Article

@synthesize articlesIdentifier = _articlesIdentifier;
@synthesize title = _title;
@synthesize image = _image;
@synthesize shortDescription = _shortDescription;
@synthesize date = _date;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.articlesIdentifier = [self objectOrNilForKey:kArticlesId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kArticlesTitle fromDictionary:dict];
            self.image = [self objectOrNilForKey:kArticlesImage fromDictionary:dict];
            self.shortDescription = [self objectOrNilForKey:kArticlesShortDescription fromDictionary:dict];
            self.date = [self objectOrNilForKey:kArticlesDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.articlesIdentifier forKey:kArticlesId];
    [mutableDict setValue:self.title forKey:kArticlesTitle];
    [mutableDict setValue:self.image forKey:kArticlesImage];
    [mutableDict setValue:self.shortDescription forKey:kArticlesShortDescription];
    [mutableDict setValue:self.date forKey:kArticlesDate];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.articlesIdentifier = [aDecoder decodeObjectForKey:kArticlesId];
    self.title = [aDecoder decodeObjectForKey:kArticlesTitle];
    self.image = [aDecoder decodeObjectForKey:kArticlesImage];
    self.shortDescription = [aDecoder decodeObjectForKey:kArticlesShortDescription];
    self.date = [aDecoder decodeObjectForKey:kArticlesDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_articlesIdentifier forKey:kArticlesId];
    [aCoder encodeObject:_title forKey:kArticlesTitle];
    [aCoder encodeObject:_image forKey:kArticlesImage];
    [aCoder encodeObject:_shortDescription forKey:kArticlesShortDescription];
    [aCoder encodeObject:_date forKey:kArticlesDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    Article *copy = [[Article alloc] init];
    
    if (copy) {

        copy.articlesIdentifier = [self.articlesIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.shortDescription = [self.shortDescription copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
