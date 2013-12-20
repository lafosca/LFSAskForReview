//
//  LFSAskForRewiewService.h
//  FXStreet
//
//  Created by Lluís Gómez Hernando on 18/12/13.
//  Copyright (c) 2013 Lafosca. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LFSAskForReviewServiceDataSource <NSObject>

@required

/**
 For a given action, returns the number of repetitions that must happen before showing the alert asking for a review.
 */
- (NSUInteger)necessaryRepetitionsForAction:(NSString *)action;

/**
 Returns the message to be displayed in the alert.
 */
- (NSString *)message;

/**
 Returns the title to be displayed in the alert.
 */
- (NSString *)title;

/**
 Returns the title for the positive answer button of the alert.
 */
- (NSString *)positiveButtonTitle;

/**
 Returns the title for the negative answer button of the alert.
 */
- (NSString *)negativeButtonTitle;

@end


@protocol LFSAskForReviewServiceDelegate <NSObject>

@required

/**
 Handles user's positive response to the ask for review alert.
 */
- (void)userResponseWasPositive;

/**
 Handles user's negative response to the ask for review alert.
 */
- (void)userResponseWasNegative;
@end


@interface LFSAskForReviewService : NSObject

@property (strong, nonatomic) id<LFSAskForReviewServiceDataSource>dataSource;
@property (strong, nonatomic) id<LFSAskForReviewServiceDelegate>delegate;

//Singleton
+ (LFSAskForReviewService *)sharedService;

//Method to call when the user action that could trigger the ask for review alert happened.
- (void)askIfNecessaryAfterUserAction:(NSString *)action;

@end
