//
//  CSWarterTagsView.m
//  WaterfallFlowTagsDemo
//
//  Created by Xdf on 2020/6/14.
//  Copyright © 2020 Xdf. All rights reserved.
//

#import "GTHistorySearchView.h"
#import "GTHotCell.h"
#import "GTHistoryCell.h"
#import "GTHistorySectionView.h"
#import "GTHistorySearchModel.h"

#define kLRSpace 15.0 //左右边距
#define kLineSpace 10.0 //行间距
#define kInterSpacing 10.0 //列间距
#define kTBSpcace 15.0 //标签文字距离背景边距
#define HOTCELLH 30 //标签的高度
#define kViewWidth  (CGRectGetWidth(self.bounds) - kLRSpace*2) // 去除左右边距的宽度
#define SECTIONVIEWH 45 // sectionView高度
#define HISTORYCELLH 45

static NSString * GTHotCellID = @"GTHotCell";
static NSString * GTHistoryCellID = @"GTHistoryCell";


@interface GTHistorySearchView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GTHistorySectionViewDelegate,GTHistoryCelllDelegate>

@property(nonatomic,strong) UICollectionView * collectionView;
@property (strong, nonatomic) SelectHistoryDataBlock selectHistoryBlock;
@property (strong, nonatomic) DelectAllHistoryDataBlock delectAllHistoryBlock;
@property (strong, nonatomic) DeletHistoryRowDataBlock delectHistoryRowBlock ;
@property (strong, nonatomic) SelectOtherDataBlock selectOtherBlock;

