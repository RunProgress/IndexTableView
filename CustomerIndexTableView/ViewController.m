//
//  ViewController.m
//  CustomerIndexTableView
//
//  Created by zhang on 16/4/29.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ViewController.h"
#import "MJNIndexView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MJNIndexViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)MJNIndexView *indexView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createDataSource];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.indexView];
    [self createIndexAttribute];
}


#pragma mark --- view create and manager
// tableView

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    
    return _tableView;
}

- (MJNIndexView *)indexView
{
    if (!_indexView) {
        _indexView = [[MJNIndexView alloc] initWithFrame:self.tableView.frame];
        _indexView.dataSource = self;
        
    }
    
    return _indexView;
}

- (void)createIndexAttribute
{
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = YES;
    self.indexView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    self.indexView.selectedItemFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
    self.indexView.backgroundColor = [UIColor clearColor];
    self.indexView.curtainColor = nil;
    self.indexView.curtainFade = 0.0;
    self.indexView.curtainStays = NO;
    self.indexView.curtainMoves = YES;
    self.indexView.curtainMargins = NO;
    self.indexView.ergonomicHeight = NO;
    self.indexView.upperMargin = 22.0;
    self.indexView.lowerMargin = 22.0;
    self.indexView.rightMargin = 10.0;
    self.indexView.itemsAligment = NSTextAlignmentCenter;
    self.indexView.maxItemDeflection = 70.0; // 突出的高度
    self.indexView.rangeOfDeflection = 5;// 突出字母的个数
    self.indexView.fontColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    self.indexView.selectedItemFontColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    self.indexView.darkening = NO;
    self.indexView.fading = YES;

}
#pragma mark --- data manage

- (void)createDataSource
{
    self.dataSource = [NSMutableArray new];
    
    char *title = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    for (NSInteger i = 0; i < 26; i ++) {
        
        NSMutableArray *section = [NSMutableArray new];
        for (NSInteger i = 0; i<10; i++) {
            [section addObject:[NSString stringWithFormat:@"%s--%ld",title,i]];
        }
        [self.dataSource addObject:section];
        title ++;
        
    }
    
}

#pragma mark --- tableView dataSource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.dataSource[section];
    return sectionArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSArray *sectionArray = self.dataSource[indexPath.section];
    
    cell.textLabel.text = sectionArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0;
}

#pragma mark --- MJNIndexView delegate 
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
