//
//  LZBNetManager.h
//  LZBProject
//
//  Created by hicity on 2019/10/12.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define LZBNetManagerShare [LZBNetManager sharedLZBNetManager]

/**网络状态监听*/
typedef NS_ENUM(NSUInteger, LZBNetworkingStatus){
    /**未知网络*/
    LZBNetworkingStatusKnow         = 0,
    /**没有网络*/
    LZBNetworkingStatusNotReachable,
    /**手机3G/4G网络*/
    LZBNetworkingStatusReachableViaWWAN,
    /**wifi网络*/
    LZBNetworkingStatusReachableViaWifi
};

typedef NS_ENUM(NSUInteger, LZBHttpRequestType){
    /*! get请求 */
    LZBHttpRequestTypeGet = 0,
    /*! post请求 */
    LZBHttpRequestTypePost,
    /*! put请求 */
    LZBHttpRequestTypePut,
    /*! delete请求 */
    LZBHttpRequestTypeDelete
};

typedef NS_ENUM(NSUInteger, LZBHttpRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    LZBHttpRequestSerializerJSON,
    /** 设置请求数据为HTTP格式*/
    LZBHttpRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, LZBHttpResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    LZBHttpResponseSerializerJSON,
    /** 设置响应数据为HTTP格式*/
    LZBHttpResponseSerializerHTTP,
};

/*! 实时监测网络状态的 block */
typedef void(^LZBNetworkStatusBlock)(LZBNetworkingStatus status);

/**！定义请求成功的block*/
typedef void(^ LZBResponseSuccessBlock)(id reponse);
/**！定义请求失败的block*/
typedef void(^ LZBResponseFailBlock)(NSError *error);

/**！定义上传进度*/
typedef void(^ LZBUploadProgressBlock)(int64_t bytesProgress, int64_t totalBytesProgress);
/**！定义下载进度*/
typedef void(^ LZBDownloadProgressBlock)(int64_t bytesProgress, int64_t totalBytesProgress);

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask LZBUrlSessionTask;

@class LZBDataEntity;


@protocol LZBNetManagerDelegate <NSObject>

@required

- (BOOL)lzbManager:(id)hepler response:(id)response;

- (void)lzbManager:(id)helper response:(id)response error:(NSError *)error;

@end

@interface LZBNetManager : NSObject

@property (nonatomic, weak) id<LZBNetManagerDelegate> delegate;

/**！创建的请求超时间隔（以秒为单位），次设置为全局统一设置一次即可，默认超时时间为30s*/
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**！设置网络请求参数的格式，次设置为全局统一设置一次即可，默认:BAHttpRequestSerializerJSON*/
@property (nonatomic, assign) LZBHttpRequestSerializer requestSerializer;

/**！设置服务器响应数据格式，次设置为全局统一设置一次即可，默认:BAHttpResponseSerializerJSON*/
@property (nonatomic, assign) LZBHttpResponseSerializer responseSerializer;

/// 自定义请求头：httpHeaderField
@property (nonatomic, strong) NSDictionary *httpHeaderFieldDictionary;


/// 将传入的string参数序列化
@property (nonatomic, assign) BOOL isSetQueryStringSerialization;


/// 是否开启log打印，默认是不开启
@property (nonatomic, assign) BOOL isOpenLog;

/*!
*  获得全局唯一的网络请求实例单例方法
*
*  @return 网络请求类BANetManager单例
*/
+ (instancetype)sharedLZBNetManager;

#pragma mark - 网络请求的类方法 -- get/post/put/delete

/// 网络请求的实力方法Get
/// @param entity 请求信息载体
/// @param successBlock 请求成功回调
/// @param failureBlock 请求失败回调
/// @param progressBlock 进度回调
- (LZBUrlSessionTask *)lzb_request_getWithEntity:(LZBDataEntity *)entity successBlock:(LZBResponseSuccessBlock)successBlock failureBlock:(LZBResponseFailBlock)failureBlock progressBlock:(LZBDownloadProgressBlock)progressBlock;

