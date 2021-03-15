//
//  GTHistoryCell1.h
//  WaterfallFlowTagsDemo
//
//  Created by  星梦 on 2020/6/15.
//  Copyright © 2020  星梦. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GTHistoryCell;
@protocol GTHistoryCelllDelegate <NSObject>

- (void)zgt_historyCell:(UICollectionViewCell *)cell didDelectforIndexpath:(NSIndexPath *)indepath;

@end
@interface GTHistoryCell : UICollectionViewCell
- (void)bindObject:(id)object contentColor:(UIColor *)contentColor contentFont:(UIFont *)contentFont;
@property (weak, nonatomic) id<GTHistoryCelllDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexpath;
@end

NS_ASSUME_NONNULL_END
