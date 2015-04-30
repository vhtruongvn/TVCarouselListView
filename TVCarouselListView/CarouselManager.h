//
//  CarouselManager.h
//  TVCarouselListView
//
//  Created by Ray Vo on 29/4/15.
//  Copyright (c) 2015 Truong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarouselManager : NSObject

+ (id)sharedManager;

- (void)setPage:(int)page forKey:(NSString *)key;
- (int)getPageForKey:(NSString *)key;
- (void)setContentOffset:(float)x forKey:(NSString *)key;
- (int)getContentOffsetForKey:(NSString *)key;

@end
