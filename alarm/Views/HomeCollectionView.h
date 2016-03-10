//
//  HomeCollectionView.h
//  alarm
//
//  Created by 钟文锋  on 15/10/24.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCollectionViewDelegate;

@interface HomeCollectionView : UIView

@property (nonatomic, weak) id<HomeCollectionViewDelegate> homeDelegate;

@end

@protocol HomeCollectionViewDelegate <NSObject>

@optional
- (void)didSelectItem:(NSMutableArray *)modelArray;
@end
