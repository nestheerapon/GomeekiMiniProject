//
//  Coordinates.m
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import "Coordinates.h"


NSString *const kCoordinatesLat = @"lat";
NSString *const kCoordinatesLong = @"long";


@interface Coordinates ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Coordinates

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;


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
            self.latitude = [self objectOrNilForKey:kCoordinatesLat fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kCoordinatesLong fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.latitude forKey:kCoordinatesLat];
    [mutableDict setValue:self.longitude forKey:kCoordinatesLong];

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

    self.latitude = [aDecoder decodeObjectForKey:kCoordinatesLat];
    self.longitude = [aDecoder decodeObjectForKey:kCoordinatesLong];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_latitude forKey:kCoordinatesLat];
    [aCoder encodeObject:_longitude forKey:kCoordinatesLong];
}

- (id)copyWithZone:(NSZone *)zone
{
    Coordinates *copy = [[Coordinates alloc] init];
    
    if (copy) {

        copy.latitude = [self.latitude copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
    }
    
    return copy;
}


@end
