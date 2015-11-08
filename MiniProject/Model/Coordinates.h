//
//  Coordinates.h
//  MiniProject
//
//  Created by Nes Theerapon on 11/5/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Coordinates : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *longProperty;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
