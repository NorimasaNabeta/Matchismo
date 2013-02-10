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
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
// @property (weak, nonatomic) IBOutlet UISegmentedControl *modeControl;
@end

@implementation CardGameViewController

@synthesize game=_game;
//
//
//
- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}
- (void) setGame:(CardMatchingGame *)game
{
    if (_game != game) {
        _game = game;
    }
}

//
//
//
- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons =cardButtons;
    [self updateUI];
}

//
//
//
- (void) updateUI
{
    UIImage *cardbackImage = [UIImage imageNamed:@"darkorange.png"];
    UIImage *cardfaceImage = [UIImage imageNamed:@"white.png"];

    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

        // NSLog(@"%@", card.contents);
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3:1.0;

        // Hint12?
        // button.imageEdgeInsets
        // UIEdgeInsetsMake()
        // http://stackoverflow.com/questions/2451223/uibutton-how-to-center-an-image-and-a-text-using-imageedgeinsets-and-titleedgei
        [cardButton setImage:cardfaceImage forState:UIControlStateSelected];
        [cardButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -cardfaceImage.size.width, 5.0, 5.0)];
        [cardButton setImage:cardbackImage forState:UIControlStateNormal];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.noticeLabel.text = self.game.result;
}

//
//
//
- (void) setFlipCount:(int)flipCount
{
    _flipCount=flipCount;
    self.flipLabel.text=[NSString stringWithFormat:@"Flip: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}
- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

// re-Deal
//
//
- (IBAction)redealCard:(UIButton *)sender {
    [self setGame:nil];
    self.flipCount=0;
    [self updateUI];
}


@end
