//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/09.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

//
//
//
- (id) init
{
    self = [super init];
    if(self){
        for (NSString *suit in [SetCard validSuits]) {
            for (NSUInteger rank=1; rank <= [SetCard maxRank]; rank++) {
                for (NSUInteger shading=1; shading <= [SetCard maxShading]; shading++) {
                    for (NSUInteger color=1; color <= [SetCard maxColor]; color++) {
                        SetCard *card=[[SetCard alloc] init];
                        card.rank = rank;
                        card.suit = suit;
                        card.color = color;
                        card.shading = shading;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
