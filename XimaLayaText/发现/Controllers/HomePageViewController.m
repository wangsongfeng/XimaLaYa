//
//  HomePageViewController.m
//  XimaLayaText
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 yangchao. All rights reserved.
//

#import "HomePageViewController.h"
#import "FocusImgScrollView.h"
#import "HomePageViewModel.h"
#import "FindPutViewCell.h"
#import "SpecialTableViewCell.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDelegate,iCarouselDataSource,TitleViewDelegate>
{
    UIPageControl *_pageControl;
    // 定义热门类或三个图片按钮的FindPutCell高
    CGFloat _hotCellHeight;
}
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)HomePageViewModel * pageViewModel;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"正在努力为您加载"];
    [self.pageViewModel getDataCompletionHandle:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [self.tableView reloadData];
        
        NSLog(@"%ld",(long)self.pageViewModel.FocusImgNumber);
    }];
}

-(HomePageViewModel*)pageViewModel{
    if (_pageViewModel==nil) {
        _pageViewModel=[HomePageViewModel new];
    }
    return _pageViewModel;
}
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.bounces=NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [_tableView registerClass:[SpecialTableViewCell class] forCellReuseIdentifier:@"SpecialCell"];
        [_tableView registerClass:[FindPutViewCell class] forCellReuseIdentifier:@"FindPutCell"];
        FocusImgScrollView * focusScrollView=[[FocusImgScrollView alloc]initWithFocusImgNumber:self.pageViewModel.FocusImgNumber];
        focusScrollView.iC.delegate=self;
        focusScrollView.iC.dataSource=self;
        _pageControl=focusScrollView.pageControl;
        _tableView.tableHeaderView=focusScrollView;
    }
    return _tableView;
}

#pragma mark 轮播图的代理
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
   return  self.pageViewModel.FocusImgNumber;
}
-(UIView*)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIImageView * imageView=nil;
    if (!view) {
        view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW/630*310)];
        imageView=[UIImageView new];
        [view addSubview:imageView];
        imageView.tag=100;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        view.clipsToBounds=YES;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    
    imageView=(UIImageView*)[view viewWithTag:100];
    [imageView sd_setImageWithURL:[self.pageViewModel focusImgURLForIndex:index] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_2"]];
    return view;
}

// @option
/** 允许循环滚动 */
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}
/**  监控滚到第几个 */
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    _pageControl.currentPage = carousel.currentItemIndex;
}
#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.pageViewModel.section;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return self.pageViewModel.specialCount;
    }else{
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        SpecialTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"SpecialCell"];
        [cell.coverBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[self.pageViewModel coverURLForSection:indexPath.section index:indexPath.row]]] forState:UIControlStateNormal];
        cell.titleLb.text=[self.pageViewModel titleForSection:indexPath.section index:indexPath.row];
        cell.subTitleLb.text=[self.pageViewModel trackTitleForSection:indexPath.section index:indexPath.row];
        cell.footNoteLb.text=[self.pageViewModel footNoteForRow:indexPath.row];
        return cell;
    }else{
        FindPutViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"FindPutCell"];
        _hotCellHeight=cell.cellHeight;
        
        //第一个按钮
        cell.clickBtn0.titleLable.text=[self.pageViewModel titleForSection:indexPath.section index:0];
        [cell.clickBtn0.contentImageView sd_setImageWithURL:[self.pageViewModel coverURLForSection:indexPath.section index:0] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_3"]];
        cell.clickBtn0.tag=indexPath.section*10+0;
        cell.detailLb0.text=[self.pageViewModel trackTitleForSection:indexPath.section index:0];
        
        cell.clickBtn1.titleLable.text=[self.pageViewModel titleForSection:indexPath.section index:1];
        [cell.clickBtn1.contentImageView sd_setImageWithURL:[self.pageViewModel coverURLForSection:indexPath.section index:1] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_3"]];
        cell.clickBtn1.tag=indexPath.section*10+1;
        cell.detailLb1.text=[self.pageViewModel trackTitleForSection:indexPath.section index:1];
        
        cell.clickBtn2.titleLable.text=[self.pageViewModel titleForSection:indexPath.section index:2];
        [cell.clickBtn2.contentImageView sd_setImageWithURL:[self.pageViewModel coverURLForSection:indexPath.section index:2] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_3"]];
        cell.clickBtn2.tag=indexPath.section*10+2;
        cell.detailLb2.text=[self.pageViewModel trackTitleForSection:indexPath.section index:2];
        

        
        return cell;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return 70;
    }else{
        return _hotCellHeight;
    }
}

#pragma mark 表头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
#pragma mark 表尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TitleView *moreView = [[TitleView alloc] initWithTitle:[self.pageViewModel mainTitleForSection:section] hasMore:[self.pageViewModel hasMoreForSection:section]];
    // 定义TitleView的tag  可以通过tag知section
    moreView.tag = section;
    moreView.delegate = self;
    return moreView;
}
@end
