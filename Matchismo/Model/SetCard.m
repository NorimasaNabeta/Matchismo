//
//  SetCard.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/09.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SetCard.h"

@implementation SetCard

@synthesize suit=_suit;

//
// https://piazza.com/class#winter2013/codingtogetherios6/819
//
- (int)match:(NSArray *)otherCards
{
    int score=0;
    int flag=0;
    
    if (otherCards.count == 2) {
        flag=0;
        for (SetCard *otherCard in otherCards) {
            if ([otherCard.suit isEqualToString:self.suit]) {
                flag++;
            }
        }
        if (flag==0){
            SetCard *other0 = otherCards[0];
            SetCard *other1 = otherCards[1];
            if(! [other0.suit isEqualToString:other1.suit]) {
                score += 1;
            }
        }
        else if (flag == 2){
            score += 1;
        }
        
        flag=0;
        for (SetCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                flag++;
            }
        }
        if (flag==0){
            SetCard *other0 = otherCards[0];
            SetCard *other1 = otherCards[1];
            if(! other0.rank != other1.rank) {
                score += 2;
            }
        }
        else if (flag == 2){
            score += 2;
        }

        flag=0;
        for (SetCard *otherCard in otherCards) {
            if (otherCard.shading == self.shading) {
                flag++;
            }
        }
        if (flag==0){
            SetCard *other0 = otherCards[0];
            SetCard *other1 = otherCards[1];
            if(! other0.shading != other1.shading) {
                score += 4;
            }
        }
        else if (flag == 2){
            score += 4;
        }

        flag=0;
        for (SetCard *otherCard in otherCards) {
            if (otherCard.color == self.color) {
                flag++;
            }
        }
        if (flag==0){
            SetCard *other0 = otherCards[0];
            SetCard *other1 = otherCards[1];
            if(other0.color != other1.color) {
                score += 8;
            }
        }
        else if (flag == 2){
            score += 8;
        }
    }
    NSLog(@"Score: %d", score);
    return (score == (1+2+4+8) ? 1: 0);
}

// NSArray componentsJoinedByString:
//    NSAttributedString *ast = @{ NSFontAttributeName: [UIFont systemFontOfSize:24],
//                                 NSStrokeColorAttributeName: @-5,
//                                 NSStrokeColorAttributeName: [UIColor orangeColor],
//                                 NSForegroundColorAttributeName: [UIColor blueColor]};
- (NSString *)contents
{
    NSMutableArray *member = [[NSMutableArray alloc] init];
    for (NSUInteger idx=1; idx <= self.rank; idx++) {
        [member addObject:self.suit];
    }
    return [member componentsJoinedByString:@""];
}

//
// shading(6)
//
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

//
// rank(3)
//
+ (NSArray*)rankStrings
{
    return @[@"?", @"1", @"2", @"3"];
}
+(NSUInteger) maxRank { return [self rankStrings].count -1; }
-(void) setRank:(NSUInteger)rank
{
    if(rank <= [SetCard maxRank]){
        _rank = rank;
    }
}

//
// shading(3)
//
+ (NSArray*)shadingStrings
{
    return @[@"?", @"fill", @"shade", @"stroke"];
}
+(NSUInteger) maxShading { return [self shadingStrings].count -1; }
-(void) setShading:(NSUInteger)shading
{
    if(shading <= [SetCard maxShading]){
        _shading = shading;
    }
}

//
// color(3)
//
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
