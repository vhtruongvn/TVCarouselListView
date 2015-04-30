//
//  CarouselCell.m
//  TVCarouselListView
//
//  Created by Ray Vo on 29/4/15.
//  Copyright (c) 2015 Truong Vo. All rights reserved.
//

#import "CarouselCell.h"
#import "ViewController.h"

@implementation CarouselCell

- (void)awakeFromNib {
    manager = [CarouselManager sharedManager];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
}

- (void)setPage:(int)page {
    _currentPage = page;
}

- (void)setContentOffsetX:(float)x {
    [_carouselView setContentOffset:CGPointMake(x, _carouselView.contentOffset.y)];
    _currentOffsetX = x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // page calculation
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page) {
        _currentPage = (int)page;
        [manager setPage:_currentPage forKey:[NSString stringWithFormat:@"%i", (int)self.tag]];
        
        previousPage = page;
    }
    
    // offset x
    [manager setContentOffset:scrollView.contentOffset.x forKey:[NSString stringWithFormat:@"%i", (int)self.tag]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_delegate != nil) {
        if ([_delegate respondsToSelector:@selector(loadVisibleImagesForCell:)]) {
            [_delegate performSelector:@selector(loadVisibleImagesForCell:) withObject:self];
        }
    }
}

@end
