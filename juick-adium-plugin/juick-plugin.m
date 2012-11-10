//
//  juick-plugin.m
//  juick-adium-plugin
//
//  Created by sidney on 05.11.12.
//  Copyright (c) 2012 sidney. All rights reserved.
//
#import "juick-plugin.h"

@implementation juick_plugin

- (void) installPlugin
{
    [[adium contentController] registerHTMLContentFilter:self direction:AIFilterIncoming];
    [[adium contentController] registerContentFilter:self ofType:AIFilterContent direction:AIFilterIncoming];
}
- (void) uninstallPlugin
{
    [[adium contentController] unregisterHTMLContentFilter:self];
}
- (NSString *) filterHTMLString:(NSString *)message content:(AIContentObject *)content
{
    @autoreleasepool {
        NSString *postIdReplace = @"(#\\d{3,}(\\/\\d+)?)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:postIdReplace options:0 error:NULL];
        NSString *messageWithPostId = [regex stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, [message length]) withTemplate:@"<a href=\"xmpp:juick@juick.com?message;body=$1%20\">$1</a>"];
        
        NSString *nameIdReplace = @"(?!@juick)(@[\\w\\d_-]+)";
        regex = [NSRegularExpression regularExpressionWithPattern:nameIdReplace options:0 error:NULL];
        NSString *messageWithNameId = [regex stringByReplacingMatchesInString:messageWithPostId options:0 range:NSMakeRange(0, [messageWithPostId length]) withTemplate:@"<a href=\"xmpp:juick@juick.com?message;body=$1+%20\">$1</a>"];
        
        NSString *picReplace = @"<a href=\"(http://[\\/\\.\\w\\d\\_\\-\\p{L}\\%]+(\\.(jpg|png|gif|bmp)))\" title=\"(http://[\\/\\.\\w\\d\\_\\-\\p{L}\\%]+(\\.(jpg|png|gif|bmp)))\">(http://[\\/\\.\\w\\d\\_\\-\\p{L}\\%]+(\\.(jpg|png|gif|bmp)))</a>";
        regex = [NSRegularExpression regularExpressionWithPattern:picReplace options:0 error:NULL];
        NSString *newMessage = [regex stringByReplacingMatchesInString:messageWithNameId options:0 range:NSMakeRange(0, [messageWithNameId length]) withTemplate:@"<img src=\"$1\" style=\"max-width: 100%%; max-height: 100%%;\" onLoad=\"imageSwap(this, false);alignChat();window.scrollTo(0, document.body.scrollHeight)\"/>"];
        return newMessage;
    }
}

- (NSAttributedString *)filterAttributedString:(NSAttributedString *)str context:(id)context
{
    @autoreleasepool {
        
	    return str;
    }
}

- (CGFloat)filterPriority {
	return (CGFloat)LOWEST_FILTER_PRIORITY;
}

- (NSString *)pluginAuthor
{
	return @"s1dney";
}

- (NSString *)pluginVersion
{
	return @"0.02";
}

- (NSString *)pluginDescription
{
	return @"Plugin for asocial XMPP network juick.com.";
}

- (NSString *)pluginURL
{
	return @"nil";
}

@end