//
//  APPAPIClient.h
//  sampleios
//
//  Created by Administrator on 10/16/19.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StripeTerminal/StripeTerminal.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPAPIClient : NSObject<SCPConnectionTokenProvider>

+ (APPAPIClient*) shared;

@end

NS_ASSUME_NONNULL_END
