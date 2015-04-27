//
//  FacebookConnectPlugin.m
//  GapFacebookConnect
//
//  Created by Jesse MacFadyen on 11-04-22.
//  Updated by Mathijs de Bruin on 11-08-25.
//  Updated by Christine Abernathy on 13-01-22
//  Copyright 2011 Nitobi, Mathijs de Bruin. All rights reserved.
//

#import "FacebookConnectPlugin.h"

@interface FacebookConnectPlugin ()

@property (strong, nonatomic) NSString *userid;
@property (strong, nonatomic) NSString* loginCallbackId;
@property (strong, nonatomic) NSString* dialogCallbackId;
@property (strong, nonatomic) NSString* graphCallbackId;

@end

@implementation FacebookConnectPlugin


- (CDVPlugin *)initWithWebView:(UIWebView *)theWebView {
    NSLog(@"Init FacebookConnect Session");
    self = (FacebookConnectPlugin *)[super initWithWebView:theWebView];
    self.userid = @"";
    
    
    // Add notification listener for tracking app activity with FB Events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];  
    return self;
}


- (void)applicationDidBecomeActive {
    // Call the 'activateApp' method to log an app event for use in analytics and advertising reporting.
    [FBSDKAppEvents activateApp];
    
}
-(void)trackCreateAccountEvent: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *res;
    if (!command.arguments == 1) {
        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
 
    NSString* installationGUID = [command.arguments objectAtIndex:0];
    
    [FBSDKAppEvents logEvent: FBSDKAppEventNameCompletedRegistration
                  valueToSum: 1.0
                  parameters: @{ FBSDKAppEventParameterNameRegistrationMethod: @"Email",
                                 @"username": installationGUID
                                 }];
    
    res = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
    
}

-(void)trackGradePickEvent: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *res;
    if (!command.arguments == 1) {
        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
    
    NSString* installationGUID = [command.arguments objectAtIndex:0];
    NSString* grade = [command.arguments objectAtIndex: 1];

    [FBSDKAppEvents logEvent: FBSDKAppEventNameSearched
                  valueToSum: 1.0
                  parameters: @{ FBSDKAppEventParameterNameRegistrationMethod: @"Email",
                                 @"username": installationGUID,
                                 @"grade" : grade
               }];
    
    
    res = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
}

-(void)trackSubjectPickEvent: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *res;
    if (!command.arguments == 1) {
        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
    
    NSString* installationGUID = [command.arguments objectAtIndex:0];
    NSString* subject = [command.arguments objectAtIndex: 1];
    
    [FBSDKAppEvents logEvent: FBSDKAppEventNameAddedPaymentInfo
                  valueToSum: 1.0
                  parameters: @{ @"username": installationGUID,
                                 @"subject" : subject
                                 }];
    
    
    res = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
}

-(void)trackTopicPickEvent: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *res;
    if (!command.arguments == 1) {
        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
    
    NSString* installationGUID = [command.arguments objectAtIndex:0];
    NSString* topic = [command.arguments objectAtIndex: 1];
    
    [FBSDKAppEvents logEvent: FBSDKAppEventNameAddedToCart
                  valueToSum: 1.0
                  parameters: @{ @"username": installationGUID,
                                 @"topic" : topic
                                 }];
    
    
    res = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
}

-(void)trackQuestionTypePickEvent: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *res;
    if (!command.arguments == 1) {
        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
    
    NSString* installationGUID = [command.arguments objectAtIndex:0];
    NSString* questionType = [command.arguments objectAtIndex: 1];
    
    [FBSDKAppEvents logEvent: FBSDKAppEventNameAddedToWishlist
                  valueToSum: 1.0
                  parameters: @{ @"username": installationGUID,
                                 @"questionType" : questionType
                                 }];
    
    
    res = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
}

-(void)trackSessionEvent: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *res;
    if (!command.arguments == 1) {
        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
    
    NSString* installationGUID = [command.arguments objectAtIndex:0];
    
    [FBSDKAppEvents logEvent: FBSDKAppEventNameSpentCredits
                  valueToSum: 1.0
                  parameters: @{ @"username": installationGUID,
                                 }];
    
    
    res = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
}

-(void)trackMentorRatedEvent: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *res;
    if (!command.arguments == 1) {
        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
    
    NSString* installationGUID = [command.arguments objectAtIndex:0];
    NSString* rating = [command.arguments objectAtIndex: 1];
    
    [FBSDKAppEvents logEvent: FBSDKAppEventNameRated
                  valueToSum: 1.0
                  parameters: @{ @"username": installationGUID,
                                 @"rating": rating
                                 }];
    
    
    res = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
}

-(void)trackMeetAgainEvent: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *res;
    if (!command.arguments == 1) {
        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
    
    NSString* installationGUID = [command.arguments objectAtIndex:0];
    
    [FBSDKAppEvents logEvent: FBSDKAppEventNameUnlockedAchievement
                  valueToSum: 1.0
                  parameters: @{ @"username": installationGUID,
                                 }];
    
    
    res = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
}

- (void)registerFacebookAds:(CDVInvokedUrlCommand*) command
{
    
    // Add notification listener for tracking app activity with FB Events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
 
}


@end