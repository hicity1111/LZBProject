//
//  LZBDataEntity.h
//  LZBProject
//  Created by hicity on 2019/10/12.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN
/**请求实体*/
@interface LZBDataEntity : NSObject

/**请求路径*/
@property (nonatomic, copy) NSString *urlString;
/**请求参数*/
@property (nonatomic, copy) id parameters;
/**是否缓存*/
@property (nonatomic, assign, getter=isNeedCache) BOOL needCache;
@end

@interface LZBFileDataEntity : LZBDataEntity

/**文件名字*/
@property (nonatomic, copy) NSString *fileName;
/**
 1、如果是上传操作，为上传文件的本地沙河路径
 2、如果是下载操作，为下载文件保存路径
 */
@property (nonatomic, copy) NSString *filePath;

@end

@interface LZBImageDataEntity :LZBDataEntity

/**上传图片数组*/
@property (nonatomic, copy) NSArray *imageArray;
/**图片名称*/
@property (nonatomic, copy) NSString *fileNames;
/**图片类型 png、jpg、git*/
@property (nonatomic, copy) NSString *imageType;
/**图片压缩比例（0~1.0）*/
@property (nonatomic, assign) CGFloat imageScale;

@end
NS_ASSUME_NONNULL_END

