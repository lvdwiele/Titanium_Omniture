//
//  NlIlouisOmnitureProxy.h
//  titanium custom omniture
//
//  Created by L.P. van de Wiele on 07-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"
#import "AppMeasurement.h"
@interface NlIlouisOmnitureProxy : TiProxy
@property (nonatomic, retain) AppMeasurement* s;

-initWithSettings:(NSDictionary*) settings;
-(id)setOmniture:(NSDictionary *) settings;

@end
