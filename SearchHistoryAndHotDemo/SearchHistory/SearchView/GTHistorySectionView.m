//
//  GTHistorySectionView.m
//  GTHistorySection
//
//  Created by Xdf on 2020/6/14.
//  Copyright © 2020 Xdf. All rights reserved.
//


#import "GTHistorySectionView.h"

@implementation GTHistorySectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)clickClearButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(GTHistorySectionViewClear)]) {
        [self.delegate GTHistorySectionViewClear];
    }
}
@end
