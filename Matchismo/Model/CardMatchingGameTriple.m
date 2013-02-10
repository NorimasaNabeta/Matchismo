//
//  CardMatchingGameTriple.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/06.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CardMatchingGameTriple.h"

@interface CardMatchingGameTriple()
@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSString *result;
@end

@implementation CardMatchingGameTriple

//
//
//
- (NSMutableArray *) cards
{
    if (!_cards) _cards =[[NSMutableArray alloc] init];
    return _cards;
}

//
//
//
#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_SCORE 4

-(void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cardSet = [[NSMutableArray alloc] init];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardSet addObject:otherCard];
                }
            }
            if (cardSet.count > 1) {
                int matchScore = [card match:cardSet];
                NSMutableArray *members = [[NSMutableArray alloc] init];
                if (matchScore) {
                    for (Card *otherCard in cardSet) {
                        otherCard.unplayable = YES;
                        [members addObject:otherCard.contents];
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_SCORE;
                    // NSArray componentsJoinedByString:
                    self.result = [NSString stringWithFormat:@"Matched %@ & %@",
                                   card.contents,
                                   [members componentsJoinedByString:@"& "] ];
                } else {
                    for (Card *otherCard in cardSet) {
                        otherCard.faceUp = NO;
                        [members addObject:otherCard.contents];
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.result = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty!",
                                   card.contents,
                                   [members componentsJoinedByString:@"& "],
                                   MISMATCH_PENALTY];
                }
            }
 
            
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
