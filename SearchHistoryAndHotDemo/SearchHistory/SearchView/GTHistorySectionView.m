//
//  GTHistorySectionView.m
//  GTHistorySection
//
//  Created by  星梦 on 2020/6/14.
//  Copyright © 2020  星梦. All rights reserved.
//


#import "GTHistorySectionView.h"

@implementation GTHistorySectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)clickClearButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(zgt_historySectionViewClear)]) {
        [self.delegate zgt_historySectionViewClear];
    }
}
@end
