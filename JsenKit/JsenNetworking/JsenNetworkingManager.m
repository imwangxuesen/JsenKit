//
//  JsenNetworkingManager.m
//  JsenKit
//
//  Created by WangXuesen on 2016/11/14.
//  Copyright © 2016年 WangXuesen. All rights reserved.
//

#import "JsenNetworkingManager.h"
#import "AFNetworking.h"


NSString * const JsenNetworkingManager_NoNetworkMsg = @"失去网络连接,请检查您的网络设置";

@interface JsenNetworkingManager()

@property (nonatomic, copy) NSString *apiKey;

@end

@implementation JsenNetworkingManager
+ (instancetype)manager {
    JsenNetworkingManager * mgr = [[JsenNetworkingManager alloc] init];
    mgr.delegate = [JsenNetworkingManagerTransmit shareTransmit];
    
    return mgr;
}


- (void)post:(NSString *)apiKey
  parameters:(NSDictionary * __nullable)parameters
    progress:(JsenNetworkingProgress __nullable)progress
     success:(JsenNetworkingSuccess __nullable)success
      failed:(JsenNetworkingFailed __nullable)failed
    finished:(JsenNetworkingFinished __nullable)finished {
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:apiKey];
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    
    if ([JsenNetworkingReachabilityManager manager].networkStatusConfirm && ![self networkReachabilityAction]) {
        return;
    }
    
    NSString *url = [config api:apiKey];
    id requestParameters = [self configParametersWithRequestParameters:parameters];
    AFHTTPSessionManager *mgr = [self configHttpSessionManagerWithAPIKey:apiKey];
    
    
    [mgr POST:url parameters:requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        [self progressWithRequestProgress:uploadProgress];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject];
        [self finish];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failedWithError:error];
        [self finish];
    }];
}


- (void)post:(NSString *)apiKey
  parameters:(NSDictionary * __nullable)parameters
    delegate:(id<JsenNetworkingManagerTransmitDelegate>)delegate {
    self.delegate = delegate;
    [self post:apiKey parameters:parameters progress:nil success:nil failed:nil finished:nil];
}

- (void)get:(NSString *)apiKey
 parameters:(NSDictionary * __nullable)parameters
   progress:(JsenNetworkingProgress __nullable)progress
    success:(JsenNetworkingSuccess)success
     failed:(JsenNetworkingFailed)failed
   finished:(JsenNetworkingFinished)finished {
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:apiKey];
    
    if ([JsenNetworkingReachabilityManager manager].networkStatusConfirm && ![self networkReachabilityAction]) {
        return;
    }
    
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    NSString *url = [config api:apiKey];
    id requestParameters = [self configParametersWithRequestParameters:parameters];
    
    AFHTTPSessionManager *mgr = [self configHttpSessionManagerWithAPIKey:apiKey];
    
    [mgr GET:url parameters:requestParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        [self progressWithRequestProgress:downloadProgress];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject];
        [self finish];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failedWithError:error];
        [self finish];
    }];
}

- (void)get:(NSString *)apiKey
 parameters:(NSDictionary * __nullable)parameters
   delegate:(id<JsenNetworkingManagerTransmitDelegate>)delegate {
    self.delegate = delegate;
    [self get:apiKey parameters:parameters progress:nil success:nil failed:nil finished:nil];
}

- (void)uploadTaskWithMultiPartApiKey:(NSString *)apiKey
                                 name:(NSString *)name
                                 data:(NSData *)data
                             fileName:(NSString *)fileName
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary * __nullable)parameters
                             progress:(JsenNetworkingProgress __nullable)progress
                              success:(JsenNetworkingSuccess)success
                               failed:(JsenNetworkingFailed)failed
                             finished:(JsenNetworkingFinished __nullable)finished{
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:apiKey];
    
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    NSString *url = [config api:apiKey];
    id requestParameters = [self configParametersWithRequestParameters:parameters];
    
    AFHTTPSessionManager *mgr = [self configHttpSessionManagerWithAPIKey:apiKey];
    [mgr POST:url parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self progressWithRequestProgress:uploadProgress];
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject];
        [self finish];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failedWithError:error];
        [self finish];
    }];
    
    
}

