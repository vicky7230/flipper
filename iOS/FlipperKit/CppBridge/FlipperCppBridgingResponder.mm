/*
 *  Copyright (c) 2018-present, Facebook, Inc.
 *
 *  This source code is licensed under the MIT license found in the LICENSE
 *  file in the root directory of this source tree.
 *
 */
#import "FlipperCppBridgingResponder.h"

#import <FBCxxUtils/FBCxxFollyDynamicConvert.h>

@implementation FlipperCppBridgingResponder {
  std::unique_ptr<facebook::flipper::FlipperResponder> responder_;
}

- (instancetype)initWithCppResponder:(std::unique_ptr<facebook::flipper::FlipperResponder>)responder
{
  if (!responder) {
    return nil;
  }

  if (self = [super init]) {
    responder_ = std::move(responder);
  }

  return self;
}

#pragma mark - FlipperResponder

- (void)success:(NSDictionary *)response { responder_->success(facebook::cxxutils::convertIdToFollyDynamic(response, true)); }

- (void)error:(NSDictionary *)response { responder_->error(facebook::cxxutils::convertIdToFollyDynamic(response, true)); }

@end
