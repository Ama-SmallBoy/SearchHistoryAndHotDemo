//
//  GTHistoryCell1.m
//  WaterfallFlowTagsDemo
//
//  Created by  星梦 on 2020/6/15.
//  Copyright © 2020  星梦. All rights reserved.
//

#import "GTHistoryCell.h"
#import "GTHistorySearchModel.h"
@interface GTHistoryCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation GTHistoryCell
-(void)bindObject:(id)object
  contentColor:(UIColor *)contentColor
   contentFont:(UIFont*)contentFont{
    self.titleLabel.layer.cornerRadius = 5.0;
    GTHistorySearchModel *warterTagsModel = (GTHistorySearchModel *)object;
    self.titleLabel.text = warterTagsModel.title;
    self.titleLabel.font = contentFont;
    self.titleLabel.textColor = contentColor;
}
- (IBAction)deletedHistoryRecordAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(zgt_historyCell:didDelectforIndexpath:)]) {
         [self.delegate zgt_historyCell:self didDelectforIndexpath:self.indexpath];
     }
}
@end
