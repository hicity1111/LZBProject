//
//  NSObject+LZBCall.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LZBCall)

- (void)callWithPhoneNumber:(NSString *)pnum
          completionHandler:(void (^)(BOOL success))complition;

@end

NS_ASSUME_NONNULL_END
