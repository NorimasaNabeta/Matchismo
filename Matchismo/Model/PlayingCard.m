//
//  PlayingCard.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/01/31.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score=0;
    
    if (otherCards.count == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score=1;
        } else if (otherCard.rank == self.rank){
            score = 4;
        }
        
    }
//    for (Card *card in otherCards) {
//        if([card.contents isEqualToString:self.contents]){
//            score=1;
//        }
//    }
    return score;
}


// Normally this @synthesize is automatically created for you by the compiler.
// but if you implement BOTH the setter AND the getter yourself, then you also
// have to do the @synthesize yourself too.
@synthesize suit=_suit;

- (NSString *)contents
{
//    NSArray *rankStrings=@[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    //return [NSString stringWithFormat:@"%d%@", self.rank,self.suit];
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray*)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}
- (void) setSuit:(NSString *)suit
{
//    if( [@[@"♥", @"♦", @"♠", @"♣"] containsObject:suit] ){
//        _suit = suit;
//    }
    if( [[PlayingCard validSuits] containsObject:suit] ){
        _suit = suit;
    }
    
}
-(NSString *)suit
{
    return _suit? _suit: @"?";
}

+ (NSArray*)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}
+(NSUInteger) maxRank { return [self rankStrings].count -1; }

-(void) setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}


@end
