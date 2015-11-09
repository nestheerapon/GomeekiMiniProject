//
//  Coordinates.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * This object model class represents to an Coordinates object
 */
@interface Coordinates : NSObject <NSCoding, NSCopying>

/* The article latitude */
@property (nonatomic, strong) NSString *latitude;

/* The article longitude */
@property (nonatomic, strong) NSString *longitude;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
