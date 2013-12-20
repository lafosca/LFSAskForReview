//
//  LFSAskForRewiewService.m
//  FXStreet
//
//  Created by Lluís Gómez Hernando on 18/12/13.
//  Copyright (c) 2013 Lafosca. All rights reserved.
//

#import "LFSAskForReviewService.h"
#import "UIAlertView+MKBlockAdditions.h"

@implementation LFSAskForReviewService

+ (LFSAskForReviewService *)sharedService {
    static LFSAskForReviewService *_sharedIntance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedIntance = [[LFSAskForReviewService alloc] init];
    });
    
    return _sharedIntance;
}

- (void)askIfNecessaryAfterUserAction:(NSString *)action
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *versionKey = @"CFBundleShortVersionString";
    NSString *currentVersion = infoDictionary[versionKey];
    
    NSString *lastVersionReviewed = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastVersionReviewed"];
    
    // this version has been reviewed yet
    if ([currentVersion isEqualToString:lastVersionReviewed]) {
        return;
    }
    
    NSUInteger necessaryRepetitions = [self.dataSource necessaryRepetitionsForAction:action];
    NSUInteger repetitions = [[[NSUserDefaults standardUserDefaults] objectForKey:action] integerValue];
    
    // one more repetition
    repetitions = repetitions + 1;
    
    // showing alert if necessary
    if (repetitions == necessaryRepetitions) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"lastVersionReviewed"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:action];
        [self showAlert];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@(repetitions) forKey:action];
    }
}

- (void)showAlert
{
    NSString *negativeTitle = [self.dataSource negativeButtonTitle];
    NSString *positiveTitle = [self.dataSource positiveButtonTitle];
    
    [UIAlertView alertViewWithTitle:[self.dataSource title]
                            message:[self.dataSource message]
                  cancelButtonTitle:nil
                  otherButtonTitles:@[negativeTitle, positiveTitle]
                          onDismiss:^(int buttonIndex) {
                              
                              if (buttonIndex == 0) {
                                  [self.delegate userResponseWasPositive];
                              } else {
                                  [self.delegate userResponseWasNegative];
                              }
                          } onCancel:nil];
}

@end
