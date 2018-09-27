//
//  GasVC.m
//  Intelligence
//
//  Created by Hanrun on 2018/9/3.
//  Copyright © 2018年 hanrun. All rights reserved.
//

#import "GasVC.h"
#import "DialView.h"
#import "UIView+YYAdd.h"
#import "UIColor+YYAdd.h"

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GasVC ()
{
    DialView *_dial;
    DialView *_probe;
    UILabel *_timeDetaillab;
}
@end

@implementation GasVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0264e1"]];
    //self.deviceModel.mac = @"79C00009";
    [self createUIView];
    [self getGasHistoryInfo];
}

- (void)getGasHistoryInfo {
    /*
    GasServerModel *sever = [[GasServerModel alloc]init];
    [sever gasDataWithPage:0 mac:self.deviceModel.mac result:^(NSDictionary *dic, bool suc) {
        if (suc) {
            NSString *unit = dic[@"history"][0][@"proofGasUnit"];
            NSString *Mmol = dic[@"history"][0][@"proofGasMmol"];
            NSString *type = dic[@"history"][0][@"proofGasType"];
            [_dial setDataTitle:[NSString stringWithFormat:@"%@ %@",Mmol,unit] typeLab:type];
            [_probe setDataTitle:[NSString stringWithFormat:@"%@°C",dic[@"history"][0][@"proofGasTemp"]] typeLab:@""];
            _timeDetaillab.text = [NSString stringWithFormat:@"%@",dic[@"history"][0][@"proofGasTime"]];
        }
    }];*/
}

- (void)createUIView{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, KSCREEN_WIDTH, 30)];
    title.text =  @"设备";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(10, 30, 60, 30)];
    [backBtn setImage:[UIImage imageNamed:@"sblb_back"] forState:0];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, title.bottom+5, KSCREEN_WIDTH*0.75, 30)];
    timeView.centerX = KSCREEN_WIDTH*.5;
    timeView.bottom = self.view.bottom -8;
    [self.view addSubview:timeView];
    
    UILabel *timelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH*0.25, 30)];
    timelab.text = @"上报时间:";
    timelab.textColor = [UIColor greenColor];
    timelab.textAlignment = NSTextAlignmentRight;
    timelab.font = [UIFont systemFontOfSize:16];
    [timeView addSubview:timelab];
    
    UILabel *timeDetaillab = [[UILabel alloc]initWithFrame:CGRectMake(0, timelab.top, KSCREEN_WIDTH*0.5, 30)];
    timeDetaillab.text = @"////-//-// //://://";
    timeDetaillab.textColor = [UIColor whiteColor];
    timeDetaillab.textAlignment = NSTextAlignmentLeft;
    timeDetaillab.left = timelab.right;
    [timeView addSubview:timeDetaillab];
    _timeDetaillab = timeDetaillab;
    
    
    DialView *dial = [[DialView alloc]initWithFrame:CGRectMake(50, 80, KSCREEN_WIDTH - 100, KSCREEN_WIDTH - 100) dataType:GasView];
    [self.view addSubview:dial];
    _dial = dial;
    
    UIButton *histry = [UIButton buttonWithType:UIButtonTypeCustom];
    [histry setTintColor:[UIColor whiteColor]];
    [histry setFrame:CGRectMake(0, dial.bottom+10, 120, 30)];
    [histry setTitle:@"历史数据" forState:0];
    [histry setImage:[UIImage imageNamed:@"rightNextBtn"] forState:0];
    [histry setTitleEdgeInsets:UIEdgeInsetsMake(0, -histry.imageView.bounds.size.width + 2, 0, histry.imageView.bounds.size.width + 10)];
    [histry setImageEdgeInsets:UIEdgeInsetsMake(0, histry.titleLabel.bounds.size.width + 10, 0, -histry.titleLabel.bounds.size.width + 2)];
    [histry setCenterX:KSCREEN_WIDTH*.5];
    [histry addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:histry];
    
    DialView *probe = [[DialView alloc]initWithFrame:CGRectMake(85, histry.bottom + 10, KSCREEN_WIDTH - 170, KSCREEN_WIDTH - 170) dataType:Probe];
    [probe setDataTitle:@"--°C" typeLab:@""];
    [self.view addSubview:probe];
    _probe = probe;
}

/*
- (void)historyAction:(UIButton *)sender {
    WaterViewController *vc = [[WaterViewController alloc]init];
    vc.mac = self.deviceModel.mac;
    vc.deviceType = self.deviceModel.deviceType;
    [self.navigationController pushViewController:vc animated:YES];
}
*/

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
