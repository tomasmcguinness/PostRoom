//
//  PostModel.h
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PackageModel.h"

@protocol PostModelDelegate<NSObject>

- (void)updateSkippedNoRegistered;
- (void)updatePostComplete;
- (void)updatingPost;

@end

@interface PostModel : NSObject

@property (nonatomic) id<PostModelDelegate> delegate;
@property (nonatomic, strong) NSNumber *numberOfItems;
@property (nonatomic, strong) NSArray *itemHistory;
@property (nonatomic, strong) NSDate *lastUpdated;

- (void)updatePost:(NSString *)deviceIdentifier;

@end
