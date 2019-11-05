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

@end
