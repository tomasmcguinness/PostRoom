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
- (void)updatingPost;

@end

@interface PostModel : NSObject

@property (nonatomic, strong) SettingsModel *settingsModel;
@property (nonatomic) id<PostModelDelegate> delegate;
@property (nonatomic, strong) NSNumber *numberOfItems;
@property (nonatomic, strong) NSDate *lastUpdated;

- (void)updatePost;

@end
