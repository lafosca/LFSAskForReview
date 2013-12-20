#Introduction

LFSAskForReview is a class that you can add to your iOS app in order to ask the user to review it. Its main features are that it doesn't ask the user to review the app more than once per version and that it's fully customizable, you can:

- decide which actions and how many repetitions are needed before displaying the alert (datasource protocol)
- set the title, message and button titles of the alert (datasource protocol)
- implement the response to both the positive and the negative answer of the user (delegate protocol)



![](https://i.cloudup.com/gwQpHAlp2E.png)  


#Usage
##Class
```
@property (strong, nonatomic) id<LFSAskForReviewServiceDataSource>dataSource;
@property (strong, nonatomic) id<LFSAskForReviewServiceDelegate>delegate;

//Singleton
+ (LFSAskForReviewService *)sharedService;

//Method to call when the user action that could trigger the ask for review alert happened.
- (void)askIfNecessaryAfterUserAction:(NSString *)action;
```

##Data Source

```
/**
 For a given action, returns the number of repetitions that must happen before showing the alert asking for a review.
 */
- (NSUInteger)necessaryRepetitionsForAction:(NSString *)action
{
    if ([action isEqualToString:@"OpenSection"]) {
        return 10;
    }
    
    if ([action isEqualToString:@"SendMessage"]) {
        return 20;
    }
    
    return 0;
}

/**
 Returns the title to be displayed in the alert.
 */
- (NSString *)title
{
    return @"Y U NO RATE";
}

/**
 Returns the message to be displayed in the alert.
 */
- (NSString *)message
{
    return @"We have a family to feed\n PLEASE RATE US";
}

/**
 Returns the title for the positive answer button of the alert.
 */
- (NSString *)positiveButtonTitle
{
    return @"YOU'RE AWESOME";
}

/**
 Returns the title for the negative answer button of the alert.
 */
- (NSString *)negativeButtonTitle
{
    return @"YOU'RE A DICK";
}

```


##Delegate
```
/**
 Handles user's positive response to the ask for review alert.
 */
- (void)userResponseWasNegative
{
    //Do whatever you want
}

/**
 Handles user's negative response to the ask for review alert.
 */
- (void)userResponseWasPositive
{
    //Do whatever you want
}
```

