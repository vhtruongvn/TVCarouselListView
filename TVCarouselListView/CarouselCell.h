//
//  CarouselCell.h
//  TVCarouselListView
//
//  Created by Ray Vo on 29/4/15.
//  Copyright (c) 2015 Truong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselView.h"
#import "CarouselManager.h"

@interface CarouselCell : UITableViewCell <UIScrollViewDelegate> {
    CarouselManager *manager;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, weak) IBOutlet CarouselView *carouselView;
@property int currentPage;
@property float currentOffsetX;

- (void)setPage:(int)page;
- (void)setContentOffsetX:(float)x;

@end
