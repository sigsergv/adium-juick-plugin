//
//  juick-plugin.h
//  juick-adium-plugin
//
//  Created by sidney on 05.11.12.
//  Copyright (c) 2012 sidney. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Adium/AIPlugin.h>
#import <Adium/AIContentControllerProtocol.h>
#import <Adium/AIContentObject.h>
#import <Adium/AIListContact.h>

@interface juick_plugin : NSObject <AIHTMLContentFilter> 
- (void) installPlugin;
- (void) uninstallPlugin;

@end
