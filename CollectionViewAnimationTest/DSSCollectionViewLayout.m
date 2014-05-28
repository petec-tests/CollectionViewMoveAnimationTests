//
//  Created by Pete Callaway on 28/05/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

#import "DSSCollectionViewLayout.h"


@implementation DSSCollectionViewLayout

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems {
    [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:UIViewKeyframeAnimationOptionAllowUserInteraction | UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{

        for (UICollectionViewUpdateItem *item in updateItems) {

            if (item.updateAction == UICollectionUpdateActionMove) {
                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:item.indexPathBeforeUpdate];

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

@end
