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
    NSString *base = [member componentsJoinedByString:@""];
    // return [NSString stringWithFormat:@"%@%d", base, self.color];
    return base;
}

- (NSAttributedString*)attrContents
{
    NSMutableArray *member = [[NSMutableArray alloc] init];
    for (NSUInteger idx=1; idx <= self.rank; idx++) {
        [member addObject:self.suit];
    }
    NSString *base = [member componentsJoinedByString:@""];
    
    NSDictionary *colorDict = @{ @"green": [UIColor greenColor],
                                 @"green": [UIColor greenColor], @"blue": [UIColor blueColor], @"red": [UIColor redColor]};
    NSArray *colorNames = @[@"?", @"red", @"green", @"blue"];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:base];
    [string addAttribute:NSForegroundColorAttributeName value: (UIColor*) colorDict[ colorNames[self.color]]
                   range:NSMakeRange(0,self.rank)];
    return string;
}

//
//
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
//
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
//
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