- (void)uploadTaskWithMultiPartApiKey:(NSString *)apiKey
                                 name:(NSString *)name
                                 data:(NSData *)data
                             fileName:(NSString *)fileName
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary * __nullable)parameters
                             delegate:(id<JsenNetworkingManagerTransmitDelegate>)delegate {
    
    
    self.delegate = delegate;
    [self uploadTaskWithMultiPartApiKey:apiKey
                                   name:name
                                   data:data
                               fileName:fileName
                               mimeType:mimeType
                             parameters:parameters
                               progress:nil
                                success:nil
                                 failed:nil
                               finished:nil];
    
}

- (void)uploadTaskWithMultiPartApiKey:(NSString *)apiKey
                                 name:(NSString *)name
                            dataArray:(NSArray<NSData*> *)dataArray
                        fileNameArray:(NSArray<NSString*> *)fileNameArray
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary * __nullable)parameters
                             progress:(JsenNetworkingProgress __nullable)progress
                              success:(JsenNetworkingSuccess)success
                               failed:(JsenNetworkingFailed)failed
                             finished:(JsenNetworkingFinished __nullable)finished {
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:apiKey];
    
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    NSString *url = [config api:apiKey];
    id requestParameters = [self configParametersWithRequestParameters:parameters];
    AFHTTPSessionManager *mgr = [self configHttpSessionManagerWithAPIKey:apiKey];
    
    NSAssert(dataArray.count == fileNameArray.count, @"dataArray count must be equl to fileNameArray count");
    [mgr POST:url parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [dataArray enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = obj;
            NSString *fileName = fileNameArray[idx];
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self progressWithRequestProgress:uploadProgress];
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject];
        [self finish];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failedWithError:error];
        [self finish];
    }];
    
}

- (void)uploadTaskWithMultiPartApiKey:(NSString *)apiKey
                                 name:(NSString *)name
                            dataArray:(NSArray<NSData*> *)dataArray
                        fileNameArray:(NSArray<NSString*> *)fileNameArray
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary * __nullable)parameters
                             delegate:(id<JsenNetworkingManagerTransmitDelegate>)delegate {
    
    self.delegate = delegate;
    [self uploadTaskWithMultiPartApiKey:apiKey
                                   name:name
                              dataArray:dataArray
                          fileNameArray:fileNameArray
                               mimeType:mimeType
                             parameters:parameters
                               progress:nil
                                success:nil
                                 failed:nil
                               finished:nil];
    
}


- (instancetype)downloadWithUrl:(NSString *)url
                       filePath:(NSURL * __nullable)filePath
                       fileName:(NSString * __nullable)fileName
                       progress:(JsenNetworkingProgress __nullable)progress
                        success:(JsenNetworkingSuccess)success
                         failed:(JsenNetworkingFailed)failed
                       finished:(JsenNetworkingFinished __nullable)finished {
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:nil];
    AFURLSessionManager *mgr = [self configURLSessionManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    self.downloadTask = [mgr downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        [self progressWithRequestProgress:downloadProgress];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [self configDownloadUrlWith:response filePath:filePath fileName:fileName];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self downloadCompletedWith:response filePath:filePath error:error];
        
    }];
    [self.downloadTask resume];
    
    return self;
}

- (instancetype)downloadWithResumeData:(NSData *)resumeData
                              filePath:(NSURL * __nullable)filePath
                              fileName:(NSString * __nullable)fileName
                              progress:(JsenNetworkingProgress __nullable)progress
                               success:(JsenNetworkingSuccess)success
                                failed:(JsenNetworkingFailed)failed
                              finished:(JsenNetworkingFinished __nullable)finished {
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:nil];
    
    AFURLSessionManager *mgr = [self configURLSessionManager];
    self.downloadTask = [mgr downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
        [self progressWithRequestProgress:downloadProgress];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [self configDownloadUrlWith:response filePath:filePath fileName:fileName];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self downloadCompletedWith:response filePath:filePath error:error];
        
    }];
    [self.downloadTask resume];
    
    
    return self;
}

#pragma mark - 数据处理，事件响应
//请求进度
- (void)progressWithRequestProgress:(NSProgress *)requestProgress {
    if (self.progress) {
        self.progress(requestProgress);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingProgress:)]) {
        [self.delegate jsenNetworkingProgress:requestProgress];
    }
}


