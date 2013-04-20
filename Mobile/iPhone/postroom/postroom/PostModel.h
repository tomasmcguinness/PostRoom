//
//  PostModel.h
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsModel.h"

@protocol PostModelDelegate<NSObject>

- (void)updateSkippedNoRegistered;
- (void)updatePostComplete;

@end

@interface PostModel : NSObject

@property (nonatomic) id<PostModelDelegate> delegate;
@property (nonatomic) NSNumber *numberOfItems;

- (void)updatePost;

@end
