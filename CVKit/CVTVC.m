//
//  CVTVC.m
//  CVKit
//
//  Created by Hanrun on 2018/9/11.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVTVC.h"
#import "DeviceCell.h"
#import "CVHeader.h"

@interface CVTVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) DeviceCell *cell;
@end

@implementation CVTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
    tview.delegate = self;
    tview.dataSource = self;
    [tview registerNib:[UINib nibWithNibName:@"DeviceCell" bundle:nil] forCellReuseIdentifier:@"CVTVCIdentifier"];
    tview.estimatedRowHeight = 186;
    [self.view addSubview:tview];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CVTVCIdentifier"];
    self.cell = cell;
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.type = 1;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