/// 网络请求的实力方法Get
/// @param entity 请求信息载体
/// @param successBlock 请求成功回调
/// @param failureBlock 请求失败回调
/// @param progressBlock 进度回调
- (LZBUrlSessionTask *)lzb_request_postWithEntity:(LZBDataEntity *)entity successBlock:(LZBResponseSuccessBlock)successBlock failureBlock:(LZBResponseFailBlock)failureBlock progressBlock:(LZBDownloadProgressBlock)progressBlock;

/// 网络请求的实力方法PUT
/// @param entity 请求信息载体
/// @param successBlock 请求成功回调
/// @param failureBlock 请求失败回调
/// @param progressBlock 进度回调
- (LZBUrlSessionTask *)lzb_request_putWithEntity:(LZBDataEntity *)entity successBlock:(LZBResponseSuccessBlock)successBlock failureBlock:(LZBResponseFailBlock)failureBlock progressBlock:(LZBDownloadProgressBlock)progressBlock;

/// 网络请求的实力方法delete
/// @param entity 请求信息载体
/// @param successBlock 请求成功回调
/// @param failureBlock 请求失败回调
/// @param progressBlock 进度回调
- (LZBUrlSessionTask *)lzb_request_deleteWithEntity:(LZBDataEntity *)entity successBlock:(LZBResponseSuccessBlock)successBlock failureBlock:(LZBResponseFailBlock)failureBlock progressBlock:(LZBDownloadProgressBlock)progressBlock;

/// 上传多图
/// @param entity 请求信息载体
/// @param successBlock 请求成功回调
/// @param failureBlock 请求失败回调
/// @param progressBlock 进度回调
- (LZBUrlSessionTask *)lzb_uploadImageWithEntity:(LZBDataEntity *)entity successBlock:(LZBResponseSuccessBlock)successBlock failureBlock:(LZBResponseFailBlock)failureBlock progressBlock:(LZBDownloadProgressBlock)progressBlock;

/// 视频上传
/// @param entity 请求信息载体
/// @param successBlock 请求成功回调
/// @param failureBlock 请求失败回调
/// @param progressBlock 进度回调
- (void)lzb_uploadVideoWithEntity:(LZBDataEntity *)entity successBlock:(LZBResponseSuccessBlock)successBlock failureBlock:(LZBResponseFailBlock)failureBlock progressBlock:(LZBDownloadProgressBlock)progressBlock;

/// 文件下载
/// @param entity 请求信息载体
/// @param successBlock 请求成功回调
/// @param failureBlock 请求失败回调
/// @param progressBlock 进度回调
- (LZBUrlSessionTask *)lzb_downLoadFileWithEntity:(LZBDataEntity *)entity successBlock:(LZBResponseSuccessBlock)successBlock failureBlock:(LZBResponseFailBlock)failureBlock progressBlock:(LZBDownloadProgressBlock)progressBlock;

/// 文件上传
/// @param entity 请求信息载体
/// @param successBlock 请求成功回调
/// @param failureBlock 请求失败回调
/// @param progressBlock 进度回调
- (LZBUrlSessionTask *)lzb_uploadFileWithEntity:(LZBDataEntity *)entity successBlock:(LZBResponseSuccessBlock)successBlock failureBlock:(LZBResponseFailBlock)failureBlock progressBlock:(LZBDownloadProgressBlock)progressBlock;

#pragma mark - 网络状态监听
/**！开启实时网络状态监听，通过Block回调实时获取（次方法可以多次调用）*/

- (void)lzb_startNetWorkMonitoringWithBlock:(LZBNetworkStatusBlock)networkStatus;



#pragma mark - 自定义请求求
/*自定义请求头**/
- (void)lzb_setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey;

/**！删除所有请求头*/
- (void)lzb_clearAuthorizationHeader;

#pragma mark - 取消Http请求

/**！取消所有的Http请求*/
- (void)lzb_cancelAllRequest;

/**！取消指定 URL 的 Http 请求*/
- (void)lzb_cancelRequestWithURL:(NSString *)URL;

/**！清空缓存：此方法可能会阻止调用线程，直到文件删除完成。*/
- (void)lzb_clearAllHttpCache;

@end

NS_ASSUME_NONNULL_END
