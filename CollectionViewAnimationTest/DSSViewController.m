//
//  Created by Pete Callaway on 28/05/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

#import "DSSViewController.h"

#import "DSSCell.h"


@interface DSSViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *items;

@end


@implementation DSSViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _items = [@[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5"] mutableCopy];
    }

    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DSSCell *cell = (DSSCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DSSCell class]) forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%@", self.items[indexPath.row]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    if (indexPath.row > 0) {
        // Move the tapped item to the top
        [collectionView performBatchUpdates:^{
            [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

            id item = self.items[indexPath.row];
            [self.items removeObjectAtIndex:indexPath.row];
            [self.items insertObject:item atIndex:0];
        } completion:nil];
    }
}


@end
