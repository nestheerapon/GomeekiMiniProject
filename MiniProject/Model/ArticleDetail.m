//
//  ArticleDetail.m
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import "ArticleDetail.h"
#import "Coordinates.h"


NSString *const kDataContent = @"content";
NSString *const kDataId = @"id";
NSString *const kDataTitle = @"title";
NSString *const kDataImage = @"image";
NSString *const kDataDate = @"date";
NSString *const kDataCoordinates = @"coordinates";
NSString *const kDataType = @"type";


@interface ArticleDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ArticleDetail

@synthesize content = _content;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize title = _title;
@synthesize image = _image;
@synthesize date = _date;
@synthesize coordinates = _coordinates;
@synthesize type = _type;


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
            self.content = [self objectOrNilForKey:kDataContent fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kDataId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDataTitle fromDictionary:dict];
            self.image = [self objectOrNilForKey:kDataImage fromDictionary:dict];
            self.date = [self objectOrNilForKey:kDataDate fromDictionary:dict];
            self.coordinates = [Coordinates modelObjectWithDictionary:[dict objectForKey:kDataCoordinates]];
            self.type = [self objectOrNilForKey:kDataType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.content forKey:kDataContent];
    [mutableDict setValue:self.dataIdentifier forKey:kDataId];
    [mutableDict setValue:self.title forKey:kDataTitle];
    [mutableDict setValue:self.image forKey:kDataImage];
    [mutableDict setValue:self.date forKey:kDataDate];
    [mutableDict setValue:[self.coordinates dictionaryRepresentation] forKey:kDataCoordinates];
    [mutableDict setValue:self.type forKey:kDataType];

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

    self.content = [aDecoder decodeObjectForKey:kDataContent];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kDataId];
    self.title = [aDecoder decodeObjectForKey:kDataTitle];
    self.image = [aDecoder decodeObjectForKey:kDataImage];
    self.date = [aDecoder decodeObjectForKey:kDataDate];
    self.coordinates = [aDecoder decodeObjectForKey:kDataCoordinates];
    self.type = [aDecoder decodeObjectForKey:kDataType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_content forKey:kDataContent];
    [aCoder encodeObject:_dataIdentifier forKey:kDataId];
    [aCoder encodeObject:_title forKey:kDataTitle];
    [aCoder encodeObject:_image forKey:kDataImage];
    [aCoder encodeObject:_date forKey:kDataDate];
    [aCoder encodeObject:_coordinates forKey:kDataCoordinates];
    [aCoder encodeObject:_type forKey:kDataType];
}

- (id)copyWithZone:(NSZone *)zone
{
    ArticleDetail *copy = [[ArticleDetail alloc] init];
    
    if (copy) {

        copy.content = [self.content copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.coordinates = [self.coordinates copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
    }
    
    return copy;
}


@end
