//
//  ApartmentModel.h
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Apartment.h"

@protocol ApartmentModelDelegate <NSObject>

- (void)apartmentLoadingStarted;
- (void)apartmentLoadingComplete;
- (void)apartmentLoadingFailed;

@end

@interface ApartmentModel : NSObject

@property (nonatomic) id<ApartmentModelDelegate> delegate;
@property (nonatomic) NSArray *apartments;

- (void)loadApartments:(NSNumber *)buildingId;

@end
