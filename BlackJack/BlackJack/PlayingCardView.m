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
        _suitFontFamily = @"TimesNewRomanPS-BoldMT";
        _rankFontFamily = @"HelveticaNeue-Light";
        _rankFontSize = 24;
        _suitFontSize = 16;
        
        NSDictionary *fontColorDictionary = @{@"♠":[UIColor blackColor],
                                              @"♣":[UIColor blackColor],
                                              @"♥": UIColorFromRGB(0xe74c3c),
                                              @"♦": UIColorFromRGB(0xe74c3c)
                                              };
        _labelColor = fontColorDictionary[_suit];
        
        [self setupCardWrapperView];
        [self createBackSubview];
        [self createFrontSubview];
        isVisible ? [self addSubview:_cardFrontSubview] : [self addSubview:_cardBackSubview];
        
    }
    return self;
}

#pragma mark - Card Methods

- (void)flipCard
{
    UIView *fromCardView, *toCardView;
    
    if (self.isVisible) {
        self.isVisible = NO;
        fromCardView = self.cardFrontSubview;
        toCardView = self.cardBackSubview;

    } else {
        self.isVisible = YES;
        fromCardView = self.cardBackSubview;
        toCardView = self.cardFrontSubview;
    }
    
    [self addSubview:toCardView];
    [UIView transitionFromView:fromCardView
                        toView:toCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:NULL];
    [fromCardView removeFromSuperview];
}

- (void)tiltCardWithDegrees:(float)degrees
{
    [self setTransform:CGAffineTransformMakeRotation(degreesToRadian(degrees))];
}

- (void)tiltCardRandomly
{
    srand48(time(0));
    double tilt = (drand48()*10)-5;
    if (tilt < 0) {
        tilt += 360;
    }
    [self tiltCardWithDegrees:tilt];
    
}

#pragma mark - Init Helper Methods
- (void)setupCardWrapperView
{
    // Set up card
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 0;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)createBackSubview
{
    // Set up back of card subview
    _cardBackSubview = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
    
    /* For image back, you can use this:
     UIGraphicsBeginImageContext(_cardBackSubview.frame.size);
     [[UIImage imageNamed:@"cardBack.jpg"] drawInRect:self.bounds];
     UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     _cardBackSubview.backgroundColor = [UIColor colorWithPatternImage:image];
     */
    
    _cardBackSubview.backgroundColor = UIColorFromRGB(0x45A1CD);
    _cardBackSubview.layer.borderColor = [UIColor whiteColor].CGColor;
    _cardBackSubview.layer.borderWidth = 6.0f;
}

- (void)createFrontSubview
{
    // Set up front of card subview
    _cardFrontSubview = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
    NSInteger cardHeight = _cardFrontSubview.bounds.size.height;
    NSInteger cardWidth = _cardFrontSubview.bounds.size.width;
    NSInteger cardLabelWidth = 30;
    NSInteger cardLabelHeight = 20;
    
    NSInteger xOffset = 0;
    NSInteger yOffset = 8;
    NSInteger yPadding = 20;
    
    CGRect topRankFrame = CGRectMake(xOffset, yOffset, cardLabelWidth, cardLabelHeight);
    [self createLabelForCardWithFrame:topRankFrame withText:self.rank withFontSize:self.rankFontSize withTransformation:0 withSubview:self.cardFrontSubview];
    
    CGRect topSuitFrame = CGRectMake(xOffset, yOffset + yPadding, cardLabelWidth, cardLabelHeight);
    [self createLabelForCardWithFrame:topSuitFrame withText:self.suit withFontSize:self.suitFontSize withTransformation:0 withSubview:self.cardFrontSubview];
    
    CGRect bottomRankFrame = CGRectMake(cardWidth-cardLabelWidth-xOffset, cardHeight-yOffset-cardLabelHeight, cardLabelWidth, cardLabelHeight);
    [self createLabelForCardWithFrame:bottomRankFrame withText:self.rank withFontSize:self.rankFontSize withTransformation:M_PI withSubview:self.cardFrontSubview];
    
    CGRect bottomSuitFrame = CGRectMake(cardWidth-cardLabelWidth-xOffset, cardHeight-yOffset-yPadding-cardLabelHeight, cardLabelWidth, cardLabelHeight);
    [self createLabelForCardWithFrame:bottomSuitFrame withText:self.suit withFontSize:self.suitFontSize withTransformation:M_PI withSubview:self.cardFrontSubview];
    
    CGRect cardCenterFrame = CGRectMake(_cardFrontSubview.center.x-cardLabelWidth, _cardFrontSubview.center.y-cardLabelHeight, cardLabelWidth*2, cardLabelHeight*2);
    [self createLabelForCardWithFrame:cardCenterFrame withText:self.suit withFontSize:self.suitFontSize*3 withTransformation:0 withSubview:self.cardFrontSubview];
    [self createLabelForCardWithFrame:cardCenterFrame withText:@"//" withFontSize:self.suitFontSize*3 withTransformation:0 withSubview:self.cardBackSubview];
    
}



#pragma mark - Helper Methods

- (void)createLabelForCardWithFrame:(CGRect)frame withText:(NSString *)text withFontSize:(NSInteger)fontSize withTransformation:(CGFloat)angleAsRadians withSubview:(UIView *)subview
{
    
    UILabel *newLabel = [[UILabel alloc] initWithFrame:frame];
    newLabel.text = text;
    newLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *suitArray = @[@"♦",@"♠",@"♣",@"♥"];
    if ([suitArray containsObject:text]) {
        newLabel.font = [UIFont fontWithName:self.suitFontFamily size:fontSize];
    } else {
        newLabel.font = [UIFont fontWithName:self.rankFontFamily size:fontSize];
    }
    
    if (angleAsRadians != 0) [newLabel setTransform:CGAffineTransformMakeRotation(angleAsRadians)];
    
    if (subview == self.cardFrontSubview) {
        newLabel.textColor = self.labelColor;
    } else {
        [UIFont fontWithName:@"ArialHebrew-Bold" size:fontSize];
        newLabel.textColor = [UIColor whiteColor];
    }
    [subview addSubview:newLabel];
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@%@: %@", self.rank, self.suit, NSStringFromCGRect([super convertRect:super.frame fromView:self])];
}

@end
