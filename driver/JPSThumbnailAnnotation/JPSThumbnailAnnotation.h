//
//  JPSThumbnailAnnotation.h
//  JPSThumbnailAnnotationView
//
//  Created by Jean-Pierre Simard on 4/21/13.
//  Copyright (c) 2013 JP Simard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "JPSThumbnail.h"
#import "JPSThumbnailAnnotationView.h"

@protocol JPSThumbnailAnnotationProtocol <NSObject>

- (MAAnnotationView *)annotationViewInMap:(MAMapView *)mapView;

@end

@interface JPSThumbnailAnnotation : NSObject <MAAnnotation, JPSThumbnailAnnotationProtocol>

@property (nonatomic, strong) JPSThumbnailAnnotationView *view;
@property (nonatomic, strong) JPSThumbnail *thumbnail;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (id)initWithThumbnail:(JPSThumbnail *)thumbnail;
- (void)updateThumbnail:(JPSThumbnail *)thumbnail animated:(BOOL)animated;

@end
