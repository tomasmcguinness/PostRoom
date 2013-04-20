//
//  BuildingModel.h
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Building.h"

@protocol BuildingModelDelegate <NSObject>

- (void)buildingLoadingStarted;
- (void)buildingLoadingComplete;
- (void)buildingLoadingFailed;

@end

@interface BuildingModel : NSObject

@property (nonatomic) id<BuildingModelDelegate> delegate;
@property (nonatomic) NSArray *buildings;

- (void)loadBuildings:(NSNumber *)estateId;

@end