//热门 数据源
@property(nonatomic,strong) NSMutableArray * hotModels;
//历史记录 数据源
@property(nonatomic,strong) NSMutableArray * historyModels;
@end
@implementation GTHistorySearchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark --- 设置默认属性
-(void)setUpUI{
    //热门 标签的颜色
    self.contentFont = [UIFont systemFontOfSize:14];
    self.contentColor = [UIColor colorWithRed:109/255.0 green:113/255.0 blue:120/255.0 alpha:1.0];
    
    //热门背景色
    self.contentBGColor = [UIColor colorWithRed:244/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    //历史搜索 字样
    self.titleFont = [UIFont systemFontOfSize:17];
    self.titleColor = [UIColor colorWithRed:151/255.0 green:155/255.0 blue:165/255.0 alpha:1.0];
    
    //清空 文字
    self.clearTitle = @"清空";
    
    self.minimumInteritemSpacing = kInterSpacing;
    self.minimumLineSpacing = kLineSpace;
    self.collectionView.frame = self.bounds;
    self.historyStyle = ListHistoryStyle;
}
#pragma mark -- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.hotModels.count+(self.historyModels.count>0?1:0);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section<self.hotModels.count) {
        // 其他模块的个数
        NSDictionary * dic = self.hotModels[section];
        NSArray * otherData = dic[@"dataArray"];
        return otherData.count;
    }
    return self.historyModels.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section<self.hotModels.count) {
        GTHotCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:GTHotCellID forIndexPath:indexPath];
        NSDictionary * dic = self.hotModels[indexPath.section];
        NSArray * otherData = dic[@"dataArray"];
        [cell bindObject:otherData[indexPath.row] contentColor:self.contentColor contentFont:self.contentFont contentBGColor:self.contentBGColor];
        
        return cell;
    }else{
        if (self.historyStyle == ListHistoryStyle) {
             GTHistoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:GTHistoryCellID forIndexPath:indexPath];
             cell.delegate = self;
             [cell bindObject:self.historyModels[indexPath.row] contentColor:self.contentColor contentFont:self.contentFont];
             return cell;
        }else{
             GTHotCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:GTHotCellID forIndexPath:indexPath];
             [cell bindObject:self.historyModels[indexPath.row]contentColor:self.contentColor contentFont:self.contentFont contentBGColor:self.contentBGColor];
             return cell;
        }
    }
}
/* 设置顶部视图和底部视图 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ( [kind isEqualToString:UICollectionElementKindSectionHeader] ) {//顶部视图
        //获取顶部视图
        GTHistorySectionView *headerV = (GTHistorySectionView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GTHistorySectionView" forIndexPath:indexPath];
        headerV.delegate = self;
        headerV.title_bl.textColor = self.titleColor;
        headerV.title_bl.font = self.titleFont;
        [headerV.clear_Btn setTitle:self.clearTitle forState:UIControlStateNormal];
        //[headerV.clear_Btn setImage:[UIImage imageNamed:@"clearIcon"] forState:UIControlStateNormal];
        if (indexPath.section<self.hotModels.count) {
            headerV.title_bl.text = [self titleOtherforSection:indexPath.section];
            headerV.clear_Btn.hidden = YES;
        }else{
            headerV.title_bl.text = @"历史搜索";
            headerV.clear_Btn.hidden = NO;
        }
        reusableview = headerV;
        
    }
    return reusableview;
}
#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section<self.hotModels.count) {
      NSDictionary * dic = self.hotModels[indexPath.section];
      NSArray * dataArry = dic[@"dataArray"];
      GTHistorySearchModel * warterTagsModel = dataArry[indexPath.row];
      return CGSizeMake(warterTagsModel.itemWidth>0?warterTagsModel.itemWidth:0, HOTCELLH);
    }
    
    if (self.historyStyle == ListHistoryStyle) {
        return CGSizeMake(self.bounds.size.width-15*2, HISTORYCELLH);
    }else{
        GTHistorySearchModel * warterTagsModel = self.historyModels[indexPath.row];
        return CGSizeMake(warterTagsModel.itemWidth>0?warterTagsModel.itemWidth:0, HOTCELLH);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}
#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
      if (section<self.hotModels.count) {
         return self.minimumInteritemSpacing;
      }
    return self.historyStyle == ListHistoryStyle?0:self.minimumInteritemSpacing;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section<self.hotModels.count) {
        return self.minimumLineSpacing;
    }
    return self.historyStyle == ListHistoryStyle?0:self.minimumLineSpacing;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.bounds.size.width, SECTIONVIEWH);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section<self.hotModels.count) {
        NSIndexPath * orginIndexPath = [self fetchIndexPathWithIndexPath:indexPath hotType:YES];
        if (self.selectOtherBlock) {//选中热门等数据
            self.selectOtherBlock(orginIndexPath);
        }
    }else{
        NSIndexPath * indexPathOrigin = nil;
        if (self.historyStyle == ListHistoryStyle) {
            indexPathOrigin = indexPath;
        }else{
            indexPathOrigin = [self fetchIndexPathWithIndexPath:indexPath hotType:NO];
        }
        if (self.selectHistoryBlock) {//选中历史数据
            self.selectHistoryBlock(indexPathOrigin.row);
        }
    }
}
-(NSIndexPath *)fetchIndexPathWithIndexPath:(NSIndexPath *)indexPath hotType:(BOOL)hotType{
    
    if (hotType) {
        //选中的热门
        NSDictionary * modelsInfos = self.hotModels[indexPath.section];
        NSArray * dataArray = modelsInfos[@"dataArray"];
        GTHistorySearchModel * historySearchModel = dataArray[indexPath.row];
        
        //原始数据
        NSDictionary * orginInfos = self.hotArray[indexPath.section];
        NSArray * orginDataArray = orginInfos[@"dataArray"];
        
        NSInteger row = [orginDataArray indexOfObject:historySearchModel.title];
        NSIndexPath * originIndexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
        
        return originIndexPath;
        
    }else{
        //历史记录
        GTHistorySearchModel * historySearchModel = self.historyModels[indexPath.row];
        NSInteger row = [self.historyArry indexOfObject:historySearchModel.title];
        NSIndexPath * originIndexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
        return originIndexPath;
    }
}
#pragma mark -
#pragma mark - coustom delegate
// 清楚全部历史记录
- (void)GTHistorySectionViewClear
{
    // 删除全部历史记录
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定清空历史搜索吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.historyArry = @[];
        if (self.delectAllHistoryBlock) {
            self.delectAllHistoryBlock();
        }
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
//清除历史记录
- (void)GTHistoryCell:(UICollectionViewCell *)cell didDelectforIndexpath:(NSIndexPath *)indepath
{
    NSMutableArray * historyMutArry = self.historyArry.mutableCopy;
    [historyMutArry removeObjectAtIndex:indepath.row];
    self.historyArry  = historyMutArry.copy;
    if (self.delectAllHistoryBlock) {
        self.delectHistoryRowBlock(indepath.row, self.historyArry);
    }
}
#pragma mark -
#pragma mark - coustom tool
-(NSString *)titleOtherforSection:( NSInteger)section
{
    NSDictionary * dic = self.hotModels[section];
    if (![dic.allKeys containsObject:@"title"]) {
        return @"";
    }
    return dic[@"title"];
}
/**
 返回历史标签类容
 @param index 当前位置
 @return 内容
 */
