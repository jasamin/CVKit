//
//  CVShowPeopleAlertVC.m
//  CVKit
//
//  Created by Hanrun on 2018/9/11.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVShowPeopleAlertVC.h"
#import <UIView+YYAdd.h>

@interface CVShowPeopleAlertVC ()
{
    UIView *bgView;
}
@end

@implementation CVShowPeopleAlertVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width - 80, 35)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    bgView = view;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, -10, view.width, view.height)];
    title.textColor = [UIColor whiteColor];
    title.text = @"    设备负责人信息";
    title.font = [UIFont systemFontOfSize:18];
    title.backgroundColor = [UIColor colorWithRed:193/255.0 green:58/255.0 blue:35/255.0 alpha:1];
    [bgView addSubview:title];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:title.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;
    layer.frame = title.bounds;
    title.layer.mask = layer;
    bgView.height -= 10;
    [self addFunctionaryInfoName:@"李丽丽" phoneNum:@"13800138000"];
    [self addFunctionaryInfoName:@"你腻腻" phoneNum:@"10086100101"];
}

- (void)addFunctionaryInfoName:(NSString *)nameStr phoneNum:(NSString *)phoneStr {
    UIImageView *p = [[UIImageView alloc]initWithFrame:CGRectMake(20, bgView.height+20, 25, 25)];
    p.backgroundColor = [UIColor redColor];
    [bgView addSubview:p];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(p.right+5, 0, bgView.width - p.right-5, 30)];
    nameLab.centerY = p.centerY;
    nameLab.text = [NSString stringWithFormat:@"负责人:%@",nameStr.length > 0 ? nameStr : @"未填写"];
    [bgView addSubview:nameLab];
    
    UIImageView *ph = [[UIImageView alloc]initWithFrame:CGRectMake(20, p.bottom+5, 25, 25)];
    ph.backgroundColor = [UIColor redColor];
    [bgView addSubview:ph];
    
    UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(ph.right+5, 0, bgView.width - ph.right-5, 30)];
    phoneLab.centerY = ph.centerY;
    phoneLab.text =[NSString stringWithFormat:@"电话:%@",phoneStr.length > 0 ? phoneStr : @"未填写"];
    [bgView addSubview:phoneLab];
    
    
    bgView.height = phoneLab.bottom+25;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, bgView.height, bgView.width, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //btn.backgroundColor = [UIColor blueColor];
    [btn setFrame:CGRectMake(0, p.top-19, bgView.width, bgView.height-p.top+19)];
    [btn setTitle:phoneStr forState:0];
    [btn setTitleColor:[UIColor clearColor] forState:0];
    [btn addTarget:self action:@selector(callIt:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
}

- (void)callIt:(UIButton *)sender {/*
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",sender.titleLabel.text];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];*/
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    __block CVShowPeopleAlertVC *weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf->bgView.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.4);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dissMiss];
}

- (void)dissMiss {
     __block CVShowPeopleAlertVC *weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
         weakSelf->bgView.center = CGPointMake(self.view.frame.size.width*1.5, self.view.frame.size.height*1.5);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
    
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
