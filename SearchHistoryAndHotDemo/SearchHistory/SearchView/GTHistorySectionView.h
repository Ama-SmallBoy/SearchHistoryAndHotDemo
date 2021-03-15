//
//  XWHistorySectionView.h
//  XWHistorySearch
//
//  Created by  星梦 on 2019/1/15.
//  Copyright © 2019年  星梦. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class GTHistorySectionView;
@protocol GTHistorySectionViewDelegate <NSObject>

- (void)zgt_historySectionViewClear;

@end
@interface GTHistorySectionView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *title_bl;
@property (weak, nonatomic) IBOutlet UIButton *clear_Btn;
@property (weak, nonatomic)  id<GTHistorySectionViewDelegate>  delegate;
- (IBAction)clickClearButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END

