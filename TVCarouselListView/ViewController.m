//
//  ViewController.m
//  TVCarouselListView
//
//  Created by Ray Vo on 29/4/15.
//  Copyright (c) 2015 Truong Vo. All rights reserved.
//

#import "ViewController.h"
#import "CarouselCell.h"
#import "CarouselContent.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    CarouselManager *manager; // carousel pagination manager
    NSMutableArray *carouselList;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [CarouselManager sharedManager];
    carouselList = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        CarouselContent *carouselContent = [CarouselContent new];
        switch (i) {
            case 0:
                carouselContent.title = @"Featured";
                break;
            case 1:
                carouselContent.title = @"Popular";
                break;
            case 2:
                carouselContent.title = @"Entertainment";
                break;
            case 3:
                carouselContent.title = @"Gaming";
                break;
            case 4:
                carouselContent.title = @"Music";
                break;
            case 5:
                carouselContent.title = @"Others";
                break;
            default:
                carouselContent.title = [NSString stringWithFormat:@"Carousel %d", i];
                break;
        }
        carouselContent.videos = @[
                                    @{ @"title": @"Video 1", @"description": @"Video description 0", @"photo": @"0" },
                                    @{ @"title": @"Video 1", @"description": @"Video description 1", @"photo": @"1" },
                                    @{ @"title": @"Video 1", @"description": @"Video description 2", @"photo": @"2" },
                                    @{ @"title": @"Video 1", @"description": @"Video description 3", @"photo": @"3" },
                                    @{ @"title": @"Video 4", @"description": @"Video description 4", @"photo": @"4" },
                                    @{ @"title": @"Video 5", @"description": @"Video description 5", @"photo": @"5" },
                                    @{ @"title": @"Video 6", @"description": @"Video description 6", @"photo": @"6" },
                                    @{ @"title": @"Video 7", @"description": @"Video description 7", @"photo": @"7" },
                                    @{ @"title": @"Video 8", @"description": @"Video description 8", @"photo": @"8" },
                                    @{ @"title": @"Video 9", @"description": @"Video description 9", @"photo": @"9" },
                                    @{ @"title": @"Video 10", @"description": @"Video description 10", @"photo": @"10" },
                                    @{ @"title": @"Video 11", @"description": @"Video description 11", @"photo": @"11" },
                                    @{ @"title": @"Video 12", @"description": @"Video description 12", @"photo": @"12" }
                                ];
        [carouselList addObject:carouselContent];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return carouselList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CarouselContent *carouselContent = [carouselList objectAtIndex:section];
    return carouselContent.title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 235;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CarouselCell";
    CarouselCell *cell = (CarouselCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.delegate = self;
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.infoLabel.text = @"Photo Name";
    cell.infoLabel.textColor = [UIColor blackColor];
    cell.infoLabel.highlightedTextColor = [UIColor blackColor];
    
    CarouselContent *carouselContent = [carouselList objectAtIndex:indexPath.section];
    
    // *** Tagging
    int tag = (int)indexPath.section + 1;
    cell.tag = tag; // important for the carousel pagination
    
    // Carousel
    // Clean up first
    for (id subview in cell.carouselView.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
    cell.carouselView.contentSize = CGSizeZero;
    [cell setPage:0];
    [cell setContentOffsetX:0];
    
    // Carousel content
    int photoCount = 0;
    int pageWidth = 300;
    if ([carouselContent.videos isKindOfClass:[NSArray class]]) {
        if ([carouselContent.videos count] > 0) {
            for (int i = 0; i < carouselContent.videos.count; i++) {
                NSDictionary *video = [carouselContent.videos objectAtIndex:i];
                if (video != nil) {
                    CGRect frame;
                    frame.origin.x = pageWidth * i;
                    frame.origin.y = 0;
                    frame.size.height = 169;
                    frame.size.width = pageWidth - 1;
                    
                    NSLog(@"Video thumb %d %@", i, NSStringFromCGRect(frame));
                    
                    UIImageView *_coverImageView = [[UIImageView alloc] initWithFrame:frame];
                    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
                    _coverImageView.image = [UIImage imageNamed:@"placeholder"];
                    _coverImageView.tag = i+1;
                    [cell.carouselView addSubview:_coverImageView];
                    
                    CGRect lableFrame;
                    lableFrame.origin.x = frame.origin.x;
                    lableFrame.origin.y = 175;
                    lableFrame.size.height = 43;
                    lableFrame.size.width = frame.size.width;
                    
                    UILabel *videoInfo = [[UILabel alloc] initWithFrame:lableFrame];
                    videoInfo.numberOfLines = 2;
                    videoInfo.text = [NSString stringWithFormat:@"%@\n%@", [video objectForKey:@"title"], [video objectForKey:@"description"]];
                    videoInfo.tag = _coverImageView.tag * 1000;
                    [cell.carouselView addSubview:videoInfo];
                    
                    photoCount += 1;
                }
            }
        }
    }
    // if no photos, show a placeholder
    if (photoCount == 0) {
        CGRect frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        frame.size = cell.carouselView.frame.size;
        frame.size.width = pageWidth - 1;
        
        UIImageView *_coverImageView = [[UIImageView alloc] initWithFrame:frame];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.image = [UIImage imageNamed:@"placeholder"];
        _coverImageView.tag = 1;
        [cell.carouselView addSubview:_coverImageView];
        
        CGRect lableFrame;
        lableFrame.origin.x = frame.origin.x;
        lableFrame.origin.y = 184;
        lableFrame.size.height = 43;
        lableFrame.size.width = frame.size.width;
        
        UILabel *videoInfo = [[UILabel alloc] initWithFrame:lableFrame];
        videoInfo.numberOfLines = 2;
        videoInfo.text = @"";
        videoInfo.tag = _coverImageView.tag * 1000;
        [cell.carouselView addSubview:videoInfo];
        
        photoCount += 1;
    }
    cell.carouselView.contentSize = CGSizeMake(pageWidth * photoCount, cell.carouselView.frame.size.height);
    [cell setPage:[manager getPageForKey:[NSString stringWithFormat:@"%i", tag]]];
    [cell setContentOffsetX:[manager getContentOffsetForKey:[NSString stringWithFormat:@"%i", tag]]];
    
    // Load visible images
    NSLog(@"*** Cell %d: %f - %f", (int)indexPath.section, cell.carouselView.contentSize.width, cell.currentOffsetX);
    [self loadVisibleImagesForCell:cell];
    
    return cell;
}

- (void)loadVisibleImagesForCell:(CarouselCell *)cell {
    int listIndex = (int)cell.tag - 1;
    if ([carouselList count] > listIndex) {
        CarouselContent *carouselContent = [carouselList objectAtIndex:listIndex];
        if (carouselContent != nil) {
            for (id subview in cell.carouselView.subviews) {
                if ([subview isKindOfClass:[UIImageView class]]) {
                    // if image is visible
                    if (CGRectIntersectsRect(cell.carouselView.bounds, [(UIImageView *)subview frame])) {
                        int actualVideoIndex = (int)[subview tag] - 1;
                        if ([carouselContent.videos isKindOfClass:[NSArray class]]
                            && [carouselContent.videos count] > actualVideoIndex) {
                            //[cell.carouselView bringSubviewToFront:subview];
                            
                            NSDictionary *video = [carouselContent.videos objectAtIndex:actualVideoIndex];
                            
                            [(UIImageView *)subview setImage:[UIImage imageNamed:[video objectForKey:@"photo"]]];
                            
                            // Preload next image
                            int nextVideoIndex = actualVideoIndex + 1;
                            int nextSubviewIndex = nextVideoIndex + 1;
                            UIImageView *nextVideoThumb = (UIImageView *)[cell.carouselView viewWithTag:nextSubviewIndex];
                            if (nextVideoThumb != nil
                                && [carouselContent.videos isKindOfClass:[NSArray class]]
                                && [carouselContent.videos count] > nextVideoIndex) {
                                NSDictionary *nextVideo = [carouselContent.videos objectAtIndex:nextVideoIndex];
                                
                                [nextVideoThumb setImage:[UIImage imageNamed:[nextVideo objectForKey:@"photo"]]];
                            }
                        }
                    }
                } else if ([subview isKindOfClass:[UILabel class]]) {
                    // if label is visible
                    if (CGRectIntersectsRect(cell.carouselView.bounds, [(UILabel *)subview frame])) {
                        int actualVideoIndex = (int)[subview tag] - 1;
                        if ([carouselContent.videos isKindOfClass:[NSArray class]]
                            && [carouselContent.videos count] > actualVideoIndex) {
                            //[cell.carouselView bringSubviewToFront:subview];
                            
                            NSDictionary *video = [carouselContent.videos objectAtIndex:actualVideoIndex];
                            
                            [(UILabel *)subview setText:[NSString stringWithFormat:@"%@\n%@", [video objectForKey:@"title"], [video objectForKey:@"description"]]];
                            
                            // Preload next label
                            int nextVideoIndex = actualVideoIndex + 1;
                            int nextSubviewIndex = nextVideoIndex * 1000;
                            UILabel *nextVideoInfo = (UILabel *)[cell.carouselView viewWithTag:nextSubviewIndex];
                            if (nextVideoInfo != nil
                                && [carouselContent.videos isKindOfClass:[NSArray class]]
                                && [carouselContent.videos count] > nextVideoIndex) {
                                NSDictionary *nextVideo = [carouselContent.videos objectAtIndex:nextVideoIndex];
                                
                                [(UILabel *)subview setText:[NSString stringWithFormat:@"%@\n%@", [nextVideo objectForKey:@"title"], [nextVideo objectForKey:@"description"]]];
                            }
                        }
                    }
                }
            }
        }
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
