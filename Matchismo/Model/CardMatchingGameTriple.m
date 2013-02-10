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

- (NSMutableArray *) cards
{
    if (!_cards) _cards =[[NSMutableArray alloc] init];
    return _cards;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_SCORE 4

-(void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_SCORE;
                        self.result = [NSString stringWithFormat:@"Matched %@ & %@", card.contents, otherCard.contents];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.result = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty!",
                                       card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