-(NSString *)titleHistoryforindexPath:(NSIndexPath *)index
{
    NSString * string = self.historyArry[index.row];
    if (!string) {
        string = @"";
    }
    return string;
}

#pragma mark -
#pragma mark - event Block 事件回调
-(void)GTHistorySearchViewWithSelectOtherBlock:(SelectOtherDataBlock)otherBlock SelectHistoryDataBlock:(SelectHistoryDataBlock)historyBlock
{
    self.selectOtherBlock = otherBlock;
    self.selectHistoryBlock = historyBlock;
}

-(void)GTHistorySearchViewWithDelectAllHistoryBlock:(DelectAllHistoryDataBlock)delectAllHistoryBlock DeletHistoryRowDataBlock:(DeletHistoryRowDataBlock)delectHistoryRowBlock
{
    self.delectAllHistoryBlock = delectAllHistoryBlock;
    self.delectHistoryRowBlock = delectHistoryRowBlock;
}

#pragma mark -
#pragma mark - customWidth
-(CGFloat)calculateRowWidth:(NSString *)string Font:(UIFont *)font
{
    NSDictionary * dic = @{NSFontAttributeName:font};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT,HOTCELLH) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return (rect.size.width+kTBSpcace*2)>kViewWidth?kViewWidth:(rect.size.width+kTBSpcace*2);
}
#pragma mark ------------- Get 方法 ---
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout  = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:GTHistoryCellID bundle:nil] forCellWithReuseIdentifier:GTHistoryCellID];
        [_collectionView registerNib:[UINib nibWithNibName:GTHotCellID bundle:nil] forCellWithReuseIdentifier:GTHotCellID];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GTHistorySectionView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GTHistorySectionView"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - get 方法 --
-(NSMutableArray *)hotModels{
    if (!_hotModels) {
        _hotModels = [NSMutableArray array];
    }
    return _hotModels;
}
-(NSMutableArray *)historyModels{
    if (!_historyModels) {
        _historyModels = [NSMutableArray array];
    }
    return _historyModels;
}

