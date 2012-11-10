//
//  juick-plugin.h
//  juick-adium-plugin
//
//  Created by sidney on 05.11.12.
//  Copyright (c) 2012 sidney. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Adium/AIPlugin.h>
#import <Adium/AISharedAdium.h>
#import <Adium/AIChat.h>
#import <Adium/AIListObject.h>
#import <Adium/AIListContact.h>
#import <Adium/AIContactControllerProtocol.h>
#import <Adium/AICorePluginLoader.h>
#import <Adium/AIContentControllerProtocol.h>
#import <Adium/AIInterfaceControllerProtocol.h>


@interface juick_plugin : NSObject <AIHTMLContentFilter, AIContentFilter>
- (void) installPlugin;
- (void) uninstallPlugin;

@end
