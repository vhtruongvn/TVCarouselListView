//
//  ViewController.h
//  TVCarouselListView
//
//  Created by Ray Vo on 29/4/15.
//  Copyright (c) 2015 Truong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarouselCell;

@interface ViewController : UIViewController

- (void)loadVisibleImagesForCell:(CarouselCell *)cell;

@end

