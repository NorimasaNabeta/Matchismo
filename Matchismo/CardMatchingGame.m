//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/03.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//



//
// Rule: http://en.wikipedia.org/wiki/Set_(game)
//       number/symbol/[shading]/color
//       Given any two cards from the deck,
//       there will be one and only one other card that forms a set with them.
//
#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSString *result;
@end

// TODO:
// still I cannot understand the property score definition,
// define the readonly for outside and readwrite for inside manner?
// and not seeems inf¥heritance from the parent class.
//
@implementation CardMatchingGame

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
-(id) initWithCardCount:(NSUInteger)count
              usingDeck:(Deck*)deck
{
    self = [super init];
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self=nil;
            } else {
                self.cards[i]=card;
            }
            
        }
        
    }
    return self;
}

//
//
//
-(Card*)cardAtIndex:(NSUInteger)index
{
    return (index <self.cards.count)? self.cards[index]: nil;
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
