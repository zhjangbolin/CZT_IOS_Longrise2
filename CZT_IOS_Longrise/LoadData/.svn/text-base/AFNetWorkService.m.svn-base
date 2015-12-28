//
//  AFNetWorkService.m
//  TBRJL
//
//  Created by 程三 on 15/6/10.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "AFNetWorkService.h"
#import "AFHTTPRequestOperationManager.h"
#import "Globle.h"
#import "SearchParameters.h"
#import "EntityBean.h"
#import "AFURLSessionManager.h"

@implementation AFNetWorkService

-(void)requestWithServiceIP:(NSString *) serviceIP ServiceName:(NSString *)serviceName params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod resultIsDictionary:(BOOL)resultIsDictionary completeBlock:(RequestCompelete)block
{
    
    
    //拼接URL
    NSString *url = [NSString stringWithFormat:@"%@%@/query",serviceIP,serviceName];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if(!resultIsDictionary)
    {
        manager.responseSerializer = [AFCompoundResponseSerializer serializer];//响应
    }
    else
    {
        //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    
    //设置相应内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain",@"text/javascript",nil];

    NSArray *array = [params allKeys];
    if(array.count != 0)
    {
        for (int  i = 0; i < array.count; i++)
        {
            NSString *key = array[i];
            id object = [params objectForKey:key];
            
            //判断参数类型
            if([object isKindOfClass:[NSNumber class]])
            {
                
            }
            else if([object isKindOfClass:[NSString class]])
            {
                
            }
            else if([object isKindOfClass:[NSData class]])
            {
            
            }
            else
            {
                NSString *string = [self objectToJson:object];
                [params setValue:string forKey:key];
            }
        }
    }

    
    //处理POST的参数
    NSComparisonResult compareRet = [httpMethod caseInsensitiveCompare:@"POST"];
    if(NSOrderedSame == compareRet)
    {
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            if(block != nil)
            {
                block(resultIsDictionary ? responseObject:operation.responseString);
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"调用服务出错(POST)");
            if(block != nil)
            {
                block(nil);
            }
        }];
    }
    else
    {
        [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            if(block != nil)
            {
                block(resultIsDictionary ? responseObject:operation.responseString);
                
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"调用服务出错(GET)");
            if(block != nil)
            {
                block(nil);
            }
        }];
    }
}


//上传文件
-(void)uploadUrl:(NSString *)url
            fileFullPath:(NSString *)fileFullpath
            params:(NSMutableDictionary *)params
            name:(NSString *)name
            fileName:(NSString *)fileName
            completeBlock:(RequestCompelete)block;
{
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileFullpath] name:name fileName:fileName mimeType:@"text/html" error:nil];
    } error:nil];

    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
        {
        if (error)
        {
            if(block != nil)
            {
                block(nil);
            }
            NSLog(@"上传ZIP包出错，错误信息: %@", error);
        }
        else
        {
            if(block != nil)
            {
                block(responseObject);
            }
        }
    }];
    
    [uploadTask resume];
}

-(NSString*)objectToJson:(NSObject *)object
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
