//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/03.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(id) initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck*)deck;
-(void) flipCardAtIndex:(NSUInteger)index;
-(Card*)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) int score;


@end
