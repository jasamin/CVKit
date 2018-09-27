//
//  CVNextViewController.m
//  CVKit
//
//  Created by Hanrun on 2018/8/28.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#import "CVNextViewController.h"
#import "CVPopAnimation.h"
#import "Masonry.h"
#import "CVSlider.h"

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SafeAreaTopHeight (KSCREEN_HEIGHT == 812.0 ? 88 : 64) ///适配x
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


@interface CVNextViewController ()<UINavigationControllerDelegate>

@end

@implementation CVNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.delegate = self;
    
    [self addViewWithLeftText:@"过压阀值" rightSting:@"(220~280V)" max:280 min:220 top:SafeAreaTopHeight+20];
    [self addViewWithLeftText:@"欠压阀值" rightSting:@"(145~220V)" max:220 min:145 top:SafeAreaTopHeight+20+110*1];
    [self addViewWithLeftText:@"过流阀值" rightSting:@"(1~63A)" max:63 min:1 top:SafeAreaTopHeight+20+110*2];
    [self addViewWithLeftText:@"漏电流阀值" rightSting:@"(10~90mA)" max:90 min:10 top:SafeAreaTopHeight+20+110*3];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn setBackgroundColor:RGB(236, 98, 57)];
    [btn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.right.bottom.equalTo(self.view).with.offset(-12);
        make.height.mas_equalTo(45);
    }];
    
}

- (void)addViewWithLeftText:(NSString *)leftString rightSting:(NSString *)rightString max:(int)maxValue min:(int)minValue  top:(float)topNum {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 5;
    [self.view addSubview:bottomView];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectZero];
    leftLab.text = leftString;
    leftLab.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:leftLab];
    
    UITextField *textedit = [[UITextField alloc]initWithFrame:CGRectZero];
    textedit.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textedit.layer.borderWidth = 1;
    textedit.layer.cornerRadius = 5;
    textedit.textAlignment = NSTextAlignmentCenter;
    textedit.delegate = self;
    textedit.placeholder = @"未设置";
    [bottomView addSubview:textedit];
    
    UILabel *rightLab = [[UILabel alloc]initWithFrame:CGRectZero];
    rightLab.text = rightString;
    rightLab.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:rightLab];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"slider_submit"] forState:0];
    [leftBtn addTarget:self action:@selector(submitSliderValue:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"slider_add"] forState:0];
    [rightBtn addTarget:self action:@selector(addSliderValue:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightBtn];
    
    CVSlider *progress = [[CVSlider alloc]initWithFrame:CGRectZero];
    progress.maximumValue = maxValue;
    progress.minimumValue = minValue;
    [progress setThumbImage:[UIImage imageNamed:@"dianqiHuakuai"] forState:0];
    [progress addTarget:self action:@selector(sliderDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [bottomView addSubview:progress];
    
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(90);
        make.top.mas_equalTo(topNum);
        make.left.equalTo(self.view).with.offset(12);
        make.right.equalTo(self.view).with.offset(-12);
    }];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bottomView).with.offset(5);
        make.width.mas_equalTo(115);
        make.height.mas_equalTo(40);
    }];
    
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.width.equalTo(leftLab);
        make.right.equalTo(bottomView).with.offset(-5);
    }];
    
    [textedit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(leftLab);
        make.left.equalTo(leftLab.mas_right);
        make.right.equalTo(rightLab.mas_left);
    }];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).with.offset(15);
        make.bottom.equalTo(bottomView).with.offset(-15);
        make.height.width.mas_equalTo(35);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(bottomView).with.offset(-15);
        make.height.width.mas_equalTo(35);
    }];
    
    [progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftBtn);
        make.left.equalTo(leftBtn.mas_right).with.mas_offset(3);
        make.right.equalTo(rightBtn.mas_left).with.mas_offset(-3);
    }];
    
//    if (!self.overVoltageSlider) {
//        self.overVoltageSlider = progress;
//        self.overVoltageTextField = textedit;
//        leftBtn.tag = 10000;
//        rightBtn.tag = 20000;
//    }else if (!self.underVoltageSlider) {
//        self.underVoltageSlider = progress;
//        self.underVoltageTextField = textedit;
//        leftBtn.tag = 10001;
//        rightBtn.tag = 20001;
//    }else if (!self.overCurrentSlider) {
//        self.overCurrentSlider = progress;
//        self.overCurrentTextField = textedit;
//        leftBtn.tag = 10002;
//        rightBtn.tag = 20002;
//    }else if (!self.leakageCurrentSlider) {
//        self.leakageCurrentSlider = progress;
//        self.leakageCurrentTextField = textedit;
//        leftBtn.tag = 10003;
//        rightBtn.tag = 20003;
//        /*
//         [scrView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.edges.equalTo(self.view);
//         make.bottom.mas_equalTo(bottomView.mas_bottom).with.offset(30);
//         }];*/
//
//    }
}


-(id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [[CVPopAnimation alloc]init];
    }
    return nil;
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
