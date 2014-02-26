//
//  PlayingCardView.m
//  BlackjackWithViews
//
//  Created by Leonard Li on 2/20/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView


- (id)initWithFrame:(CGRect)frame withRank:(NSString *)rank withSuit:(NSString *)suit isVisible:(BOOL)isVisible
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialize Card
        _suit = suit;
        _rank = rank;
        _isVisible = isVisible;
        
        // Customize Card Label properties
        _fontFamily = @"TimesNewRomanPS-BoldMT";
        _rankFontSize = 16;
        _suitFontSize = 16;
        
        NSDictionary *fontColorDictionary = @{@"♠":[UIColor blackColor],
                                              @"♣":[UIColor blackColor],
                                              @"♥":[UIColor redColor],
                                              @"♦":[UIColor redColor]
                                              };
        _labelColor = fontColorDictionary[_suit];

        // Set up card
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0;
        self.backgroundColor = [UIColor whiteColor];
        
        // Set up back of card subview
        _cardBackSubview = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
        UIGraphicsBeginImageContext(_cardBackSubview.frame.size);
        [[UIImage imageNamed:@"cardBack.jpg"] drawInRect:self.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
//        _cardBackSubview.backgroundColor = [UIColor colorWithPatternImage:image];
        _cardBackSubview.backgroundColor = UIColorFromRGB(0x2c3e50);
        _cardBackSubview.layer.borderColor = [UIColor whiteColor].CGColor;
        _cardBackSubview.layer.borderWidth = 7.0f;

        // Set up front of card subview
        _cardFrontSubview = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
        NSInteger cardHeight = _cardFrontSubview.bounds.size.height;
        NSInteger cardWidth = _cardFrontSubview.bounds.size.width;
        NSInteger cardLabelWidth = 20;
        NSInteger cardLabelHeight = 20;
        
        NSInteger xOffset = 0;
        NSInteger yOffset = 0;
        NSInteger yPadding = 13;
        
        CGRect topRankFrame = CGRectMake(xOffset, yOffset, cardLabelWidth, cardLabelHeight);
        CGRect topSuitFrame = CGRectMake(xOffset, yOffset + yPadding, cardLabelWidth, cardLabelHeight);
        CGRect bottomRankFrame = CGRectMake(cardWidth-cardLabelWidth-xOffset, cardHeight-yOffset-cardLabelHeight, cardLabelWidth, cardLabelHeight);
        CGRect bottomSuitFrame = CGRectMake(cardWidth-cardLabelWidth-xOffset, cardHeight-yOffset-yPadding-cardLabelHeight, cardLabelWidth, cardLabelHeight);
        CGRect cardCenterFrame = CGRectMake(_cardFrontSubview.center.x-cardLabelWidth, _cardFrontSubview.center.y-cardLabelHeight, cardLabelWidth*2, cardLabelHeight*2);
        
        [self createLabelForCardWithFrame:topRankFrame withText:self.rank withFontSize:self.rankFontSize withTransformation:0];
        [self createLabelForCardWithFrame:topSuitFrame withText:self.suit withFontSize:self.suitFontSize withTransformation:0];
        [self createLabelForCardWithFrame:bottomRankFrame withText:self.rank withFontSize:self.rankFontSize withTransformation:M_PI];
        [self createLabelForCardWithFrame:bottomSuitFrame withText:self.suit withFontSize:self.suitFontSize withTransformation:M_PI];
        [self createLabelForCardWithFrame:cardCenterFrame withText:self.suit withFontSize:self.suitFontSize*3 withTransformation:0];
        
        if (isVisible) {
            [self addSubview:_cardFrontSubview];
        } else {
            [self addSubview:_cardBackSubview];
        }

    }
    return self;
}

- (void)createLabelForCardWithFrame:(CGRect)frame withText:(NSString *)text withFontSize:(NSInteger)fontSize withTransformation:(CGFloat)angleAsRadians
{

    UILabel *newLabel = [[UILabel alloc] initWithFrame:frame];
    newLabel.text = text;
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.textColor = self.labelColor;
    newLabel.font = [UIFont fontWithName:self.fontFamily size:fontSize];
    if (angleAsRadians != 0) {
        [newLabel setTransform:CGAffineTransformMakeRotation(angleAsRadians)];
    }
    [self.cardFrontSubview addSubview:newLabel];
}

- (void)flipCard
{
    if (self.isVisible) {
        self.isVisible = NO;
        [self addSubview:self.cardBackSubview];
        [UIView transitionFromView:self.cardFrontSubview
                            toView:self.cardBackSubview
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:NULL];

        [self.cardFrontSubview removeFromSuperview];
    } else {
        self.isVisible = YES;
        [self addSubview:self.cardFrontSubview];
        [UIView transitionFromView:self.cardBackSubview
                            toView:self.cardFrontSubview
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:NULL];
        [self.cardBackSubview removeFromSuperview];
    }
}
@end
