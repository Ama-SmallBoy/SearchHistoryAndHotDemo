//
//  GTHistoryCell1.m
//  WaterfallFlowTagsDemo
//
//  Created by Xdf on 2020/6/15.
//  Copyright © 2020 Xdf. All rights reserved.
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
    GTHistorySearchModel * warterTagsModel = (GTHistorySearchModel*)object;
    self.titleLabel.text = warterTagsModel.title;
    self.titleLabel.font = contentFont;
    self.titleLabel.textColor = contentColor;
}
- (IBAction)deletedHistoryRecordAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(GTHistoryCell:didDelectforIndexpath:)]) {
         [self.delegate GTHistoryCell:self didDelectforIndexpath:self.indexpath];
     }
}
@end
