//
//  NlIlouisOmnitureProxy.m
//  titanium custom omniture
//
//  Created by L.P. van de Wiele on 07-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NlIlouisOmnitureProxy.h"
#import "TiUtils.h"

@implementation NlIlouisOmnitureProxy
@synthesize s;

-(id)initWithSettings:(NSDictionary*) settings
{
    [super init];
    [self setOmniture:settings];
    
    return self;
}

-(id)setOmniture:(NSDictionary *) settings
{
    ENSURE_UI_THREAD_1_ARG(settings);
    
    self.s = [[AppMeasurement alloc] init];
    
    s.trackOffline = [(NSNumber *) [settings objectForKey:@"trackOffline"] boolValue];
    s.offlineLimit = (NSNumber *) [settings objectForKey:@"offlineLimit"];
    s.debugTracking = [(NSNumber *) [settings objectForKey:@"debugTracking"] boolValue];    
    
    s.account = (NSString *) [settings objectForKey:@"account"];
    s.trackingServer = (NSString *) [settings objectForKey:@"trackingServer"];
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

@end
