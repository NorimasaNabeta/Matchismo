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
//
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
        if (flag > 1){
            score += 1;
        }
        flag=0;
        for (SetCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                flag++;
            }
        }
        if (flag > 1){
            score += 2;
        }
        flag=0;
        for (SetCard *otherCard in otherCards) {
            if (otherCard.shading == self.shading) {
                flag++;
            }
        }
        if (flag > 1){
            score += 4;
        }
        flag=0;
        for (SetCard *otherCard in otherCards) {
            if (otherCard.color == self.color) {
                flag++;
            }
        }
        if (flag > 1){
            score += 8;
        }
    }
    return score;
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
// c.f. Lecture 4 Slide 38-49/51(Attributed Strings)
//
- (NSAttributedString*)attrContents
{
    NSString *base = [self contents];
    NSDictionary *colorDict = @{ @"yellow": [UIColor yellowColor],
                                 @"green": [UIColor greenColor], @"blue": [UIColor blueColor], @"red": [UIColor redColor]};
    NSArray *colorNames = @[@"?", @"red", @"green", @"blue"];
    UIColor *colorValue = (UIColor*) colorDict[ colorNames[self.color]];
    UIColor *transparentColor = [colorValue colorWithAlphaComponent:0.3];
    NSDictionary *attributes = @{ NSForegroundColorAttributeName: colorValue };
    switch (self.shading) {
        case 1: // stroke only
            attributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                            NSStrokeWidthAttributeName: @-5,
                            NSStrokeColorAttributeName: colorValue};
            break;
        case 2: // stroke and shade
            attributes = @{ NSForegroundColorAttributeName: transparentColor,
                            NSStrokeWidthAttributeName: @-5,
                            NSStrokeColorAttributeName: colorValue};
            break;
        case 3: //stroke and fill
        default:
            attributes = @{ NSForegroundColorAttributeName: colorValue };
            break;
    }
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:base];
    [string addAttributes: attributes range:NSMakeRange(0, self.rank)];

    return string;
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
