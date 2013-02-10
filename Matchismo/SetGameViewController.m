//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/09.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGameTriple.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong,nonatomic) CardMatchingGame *game;
@property (nonatomic) int flipCount;

@end

@implementation SetGameViewController
@synthesize game=_game;

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGameTriple alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[SetCardDeck alloc] init]];
    }
    return _game;
}
- (void) setGame:(CardMatchingGame *)game
{
    if (_game != game) {
        _game = game;
    }
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons =cardButtons;
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        // NSLog(@"%@", card.contents);
        //[cardButton setTitle:card.contents forState:UIControlStateNormal];
        [cardButton setAttributedTitle:card.attrContents forState:UIControlStateNormal];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.0:1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.noticeLabel.text = self.game.result;
}

//
//
- (void) setFlipCount:(int)flipCount
{
    _flipCount=flipCount;
    self.flipLabel.text=[NSString stringWithFormat:@"Flip: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

//
//
- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

// redealCard
- (IBAction)redeal:(id)sender {
    [self setGame:nil];
    self.flipCount=0;
    [self updateUI];
}

@end
