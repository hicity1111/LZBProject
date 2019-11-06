//
//  NotifyListEntry.m
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotifyListEntry.h"

@implementation NotifyListEntry

- (NSArray *)noticeImagesUrl {
    if (!_noticeImagesUrl) {
        _noticeImagesUrl = [[NSArray alloc] init];
    }
    return _noticeImagesUrl;
}

- (NSString *)contentStr {
    if (!_contentStr) {
        if (self.noticeType == 1) {
             _contentStr = [[NSAttributedString alloc] initWithData:[IFISNIL(self.noticeContent) dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil].string;
        } else {
            _contentStr = _noticeContent;
        }
   
    }
    return _contentStr;
}

@end