//http 下载成功后处理，如果有自定义的错误码，会处理为failed
- (void)downloadSuccessWithResponse:(NSURLResponse *)response filePath:(NSString *)filePath {
    JsenNetworkingSuccessResponse *successResponse = [JsenNetworkingSuccessResponse downloadSuccesResponsesWithResponse:response filePath:[NSURL URLWithString:filePath]];
    if (self.success) {
        self.success(successResponse);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingSuccess:api:)]) {
        [self.delegate jsenNetworkingSuccess:successResponse api:self.apiKey];
    }
}

/**
 处理响应数据
 
 @param response
 */
- (void)handleResponse:(id)response {
    if ([JsenNetworkingConfig shareConfig].responseHandleBlock) {
        response = [JsenNetworkingConfig shareConfig].responseHandleBlock(self.apiKey,response);
    }
    [self successWithResponseObject:response];
    
}

//http 请求成功后处理，如果有自定义的错误码，会处理为failed
- (void)successWithResponseObject:(NSDictionary *)responseObject {
    
    NSNumber * statusCode = responseObject[JsenNetworkingResponseStatusCodeKeyDefine];
    __block BOOL isHaveData = NO;
    [[JsenNetworkingConfig shareConfig].customSuccessDataAllKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (responseObject[obj] != nil) {
            isHaveData = YES;
            *stop = YES;
        }
    }];
    if ((statusCode != nil && [[JsenNetworkingConfig shareConfig].customSuccessStatusCode isEqualToNumber:statusCode]) && isHaveData) {
        
        JsenNetworkingSuccessResponse *response = [JsenNetworkingSuccessResponse responseWithResponseObject:responseObject apiKey:self.apiKey];
        if (self.success) {
            self.success(response);
            return;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingSuccess:api:)]) {
            [self.delegate jsenNetworkingSuccess:response api:self.apiKey];
        }
        
    } else {
        
        JsenNetworkingFailedResponse *response = [JsenNetworkingFailedResponse responseWithResponseObject:responseObject];
        if ([self httpSuccessButCustomError:responseObject[JsenNetworkingResponseStatusCodeKeyDefine]]){
            [self postCustomHttpErrorNotification:response];
        }
        
        if (self.failed) {
            self.failed(response);
            return;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingCustomErrorFailed:api:)]) {
            [self.delegate jsenNetworkingCustomErrorFailed:response api:self.apiKey];
        }
    }
}

//http 请求失败后的处理
- (void)failedWithError:(NSError *)error {
    JsenNetworkingFailedResponse *response = [JsenNetworkingFailedResponse responseWithError:error];
    
    if (self.failed) {
        self.failed(response);
        return;
    }
    
    if ([self httpSuccessButCustomError:@(error.code)]) {
        [self postCustomHttpErrorNotification:response];
        if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingCustomErrorFailed:api:)]) {
            [self.delegate jsenNetworkingCustomErrorFailed:response api:self.apiKey];
        }
        
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingFailed:api:)]) {
            [self.delegate jsenNetworkingFailed:response api:self.apiKey];
        }
    }
}

//http 请求完毕后的处理
- (void)finish{
    if (self.finished) {
        self.finished();
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingFinished:)]) {
        [self.delegate jsenNetworkingFinished:self.apiKey];
    }
}

//download完成后的处理
- (void)downloadCompletedWith:(NSURLResponse *)response filePath:(NSURL *)filePath error:(NSError *)error {
    if (error) {
        [self failedWithError:error];
        [self finish];
    } else {
        JsenNetworkingSuccessResponse *successResponse = [JsenNetworkingSuccessResponse downloadSuccesResponsesWithResponse:response filePath:filePath];
        if (self.success) {
            self.success(successResponse);
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(jsenNetworkingSuccess:api:)]) {
            [self.delegate jsenNetworkingSuccess:successResponse api:self.apiKey];
        }
        [self finish];
    }
}

#pragma mark - top view controller
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark - network reachability
- (BOOL)networkReachabilityAction {
    if ([JsenNetworkingReachabilityManager manager].currentStatus == JsenNetworkingReachabilityStatusNotReachable) {
        if (self.failed) {
            JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
            
            NSString *customNoNetworkMsg = config.customErrorStatusCode[config.noNetworkStatusCode] ?: JsenNetworkingManager_NoNetworkMsg;
            NSError *error = [NSError errorWithDomain:self.apiKey code:[config.noNetworkStatusCode integerValue] userInfo:@{NSLocalizedDescriptionKey:customNoNetworkMsg}];
            [self failedWithError:error];
            [self finish];
        }
        return NO;
    }
    return YES;
}




