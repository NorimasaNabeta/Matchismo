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

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons =cardButtons;
    [self updateUI];
}

- (void) updateUI
{
    UIImage *cardbackImage = [UIImage imageNamed:@"darkorange.png"];
    UIImage *cardfaceImage = [UIImage imageNamed:@"white.png"];

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
//    if (self.modeControl.enabled) {
//        self.modeControl.enabled = NO;
//    }
}

- (IBAction)redealCard:(UIButton *)sender {
    [self setGame:nil];
    self.flipCount=0;
    [self updateUI];
//    self.modeControl.enabled = YES;
}


//- (IBAction)changeModeSegment:(UISegmentedControl *)sender {
//    CardMatchingGame *tmp;
//    
//    if (sender.selectedSegmentIndex == 0) {
//        NSLog(@"Select: 2-card-mode %d",sender.selectedSegmentIndex);
//        tmp = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
//                                                usingDeck:[[PlayingCardDeck alloc] init]];
//
//    } else {
//        NSLog(@"Select: 3-card-mode %d",sender.selectedSegmentIndex);
//        tmp = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
//                                                usingDeck:[[PlayingCardDeck alloc] init]];
//    }
//    [self setGame:tmp];
//    self.flipCount=0;
//    [self updateUI];
//}




@end
