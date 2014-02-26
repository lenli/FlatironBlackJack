//
//  PlayingCardView.h
//  BlackjackWithViews
//
//  Created by Leonard Li on 2/20/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface PlayingCardView : UIView
@property (strong, nonatomic) NSString *suit;
@property (strong, nonatomic) NSString *rank;
@property (strong, nonatomic) UIView *cardFrontSubview;
@property (strong, nonatomic) UIView *cardBackSubview;
 
// Visual Card Properties
@property (weak, nonatomic) NSString *fontFamily;
@property (weak, nonatomic) UIColor *labelColor;
@property (nonatomic) NSInteger suitFontSize;
@property (nonatomic) NSInteger rankFontSize;
@property (nonatomic) BOOL isVisible;

- (id)initWithFrame:(CGRect)frame withRank:(NSString *)rank withSuit:(NSString *)suit isVisible:(BOOL)isVisible;
- (void)flipCard;
@end