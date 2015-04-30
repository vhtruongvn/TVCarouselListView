//
//  CarouselManager.m
//  TVCarouselListView
//
//  Created by Ray Vo on 29/4/15.
//  Copyright (c) 2015 Truong Vo. All rights reserved.
//

#import "CarouselManager.h"

static NSMutableDictionary *pageDictionary;
static NSMutableDictionary *offsetDictionary;

@implementation CarouselManager

- (id)init {
    if (self = [super init]) {
        pageDictionary = [[NSMutableDictionary alloc] init];
        offsetDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Singleton Methods

+ (id)sharedManager {
    static CarouselManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (void)setPage:(int)page forKey:(NSString *)key {
    [pageDictionary setValue:[NSString stringWithFormat:@"%i", page] forKey:key];
}

- (int)getPageForKey:(NSString *)key {
    return [[pageDictionary valueForKey:key] intValue];
}

- (void)setContentOffset:(float)x forKey:(NSString *)key {
    [offsetDictionary setValue:[NSString stringWithFormat:@"%f", x] forKey:key];
}

- (int)getContentOffsetForKey:(NSString *)key {
    return [[offsetDictionary valueForKey:key] floatValue];
}

@end
