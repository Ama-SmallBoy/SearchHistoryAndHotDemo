//
//  CSWarterTagCell.m
//  WaterfallFlowTagsDemo
//
//  Created by Xdf on 2020/6/14.
//  Copyright © 2020 Xdf. All rights reserved.
//

#import "GTHotCell.h"
#import "GTHistorySearchModel.h"
@interface GTHotCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation GTHotCell

-(void)bindObject:(id)object
  contentColor:(UIColor *)contentColor
   contentFont:(UIFont*)contentFont
contentBGColor:(UIColor*)contentBGColor{

    self.titleLabel.font = contentFont;
    self.titleLabel.textColor = contentColor;
    
    GTHistorySearchModel * warterTagsModel = (GTHistorySearchModel*)object;
    self.titleLabel.text = warterTagsModel.title;
    if ([warterTagsModel.title isEqualToString:@""]) {
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = NO;
    }else{
        self.titleLabel.backgroundColor = contentBGColor;
        self.userInteractionEnabled = YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.cornerRadius = 15.0;
}

@end
