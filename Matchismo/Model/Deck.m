//
//  Deck.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/01/31.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck
//
//
//
- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}
- (void)addCard:(Card *)card atTop:(BOOL) atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
    // NSLog(@"add card: %d", self.cards.count);
    
}
//
//
//
- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    // NSLog(@"card: %d", self.cards.count);
    if (self.cards.count){
        unsigned index= arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
