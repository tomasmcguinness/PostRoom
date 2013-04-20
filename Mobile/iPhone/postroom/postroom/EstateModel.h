//
//  EstateModel.h
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Estate.h"

@protocol EstateModelDelegate <NSObject>

- (void)estateLoadingStarted;
- (void)estateLoadingComplete;
- (void)estateLoadingFailed;

@end

@interface EstateModel : NSObject

@property (nonatomic) id<EstateModelDelegate> delegate;
@property (nonatomic) NSArray *estates;

- (void)loadEstates;

@end
