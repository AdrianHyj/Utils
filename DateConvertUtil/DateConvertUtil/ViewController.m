//
//  ViewController.m
//  DateConvertUtil
//
//  Created by Jin on 15/12/17.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "ViewController.h"
#import "DateConvertUtil.h"

@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _datas = [NSMutableArray new];
    
    NSTimeInterval timeInterval = 1513598888;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *str = [DateConvertUtil convertToStringWithNSDate:date dateFormatter:nil];
    [_datas addObject:str];
    str = [DateConvertUtil convertToStringWithTimeInterval:timeInterval dateFormatter:nil];
    [_datas addObject:str];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    str = [DateConvertUtil convertToStringWithNSDate:date dateFormatter:dateFormatter];
    [_datas addObject:str];
    str = [DateConvertUtil convertToStringWithTimeInterval:timeInterval dateFormatter:dateFormatter];
    [_datas addObject:str];
    
    str = [NSString stringWithFormat:@"is now before date : %@",[DateConvertUtil isNowTimeBeforeDate:date]?@"yes":@"no"];
    [_datas addObject:str];
    str = [NSString stringWithFormat:@"is now before timeInterval : %@",[DateConvertUtil isNowTimeBeforeTimeInterval:timeInterval]?@"yes":@"no"];
    [_datas addObject:str];
    
    str = [NSString stringWithFormat:@"now time is : %@",[DateConvertUtil getNowDateStringWithDateFormatter:dateFormatter]];
    [_datas addObject:str];
    
    str = [NSString stringWithFormat:@"weekday of date:%@",[DateConvertUtil weekdayStringFromDate:date]];
    [_datas addObject:str];
    
    _tableView.dataSource = self;
    [self.view addSubview: _tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableViewCell = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableViewCell];
    }
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}

@end
