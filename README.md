# Description
JsenKit is iOS project common kit

It contains these functions：
- Network request based on [YYModel](https://github.com/ibireme/YYModel) and [AFNetworking](https://github.com/AFNetworking/AFNetworking)
- Custom Alert (will be update)
- Custom HUD
- Custom TabBar/Button(will be create)/TextView ... UIKit modules
- Frequently-used Category
- Debug Tools eg:FPSLabel

# Installation
JsenKit is available through CocoaPods. To install it, simply add the following line to your Podfile:

```
pod 'JsenKit'
```

# Useage

## JsenNetwork

**Response Format**

default response is json format :
{
	msg:"msg",
	data:{}/[]
	timestemp:1000
	code:0
}

the value with "data" key will be create data model / model array

if you server response format is not like this. you could set `responseFormat` in `JsenNetworkingConfig` class property to convert it

Example:

```
	config.responseFormat =  @{
		JsenNetworkingResponseDataKey       :@"info",
		JsenNetworkingResponseStatusCodeKey :@"codeNumber",
		JsenNetworkingResponseMessageKey    :@"msg",
		JsenNetworkingResponseTimelineKey   :@"time",
	};
```

if your response need diffrent response format, config `customSuccessDataAllKeys` will be a nice way, demo code like that:

```
    config.customSuccessDataAllKeys = [self configSuccessDataAllKeys];

```


### JsenNetworkingConfig must be init . eg：

**Config Host**

```
    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
    config.host = @"http://test.jsen.com/demo";
```

**Response Model**
url and response data model， if no data model，or don't wanna create model, could be omited.
Jsen_HomeList_API(is @"/home/list" defined) api will response data JsenHomeCellModel json
    
    
    
```
	config.modelClass = @{
		Jsen_HomeList_API:NSClassFromString(@"JsenHomeCellModel")
	};
```

**Global Parameters**

```
    config.globalParametersBlock = ^NSDictionary *{
        return @{
        		//some keys and values
        };
    };
```
  
    

**Response Error Code Notification**
eg: token timeout，add notification

JsenNetworkingCustomHttpErrorNotificationKey in “JsenNetworkingConfig.h” file

```
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commonNetworkErrorNotification:) name:JsenNetworkingCustomHttpErrorNotificationKey object:nil];

     // resive notification 
     - (void)commonNetworkErrorNotification:(NSNotification *)notifi {
        JsenNetworkingFailedResponse *response = [notifi object];
        NSLog(@"%@",notifi);
     }
```

**Custom Error Code Notification **
if response code is @10030 , notification center will resive JsenNetworkingCustomHttpErrorNotificationKey's message 

```

    config.customErrorStatusCode = @{
		@(@10030.integerValue):@"token timeout.please relogin"
	};
```

**Request Timeout**
if you wanna more custom, you should see `timeoutInterval` property
```
    config.defaultTimeoutInterval = 30;
```

**Networking Reachability**

[JsenNetworkingReachabilityManager manager].currentStatus could get networking current status when startMonitoring
```
    [[JsenNetworkingReachabilityManager manager] setJsenReachabilityStatusChangeBlock:^(JsenNetworkingReachabilityStatus status) {
        //to do something
    }];
    [[JsenNetworkingReachabilityManager manager] startMonitoring];
```


**RequestSerializer Setting**

[AFHTTPRequestSerializer serializer] is default，you can custom that with specific request API, example:

```
    config.requestSerializerTypeConfig = @{
		Jsen_HomeList_API : @(JsenNetworkingConfigSerializerJSON)
	};
```

**HTTP Header Setting**

```
	config.httpHeader = @{
		@"Content-Type":@"application/json"
	};
```

### Send Request 

```
    NSDictionary *parameters = @{
                                 @"id":@123,
                                 @"page":@1
                                 };
    [[JsenNetworkingManager manager] post:Jsen_HomeList_API parameters:parameters progress:nil success:^(JsenNetworkingSuccessResponse * _Nonnull response) {
    		   //success
				JsenHomeCellModel *model = response.data;
				
				//if response json is array 
				//NSArray *cellModels = response.data;
				
    } failed:^(JsenNetworkingFailedResponse * _Nonnull response) {
				//error
    } finished:^{
           //finished
    }];
```

