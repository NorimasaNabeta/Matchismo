//
//  PlayingCard.h
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/01/31.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray*)validSuits;
+ (NSUInteger) maxRank;
+ (NSArray*)rankStrings;
@end
