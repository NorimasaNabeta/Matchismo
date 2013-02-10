//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Norimasa Nabeta on 2013/02/09.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
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

//
//
//
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

//
//
//
- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons =cardButtons;
    [self updateUI];
}

//
// c.f. Hint 7.
//
- (void) updateUI
{
    NSDictionary *colorDict = @{ @"yellow": [UIColor yellowColor],
                                 @"green": [UIColor greenColor], @"blue": [UIColor blueColor], @"red": [UIColor redColor]};
    NSArray *colorNames = @[@"?", @"red", @"green", @"blue"];

    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard*)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        // NSLog(@"%@", card.contents);
        //[cardButton setTitle:card.contents forState:UIControlStateNormal];
  
        //
        // c.f. Lecture 4 Slide 38-49/51(Attributed Strings)
        //        
        UIColor *colorValue = (UIColor*) colorDict[ colorNames[ card.color]];
        UIColor *transparentColor = [colorValue colorWithAlphaComponent:0.3];
        NSDictionary *attributes = @{ NSForegroundColorAttributeName: colorValue };
        switch (card.shading) {
            case 1: // stroke only
            attributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                            NSStrokeWidthAttributeName: @-5,
                            NSStrokeColorAttributeName: colorValue};
            break;
        case 2: // stroke and shade
            attributes = @{ NSForegroundColorAttributeName: transparentColor,
                            NSStrokeWidthAttributeName: @-5,
                            NSStrokeColorAttributeName: colorValue};
            break;
        case 3: //stroke and fill
        default:
            attributes = @{ NSForegroundColorAttributeName: colorValue };
            break;
        }
        NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:[card contents]];
        [attrString addAttributes: attributes range:NSMakeRange(0, card.rank)];
        [cardButton setAttributedTitle:attrString forState:UIControlStateNormal];
    
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.0:1.0;
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

//
//
//
- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

// redealCard
//
//
- (IBAction)redeal:(id)sender {
    [self setGame:nil];
    self.flipCount=0;
    [self updateUI];
}

@end
