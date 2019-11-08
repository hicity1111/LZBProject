//
//  UIViewController+MTPhoto.h
//  LZBProject
//
//  Created by liyan on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef void(^ImagePickerCompletionHandler)(NSData *imageData, UIImage *image);

@interface UIViewController (MTPhoto)

- (void)pickImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler;

- (void)pickImageWithpickImageCutImageWithImageSize:(CGSize)imageSize CompletionHandler:(ImagePickerCompletionHandler)completionHandler;


@end

