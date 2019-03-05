//
//  WYNetworkCache.m
//  WYNetWorking
//
//  Created by 吴述雄 on 2019/2/28.
//  Copyright © 2019 Triumen. All rights reserved.
//

#import "WYNetworkCache.h"
#import "YYCache.h"

static NSString *const kWYNetworkResponseCache = @"kWYNetworkResponseCache";

@implementation WYNetworkCache
 static YYCache *_dataCache;
    
+ (void)initialize {
    _dataCache = [YYCache cacheWithName:kWYNetworkResponseCache];
}
    
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}
    
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}
    
+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}
    
+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}
    
+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}

    
@end
