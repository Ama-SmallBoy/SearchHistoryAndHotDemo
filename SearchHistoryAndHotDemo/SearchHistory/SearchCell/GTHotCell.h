//
//  CSWarterTagCell.h
//  WaterfallFlowTagsDemo
//
//  Created by  星梦 on 2020/6/14.
//  Copyright © 2020  星梦. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTHotCell : UICollectionViewCell
- (void)bindObject:(id)object
     contentColor:(UIColor *)contentColor
      contentFont:(UIFont *)contentFont
   contentBGColor:(UIColor *)contentBGColor;
@end

NS_ASSUME_NONNULL_END
