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
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDelegate,iCarouselDataSource>
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return self.pageViewModel.specialCount;
    }else{
        return 0;
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view=[[UIView alloc]init];
    view.backgroundColor=[UIColor yellowColor];
    return view;
}
@end
