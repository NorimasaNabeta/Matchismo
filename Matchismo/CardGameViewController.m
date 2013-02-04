//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/01/31.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
// Lecture 3 slides 89/139
//@property (strong, nonatomic) Deck *deck;
// Lecture 3 slides 85/139
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

// Lecture 3 slides 89/139
//- (Deck*) deck
//{
//    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
//    return _deck;
//}

// Lecture 3 slides 86/139
- (CardMatchingGame *)game
{
    if (!_game) {
        // Lecture 3 slides 90/139
//        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck];
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons =cardButtons;
    // Lecture 3 slides 87/139
//    for (UIButton *cardButton in cardButtons) {
//        Card *card = [self.deck drawRandomCard];
//        [cardButton setTitle:card.contents forState:UIControlStateSelected];
//    }
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        // Lecture 3 slides 95/139
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        // Lecture 3 slides 97/139
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        // Lecture 3 slides 100/139
        cardButton.alpha = card.isUnplayable ? 0.3:1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
}
- (void) setFlipCount:(int)flipCount
{
    _flipCount=flipCount;
    self.flipLabel.text=[NSString stringWithFormat:@"Flip: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}


- (IBAction)flipCard:(UIButton *)sender {
    // Lecture 3 slides 92/139
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];

    // Lecture 3 slides 93-94/139
//    if( ! sender.isSelected ){
//        sender.selected=YES;
//    } else {
//        sender.selected=NO;
//    }
    self.flipCount++;
    [self updateUI];
}


@end
