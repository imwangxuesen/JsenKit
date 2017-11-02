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

1. JsenNetworkingConfig must be init . eg：
```

    JsenNetworkingConfig *config = [JsenNetworkingConfig shareConfig];
   
    //host
    config.host = @"http://test.jsen.com/demo";
    
    //url and response data model， if no data model，or don't wanna create model, could be omited.
    //JsenHomeCellModel 
    config.modelClass = @{
                          Jsen_HomeList_API:NSClassFromString(@"JsenHomeCellModel")
                          };
    
	 //global parameters 
    config.globalParametersBlock = ^NSDictionary *{
        return @{
        		//some keys and values
        };
    };
    
    
    /*
     response error code notification 
     eg token timeout
     eg
     
	  //add notification
     JsenNetworkingCustomHttpErrorNotificationKey in “JsenNetworkingConfig.h” file
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commonNetworkErrorNotification:) name:JsenNetworkingCustomHttpErrorNotificationKey object:nil];

     // resive notification 
     - (void)commonNetworkErrorNotification:(NSNotification *)notifi {
        JsenNetworkingFailedResponse *response = [notifi object];
        NSLog(@"%@",notifi);
     }
     */
    config.customErrorStatusCode = @{
                                     @(Jsen_Notification_Error_Code.integerValue):@"token timeout.please relogin"
                                     };
    
    
    /*
		request timeout
		if you wanna more custom, you should see `timeoutInterval` property
     */
    config.defaultTimeoutInterval = 30;
    
    
    /**
		networking reachability

      [JsenNetworkingReachabilityManager manager].currentStatus could get networking current status when startMonitoring
     */
    [[JsenNetworkingReachabilityManager manager] setJsenReachabilityStatusChangeBlock:^(JsenNetworkingReachabilityStatus status) {
        //to do something
    }];
    [[JsenNetworkingReachabilityManager manager] startMonitoring];
``` 

