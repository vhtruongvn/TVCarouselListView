//
//  PhotoCarousel.m
//  TVCarouselListView
//
//  Created by Ray Vo on 29/4/15.
//  Copyright (c) 2015 Truong Vo. All rights reserved.
//

#import "CarouselView.h"

@implementation CarouselView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - Touches Management

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.superview touchesCancelled:touches withEvent:event];
    } else {
        [super touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.superview touchesMoved:touches withEvent:event];
    } else {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.superview touchesBegan:touches withEvent:event];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.superview touchesEnded:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

@end
