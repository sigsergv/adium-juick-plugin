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
        NSString* juickUID = @"juick@juick.com";
        NSString* pointimUID = @"p@point.im";
        
        if ([content.source.UID isEqualToString:juickUID]) {
            // we are in the JUICK section
            NSString *postIdReplace = @"(#\\d{5,}(\\/\\d+)?)";
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:postIdReplace options:0 error:NULL];
            NSString *messageWithPostId = [regex stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, [message length]) withTemplate:@"<a href=\"xmpp:juick@juick.com?message;body=$1%20\">$1</a>"];
            
            NSString *nameIdReplace = @"(?!@juick)(@[\\w\\d_-]+)";
            regex = [NSRegularExpression regularExpressionWithPattern:nameIdReplace options:0 error:NULL];
            NSString *messageWithNameId = [regex stringByReplacingMatchesInString:messageWithPostId options:0 range:NSMakeRange(0, [messageWithPostId length]) withTemplate:@"<a href=\"xmpp:juick@juick.com?message;body=$1+%20\">$1</a>"];
            return messageWithNameId;
        } else if ([content.source.UID isEqualToString:pointimUID]) {
            //  we are in the POINT.IM section
            NSString *postIdReplace = @"([^&])#([a-z]{3,})([^/a-z])";
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:postIdReplace options:0 error:NULL];
            NSString *messageWithPostId = [regex stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, [message length]) withTemplate:@"$1<a href=\"xmpp:p@point.im?message;body=#$1%20\">#$2</a>$3 <a href=\"http://point.im/$2\"><strong>✈︎</strong></a>$3 "];
            
            postIdReplace = @"#([a-z]{3,})/([0-9]+)";
            regex = [NSRegularExpression regularExpressionWithPattern:postIdReplace options:0 error:NULL];
            messageWithPostId = [regex stringByReplacingMatchesInString:messageWithPostId options:0 range:NSMakeRange(0, [messageWithPostId length]) withTemplate:@"<a href=\"xmpp:p@point.im?message;body=#$1/$2%20\">#$1/$2</a> <a href=\"http://point.im/$1#$2\"><strong>✈︎</strong></a> "];
            
            postIdReplace = @"([^&])#([a-z]{3,})$";
            regex = [NSRegularExpression regularExpressionWithPattern:postIdReplace options:0 error:NULL];
            messageWithPostId = [regex stringByReplacingMatchesInString:messageWithPostId options:0 range:NSMakeRange(0, [messageWithPostId length]) withTemplate:@"$1<a href=\"xmpp:p@point.im?message;body=#$1%20\">#$2</a>$3 <a href=\"http://point.im/$2\"><strong>✈︎</strong></a>$3 "];

            
            return messageWithPostId;
        }
        
        return message;
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
	return @"s1dney, sigsergv";
}

- (NSString *)pluginVersion
{
	return @"0.3";
}

- (NSString *)pluginDescription
{
	return @"Plugin for asocial XMPP network juick.com and point.im.";
}

- (NSString *)pluginURL
{
	return @"nil";
}

@end