#pragma mark -
#pragma mark - set监听刷新
-(void)setHotArray:(NSArray *)hotArray
{
    _hotArray  = hotArray;
    [self conventHotDataToModelsArray:hotArray];
    [self.collectionView reloadData];
}
-(void)setHistoryArry:(NSArray *)historyArry
{
    _historyArry = historyArry;
    if (self.historyStyle == ListHistoryStyle) {
        [self conventHistoryDataToModelsArray:historyArry];
    }else{
        self.historyModels =  [self fetchHotModelsWithDataArray:historyArry].mutableCopy;
    }
    [self.collectionView reloadData];
}
-(void)setHistoryStyle:(HistoryStyle)historyStyle{
    _historyStyle = historyStyle;
}
-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
}
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
}
-(void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
}
-(void)setContentFont:(UIFont *)contentFont{
    _contentFont = contentFont;
}
-(void)setContentBGColor:(UIColor *)contentBGColor{
    _contentBGColor = contentBGColor;
}
-(void)setClearTitle:(NSString *)clearTitle{
    _clearTitle = clearTitle;
}
#pragma mark ---- 历史记录 数据源 重组 --
-(void)conventHistoryDataToModelsArray:(NSArray *)datasArray{
    [self.historyModels removeAllObjects];
    for (NSString * historyTitle in datasArray) {
         GTHistorySearchModel * warterTagsModel = [[GTHistorySearchModel alloc]init];
         warterTagsModel.title = historyTitle;
        [self.historyModels addObject:warterTagsModel];
    }
}
#pragma mark ---- 热门数据源 整合 ----
-(void)conventHotDataToModelsArray:(NSArray *)datasArray{
    [self.hotModels removeAllObjects];
    for (NSDictionary * modelInfos in datasArray) {
        NSString * title = modelInfos[@"title"]?modelInfos[@"title"]:@"";
        NSArray * hotModels = modelInfos[@"dataArray"];
        NSArray * tmpModles = [self fetchHotModelsWithDataArray:hotModels];
        [self.hotModels addObject:@{@"title":title,@"dataArray":tmpModles}];
    }
}
-(NSArray *)fetchHotModelsWithDataArray:(NSArray*)dataArray{
    NSMutableArray * hotModels = [NSMutableArray array];
    CGFloat widthItem = 0;
    for (NSString * titleTag in dataArray) {
        GTHistorySearchModel * warterTagsModel = [[GTHistorySearchModel alloc]init];
        warterTagsModel.title = titleTag;
        warterTagsModel.itemWidth = [self calculateRowWidth:titleTag Font:self.contentFont];
        //临时 创建使用 ---
        GTHistorySearchModel * tmpWarterTagsModel = [[GTHistorySearchModel alloc]init];
        tmpWarterTagsModel.title = @"";
        tmpWarterTagsModel.itemWidth = (kViewWidth - widthItem)-0.1;//0.1 是误差计算误差
        widthItem += warterTagsModel.itemWidth;
        //1.判定 宽度 == 总宽度.  不做处理 item == 0;
        if (widthItem == kViewWidth) {
            [hotModels addObject:warterTagsModel];
            widthItem = 0;
            //2.宽度 > 总宽度   item 登录当先Model.itemWidth 创建新的 item
        }else if (widthItem > kViewWidth) {
            //123
            [hotModels addObject:tmpWarterTagsModel];
            [hotModels addObject:warterTagsModel];
            widthItem = warterTagsModel.itemWidth;
            widthItem+=self.minimumInteritemSpacing; // 为下一行的第一个块 添加边距
            //3.宽度 < 总宽度
        }else if (widthItem < kViewWidth) {
            //(1) +边距 大于等于 总宽度
            BOOL plusMarginOnce = widthItem+self.minimumInteritemSpacing>=kViewWidth;
            //(2) + 边距小于 总宽度 && + 边距*2 大于总宽度 此时处理 创建新的item
            BOOL plusMarginTiwce = (widthItem+self.minimumInteritemSpacing<kViewWidth)&&(widthItem+self.minimumInteritemSpacing*2>kViewWidth);
            //(3) + 边距小于 总宽度 && +2*边距 小于或者等于 总宽度
            BOOL plusMarginTiwceMin = (widthItem+self.minimumInteritemSpacing<kViewWidth)&&(widthItem+self.minimumInteritemSpacing*2<=kViewWidth);
            
            if (plusMarginOnce) {
                [hotModels addObject:tmpWarterTagsModel];
                [hotModels addObject:warterTagsModel];
                widthItem = warterTagsModel.itemWidth;
                widthItem+=self.minimumInteritemSpacing;// 为下一行的第一个块 添加边距
            }else if(plusMarginTiwce){
                [hotModels addObject:warterTagsModel];
                widthItem+=self.minimumInteritemSpacing;
                //临时 创建使用 ---
                GTHistorySearchModel * tmpWarterTagsModel2 = [[GTHistorySearchModel alloc]init];
                tmpWarterTagsModel2.title = @"";
                tmpWarterTagsModel2.itemWidth = kViewWidth - widthItem - 0.1;//0.1 是误差计算误差
                [hotModels addObject:tmpWarterTagsModel2];
                widthItem = 0;
            }else if(plusMarginTiwceMin){
                //123
                [hotModels addObject:warterTagsModel];
                widthItem+=self.minimumInteritemSpacing;
            }
        }
    }
     //临时 创建使用 ---
    GTHistorySearchModel * tmpWarterTagsModel2 = [[GTHistorySearchModel alloc]init];
    tmpWarterTagsModel2.title = @"";
    tmpWarterTagsModel2.itemWidth = kViewWidth - widthItem-0.1;//0.1 是误差计算误差
    [hotModels addObject:tmpWarterTagsModel2];
    widthItem = 0;
    return hotModels.copy;
}
@end
