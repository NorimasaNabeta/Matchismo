//
//  SetCard.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/09.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize suit=_suit;

- (int)match:(NSArray *)otherCards
{
    int score=0;
    
    if (otherCards.count == 1) {
        SetCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score=1;
        } else if (otherCard.rank == self.rank){
            score = 4;
        }
        
    }
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [SetCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray*)validSuits
{
    return @[@"▲", @"●", @"■"];
}
- (void) setSuit:(NSString *)suit
{
    if( [[SetCard validSuits] containsObject:suit] ){
        _suit = suit;
    }
    
}
-(NSString *)suit
{
    return _suit? _suit: @"?";
}

+ (NSArray*)rankStrings
{
    return @[@"?", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"J", @"Q", @"K", @"A"];
}
+(NSUInteger) maxRank { return [self rankStrings].count -1; }

-(void) setRank:(NSUInteger)rank
{
    if(rank <= [SetCard maxRank]){
        _rank = rank;
    }
}

+ (NSArray*)colorStrings
{
    return @[@"?", @"red", @"green", @"blue"];
}
+(NSUInteger) maxColor { return [self colorStrings].count -1; }
-(void) setColor:(NSUInteger)color
{
    if(color <= [SetCard maxColor]){
        _color = color;
    }
}


@end
