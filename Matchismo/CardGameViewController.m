//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/01/31.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"


@interface CardGameViewController ()
@property (strong, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController

- (Deck*) deck
{
    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}
- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons =cardButtons;
    for (UIButton *cardButton in cardButtons) {
        Card *card = [self.deck drawRandomCard];
    }
}
- (void) setFlipCount:(int)flipCount
{
    _flipCount=flipCount;
    self.flipLabel.text=[NSString stringWithFormat:@"Flip: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}
- (IBAction)flipCard:(UIButton *)sender {
    if( ! sender.isSelected ){
        sender.selected=YES;
    } else {
        sender.selected=NO;
    }
    self.flipCount++;
}


@end
