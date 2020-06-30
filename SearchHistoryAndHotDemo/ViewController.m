//
//  ViewController.m
//  SearchHistoryAndHotDemo
//
//  Created by Xdf on 2020/6/29.
//  Copyright © 2020 Xdf. All rights reserved.
//

#import "ViewController.h"
#import "GTHistorySearchView.h"
@interface ViewController ()
@property(nonatomic,strong) GTHistorySearchView * historySearchView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * dataSource = //@[@"张爽老师",@"鳕鱼老师"];
    @[@"张爽",@"才 gvv哥哥哥哥v",@"哥哥哥哥",@"从vvvvvvvv个",@"大大方方发个广告后不久"];
    self.historySearchView.historyArry = dataSource;
    self.historySearchView.hotArray = @[@{@"title":@"人气老师",@"dataArray":dataSource}];
       __weak typeof(self) weakSelf = self;
       [self.historySearchView GTHistorySearchViewWithSelectOtherBlock:^(NSIndexPath * _Nonnull index) {
           // 点击人气老师
          NSDictionary * infosDic = weakSelf.historySearchView.hotArray[index.section];
          NSArray* dataArray = infosDic[@"dataArray"];
          NSLog(@"===============%@",dataArray[index.row]);
           
       } SelectHistoryDataBlock:^(NSInteger row) {
           NSLog(@"===============%@",weakSelf.historySearchView.historyArry[row]);
       }];
       [self.historySearchView GTHistorySearchViewWithDelectAllHistoryBlock:^{
           NSLog(@"=====全部清空=========%s",__func__);
       } DeletHistoryRowDataBlock:^(NSInteger row, NSArray * historyArry) {
           NSLog(@"=======删除单个=======%s",__func__);
       }];
}
-(GTHistorySearchView *)historySearchView{
    if (!_historySearchView) {
        _historySearchView = [[GTHistorySearchView alloc]initWithFrame:self.view.bounds];
        _historySearchView.contentFont = [UIFont systemFontOfSize:13.0];
        _historySearchView.titleFont = [UIFont systemFontOfSize:14.0];
        _historySearchView.clearTitle = @"";
        //此处 设置 搜索历史显示的样式
        _historySearchView.historyStyle = UnOrderHistoryStyle;
        [self.view addSubview:_historySearchView];
    }
    return _historySearchView;
}
@end

