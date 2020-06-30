//
//  GTHistoryCell1.h
//  WaterfallFlowTagsDemo
//
//  Created by Xdf on 2020/6/15.
//  Copyright © 2020 Xdf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GTHistoryCell;
@protocol GTHistoryCelllDelegate <NSObject>

-(void)GTHistoryCell:(UICollectionViewCell*)cell didDelectforIndexpath:(NSIndexPath *)indepath;

@end
@interface GTHistoryCell : UICollectionViewCell
-(void)bindObject:(id)object
  contentColor:(UIColor *)contentColor
   contentFont:(UIFont*)contentFont;
@property (weak, nonatomic) id<GTHistoryCelllDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexpath;
@end

NS_ASSUME_NONNULL_END
