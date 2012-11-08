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
}

- (void) uninstallPlugin
{
    [[adium contentController] unregisterHTMLContentFilter:self];
}

- (NSString *)filterHTMLString:(NSString *)message content:(AIContentObject *)content
    {
        //id src = [(AIContentObject *)content source];
        NSString *postIdReplace = @"(#\\d{3,}(\\/\\d+)?)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:postIdReplace options:0 error:NULL];
        NSString *newMessage = [regex stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, [message length]) withTemplate:@"<a href=\"xmpp:juick@juick.com?message;body=$1%20\">$1</a>"];
        
        NSString *nameReplace = @"(?!@juick)(@[\\w\\d_-]+)";
        regex = [NSRegularExpression regularExpressionWithPattern:nameReplace options:0 error:NULL];
        NSString *newMessage1 = [regex stringByReplacingMatchesInString:newMessage options:0 range:NSMakeRange(0, [newMessage length]) withTemplate:@"<a href=\"xmpp:juick@juick.com?message;body=$1+%20\">$1</a>"];
        
        NSString *picReplace = @"<a href=\"(http://[\\/\\.\\w\\d\\_\\-\\p{L}]+(\\.(jpg|png|gif|bmp)))\" title=\"(http://[\\/\\.\\w\\d\\_\\-\\p{L}]+(\\.(jpg|png|gif|bmp)))\">(http://[\\/\\.\\w\\d\\_\\-\\p{L}]+(\\.(jpg|png|gif|bmp)))</a>";
        regex = [NSRegularExpression regularExpressionWithPattern:picReplace options:0 error:NULL];
        NSString *newMessage2 = [regex stringByReplacingMatchesInString:newMessage1 options:0 range:NSMakeRange(0, [newMessage1 length]) withTemplate:@"<img src=\"$1\" style=\"max-width: 100%%; max-height: 100%%;\" onLoad=\"imageSwap(this, false);alignChat(nil);\" />"];
        NSLog(@"%@", message);
        return newMessage2;
        
        
        
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
	return @"0.01";
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
