//
//  NlIlouisOmnitureSessionProxy.m
//  titanium custom omniture
//
//  Created by L.P. van de Wiele on 08-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NlIlouisOmnitureSessionProxy.h"
#import "TiUtils.h"

@implementation NlIlouisOmnitureSessionProxy
@synthesize s;

-(id)init
{
    if (self = [super init])
    {
        
        self.s = [[AppMeasurement alloc] init];
    }
    
    return self;
}

-(void)setDebugTracking:(id)value
{
    s.debugTracking = [TiUtils boolValue:value];
    [self replaceValue:value forKey:@"debugTracking" notification:NO];
}


-(void)setTrackOffline:(id)value
{
    s.trackOffline = [TiUtils boolValue:value];
    [self replaceValue:value forKey:@"trackOffline" notification:NO];
}

-(void)setOfflineLimit:(id)value
{
    s.offlineLimit = [NSNumber numberWithInt:[TiUtils intValue:value]];
    [self replaceValue:value forKey:@"offlineLimit" notification:NO];
}

-(void)setTrackingServer:(id)value
{
    s.trackingServer = [TiUtils stringValue:value];
    [self replaceValue:value forKey:@"trackingServer" notification:NO];
}

-(void)setAccount:(id)value
{
    s.account = [TiUtils stringValue:value];
    [self replaceValue:value forKey:@"account" notification:NO];
}


-(void)test:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    
    NSLog(@"Account: %@", s.account);
    NSLog(@"TrackingServer: %@", s.trackingServer);
    NSLog(@"DebugTracking: %@", s.debugTracking ? @"YES":@"NO");
    NSLog(@"OfflineLimit: %d", [s.offlineLimit intValue]);
    NSLog(@"TrackOffline: %@", s.trackOffline ? @"YES":@"NO");
    
}

-(void)track:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    [s track:args];
}

-(void)trackLink:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *url = [NSString stringWithFormat:@"%@",(NSString *) [args objectForKey:@"url"]];
    NSString *type = [NSString stringWithFormat:@"%@",(NSString *) [args objectForKey:@"type"]];
    NSString *name = [NSString stringWithFormat:@"%@",(NSString *) [args objectForKey:@"name"]];
    
    if ([url isEqualToString:@""])
        url = NULL;
    
    [args removeObjectForKey:@"url"];
    [args removeObjectForKey:@"type"];
    [args removeObjectForKey:@"name"];
    
    
    [s trackLink:url linkType:type linkName:name variableOverrides:args];
    
}

-(void)dealloc
{
    [s dealloc];
    [super dealloc];
}

@end
