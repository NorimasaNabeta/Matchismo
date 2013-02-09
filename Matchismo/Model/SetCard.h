//
//  SetCard.h
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/09.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSUInteger color;
+ (NSArray*)validSuits;
+ (NSUInteger) maxRank;
+ (NSArray*)rankStrings;
+ (NSUInteger) maxColor;
+ (NSArray*)colorStrings;
@end
