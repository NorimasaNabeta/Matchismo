//
//  CardMatchingGameTriple.h
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/06.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardMatchingGame.h"

@interface CardMatchingGameTriple : CardMatchingGame
@property (strong,readonly) NSArray * members;
@property (nonatomic) int penalty;

-(void) flipCardAtIndex:(NSUInteger)index;

@end
