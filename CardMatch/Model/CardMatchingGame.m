//
//  CardMatchingGame.m
//  CardMatch
//
//  Created by Vivek Sivakumar on 12/6/13.
//  Copyright (c) 2013 Vivek Sivakumar. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self){
        if (count > deck.cardsLeft) self = nil;
        else {
            self.cards = [[NSMutableArray alloc] init];
            for (int i = 0; i < count; i++){
                Card* newCard = [deck drawRandomCard];
                [self.cards addObject:newCard];
            }
        }
    }
    return self;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (Card *)chooseCardAtIndex:(NSUInteger)index {
    Card* card = nil;
    if (index < self.cards.count){
        card = self.cards[index];
        if (card.isChosen){
            card.chosen = NO;
        }
        else {
            for (Card* otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    int match = [card match:@[otherCard]];
                    if (match > 0) {
                        self.score += match * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                }
            }
            card.chosen = YES;
        }
    }
    return card;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    if (index < self.cards.count) return self.cards[index];
    else return nil;
}

- (BOOL)gameOver {
    NSMutableArray* cardsRemaining = [[NSMutableArray alloc] init];
    for (Card* card in self.cards){
        if (!card.matched) [cardsRemaining addObject:card];
    }
    NSLog(@"Cards Remaining: %d", cardsRemaining.count);
    if (cardsRemaining.count == 2){
        for (Card* card in cardsRemaining){
            NSLog(@"%@", card.contents);
        }
    }
    for (Card* card in cardsRemaining){
        int match = [card match:cardsRemaining];
        NSLog(@"%d", match);
        if (match > [card match:@[card]]) return NO;
    }
    return YES;
}


@end
