//
//  CSWarterTagsView.h
//  WaterfallFlowTagsDemo
//
//  Created by Xdf on 2020/6/14.
//  Copyright © 2020 Xdf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark --- 历史记录 展示 样式 --
typedef enum : NSUInteger {
    UnOrderHistoryStyle, //无序
    ListHistoryStyle,   //列表样式
} HistoryStyle;

//选中人气类模块回调
typedef void(^SelectOtherDataBlock)(NSIndexPath *index);
//选中历史回调
typedef void(^SelectHistoryDataBlock)(NSInteger row);
// 删除全部历史
typedef void(^DelectAllHistoryDataBlock)(void);
// 删除某一条历史数据
typedef void(^DeletHistoryRowDataBlock)(NSInteger row,NSArray * historyArry);

@interface GTHistorySearchView : UIView
/**
历史搜索上面的其他模块标签（比如：热门，人气）
样式：@[{@"title":"人气","dataArry":@[]},{@"title":"推荐","dataArray":@[]},]
*/
@property(nonatomic,strong) NSArray* hotArray;
/**
 历史数据
 样式：@[@"",@""];
 */
@property (strong, nonatomic) NSArray * historyArry;

/**
 标签的横向间距
 */
@property (assign, nonatomic) CGFloat minimumInteritemSpacing ;

/**
 标签的纵向间距
 */
@property (assign, nonatomic) CGFloat  minimumLineSpacing;

/**
 标签背景色
 */
@property (strong, nonatomic) UIColor * contentBGColor;

/**
 标签文字颜色
 */
@property (strong, nonatomic) UIColor * contentColor;

/**
 标签文字大小
 */
@property (strong, nonatomic) UIFont * contentFont;

/**
 标题文字颜色
 */
@property (strong, nonatomic) UIColor * titleColor;
/**
 标题文字大小
 */
@property (strong, nonatomic) UIFont * titleFont;

/**
 清空按钮的文字
 */
@property (strong, nonatomic) NSString * clearTitle;

/**
 历史记录 展示 样式 默认样式 列表样式：ListHistoryStyle
 */
@property (assign, nonatomic) HistoryStyle historyStyle;


/**
 选中回掉

 @param otherBlock 选中e热门等
 @param historyBlock 选中历史数据
 */
-(void)GTHistorySearchViewWithSelectOtherBlock:(SelectOtherDataBlock)otherBlock SelectHistoryDataBlock:(SelectHistoryDataBlock)historyBlock;

/**
 删除历史记录

 @param delectAllHistoryBlock 删除全部
 @param delectHistoryRowBlock 删除其中一条
 */
-(void)GTHistorySearchViewWithDelectAllHistoryBlock:(DelectAllHistoryDataBlock)delectAllHistoryBlock DeletHistoryRowDataBlock:(DeletHistoryRowDataBlock)delectHistoryRowBlock;

@end

NS_ASSUME_NONNULL_END
