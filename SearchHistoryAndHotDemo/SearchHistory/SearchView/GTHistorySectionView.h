//
//  XWHistorySectionView.h
//  XWHistorySearch
//
//  Created by 李学文 on 2019/1/15.
//  Copyright © 2019年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class GTHistorySectionView;
@protocol GTHistorySectionViewDelegate <NSObject>
-(void)GTHistorySectionViewClear;
@end
@interface GTHistorySectionView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *title_bl;
@property (weak, nonatomic) IBOutlet UIButton *clear_Btn;
@property (weak, nonatomic)  id<GTHistorySectionViewDelegate>  delegate;
- (IBAction)clickClearButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END

