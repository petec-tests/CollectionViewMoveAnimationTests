//
//  Created by Pete Callaway on 28/05/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

#import "DSSCollectionViewLayout.h"


@implementation DSSCollectionViewLayout

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems {
    [super prepareForCollectionViewUpdates:updateItems];

    // Determine which cells will move
    NSMutableSet *movingIndexPaths = [[NSMutableSet alloc] init];

    for (UICollectionViewUpdateItem *item in updateItems) {
        if (item.updateAction == UICollectionUpdateActionMove) {
            [movingIndexPaths addObject:item.indexPathBeforeUpdate];

            // Check of the item has moved to a different section
            if (item.indexPathAfterUpdate.section != item.indexPathBeforeUpdate.section) {
                continue;
            }

            // Add all the rows between the moved cell's start and end row
            NSUInteger startRow, endRow;
            if (item.indexPathBeforeUpdate.row > item.indexPathAfterUpdate.row) {
                startRow = item.indexPathAfterUpdate.row;
                endRow = item.indexPathBeforeUpdate.row;
            }
            else {
                startRow = item.indexPathBeforeUpdate.row;
                endRow = item.indexPathAfterUpdate.row;
            }

            for (NSUInteger row = startRow; row <= endRow; row++) {
                [movingIndexPaths addObject:[NSIndexPath indexPathForRow:row inSection:item.indexPathBeforeUpdate.section]];
            }
        }
    }

    // Add some animation to the moving cells
    if (movingIndexPaths.count > 0) {
        [UIView animateKeyframesWithDuration:0.25 delay:0.0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState | UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            for (NSIndexPath *indexPath in movingIndexPaths) {
                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];

                if (cell != nil) {
                    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
                    }];

                    [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                        cell.layer.transform = CATransform3DIdentity;
                    }];
                }
            }
        } completion:nil];
    }
}

@end