#pragma mark - notification error
//发送自定义的http请求错误的通知
- (void)postCustomHttpErrorNotification:(JsenNetworkingFailedResponse * _Nonnull)response {
    [[NSNotificationCenter defaultCenter] postNotificationName:JsenNetworkingCustomHttpErrorNotificationKey object:response];
}

#pragma mark - config
//配置下载路径
- (NSURL *)configDownloadUrlWith:(NSURLResponse *)response filePath:(NSURL *)filePath fileName:(NSString *)fileName {
    NSURL *documentsDirectoryURL = nil;
    if (!filePath) {
        documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    } else {
        documentsDirectoryURL = filePath;
    }
    
    NSString *tmpFileName = nil;
    if (!fileName) {
        tmpFileName = [response suggestedFilename];
    } else {
        tmpFileName = fileName;
    }
    
    return [documentsDirectoryURL URLByAppendingPathComponent:tmpFileName];
}

//配置url 参数拼接
- (NSString *)configUrl:(NSString *)url requestParameters:(NSDictionary *)requestParameters  {
    if (requestParameters.allKeys.count) {
        for (int i=0; i<requestParameters.allKeys.count; i++) {
            id key = requestParameters.allKeys[i];
            id value = requestParameters[key];
            if (i==0) {
                if ([url hasSuffix:@"/"]) {
                    NSMutableString *str = [NSMutableString stringWithString:url];
                    url = [str substringWithRange:NSMakeRange(0, url.length-1)];
                }
                url = [url stringByAppendingFormat:@"?%@=%@",key,value];
            } else {
                url = [url stringByAppendingFormat:@"&%@=%@",key,value];
            }
        }
    }
    return url;
}

#pragma mark - 配置处理
- (void)configRequestBlockWithSuccess:(JsenNetworkingSuccess)success failed:(JsenNetworkingFailed)failed progress:(JsenNetworkingProgress)progress finished:(JsenNetworkingFinished)finished apiKey:(NSString *)apiKey{
    self.success = success;
    self.failed = failed;
    self.progress = progress;
    self.finished = finished;
    self.apiKey = apiKey;
}

//自定义请求错误码判断
- (BOOL)httpSuccessButCustomError:(NSNumber * _Nonnull)statusCode {
    BOOL __block status = NO;
    [[JsenNetworkingConfig shareConfig].customErrorStatusCode enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([statusCode isEqualToNumber:key]) {
            status = YES;
            *stop = YES;
        }
    }];
    return status;
}

//参数拼接
- (id)configParametersWithRequestParameters:(NSDictionary *)parameters {
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    
    NSMutableDictionary *requestParameters = [[NSMutableDictionary alloc] initWithDictionary:config.globalParameters];
    [requestParameters addEntriesFromDictionary:parameters];
    if (config.signBlock && [config.noSignAPI objectForKey:self.apiKey] == nil) {
        NSString *signKey = config.signBlock(requestParameters);
        if (signKey) {
            [requestParameters addEntriesFromDictionary:@{
                                                          config.signKeyName:signKey
                                                          }];
        }
        
    }
    
    if(config.parametersHandleBlock) {
        return config.parametersHandleBlock(self.apiKey,requestParameters);
    }
    return requestParameters;
}

//请求http manager 配置
- (AFHTTPSessionManager *)configHttpSessionManagerWithAPIKey:(NSString *)apiKey {
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:config.host]];
   
    if (config.specialSecurityPolicyMap && [config.specialSecurityPolicyMap.allKeys containsObject:apiKey]) {
        mgr.securityPolicy = [config.specialSecurityPolicyMap objectForKey:apiKey];
        
    } else if(config.securityPolicy) {
        mgr.securityPolicy = config.securityPolicy;
    }
    
    if (config.requestSerializerTypeConfig && config.requestSerializerTypeConfig[apiKey]) {
        switch ([config.requestSerializerTypeConfig[apiKey] integerValue]) {
            case JsenNetworkingConfigSerializerJSON:
                mgr.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
                
            default:
                mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
        }
    }else {
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    //header
    if (config.httpHeader && config.httpHeader.allKeys.count != 0) {
        [config.httpHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [mgr.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    //超时时间
    mgr.requestSerializer.timeoutInterval = [config timeoutIntervalWithAPIKey:apiKey];
    return mgr;
}

//download manager 配置
- (AFURLSessionManager *)configURLSessionManager {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *mgr = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    return mgr;
}

@end
