//
//  ZNMainViewController.m
//  Intelligence
//
//  Created by fsy on 2017/7/6.
//  Copyright © 2017年 hanrun. All rights reserved.
//

#import "ZNMainViewController.h"
#import "CVGradeVC.h"
#import "CVGradeView.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#define SWwidth self.view.bounds.size.width
#define SWheight self.view.bounds.size.height
#define SWinWidth [[UIScreen mainScreen] applicationFrame].size.width
#define SafeAreaTopHeight (KSCREEN_HEIGHT == 812.0 ? 88 : 64) ///适配x
#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZNMainViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIScrollView *mainScollView;
//@property (nonatomic,strong) UIView *messageTitleView;
@property (nonatomic,strong) UIImageView *messageImageView;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *messageTempLabel;
@property (nonatomic,strong) UILabel *deviceName;
@property (nonatomic,strong) UIView *msgView;

@property (nonatomic) BOOL isCanBack;
@end

@implementation ZNMainViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.barTintColor = RGB(233, 106, 79);
    self.navigationController.navigationBar.backgroundColor = RGB(233, 106, 79);
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewUI];
    
}

- (void)setViewUI{

    self.view.backgroundColor = RGB(230, 230, 230);
    
    self.navigationItem.title = @"智能云消防";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    
    
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //修改按钮向右偏移10 point
    [settingButton setFrame:CGRectMake(10.0, 0.0, 44.0, 44.0)];
    [settingButton addTarget:self action:@selector(settingButtonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setImage:IMAGE(@"shouye_grzx.png") forState:UIControlStateNormal];
    [settingButton setImage:IMAGE(@"shouye_grzx.png") forState:UIControlStateHighlighted];
    //修改方法
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [view addSubview:settingButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *taskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //修改按钮向右偏移10 point
    [taskBtn setFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [taskBtn addTarget:self action:@selector(taskBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [taskBtn setImage:IMAGE(@"shouye_renwu") forState:UIControlStateNormal];


    //修改方法
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [view1 addSubview:taskBtn];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view1];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.mainScollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SWwidth, SWheight)];
    self.mainScollView.contentSize = CGSizeMake(SWwidth, SWheight - 20 + SWwidth/2 * 0.6);
    self.mainScollView.backgroundColor = RGB(230, 230, 230);
    self.mainScollView.delegate = self;
    self.mainScollView.bounces = NO;
    self.mainScollView.showsVerticalScrollIndicator = NO;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mainScollView];
    
    
    CVGradeView *topView = [[CVGradeView alloc]initWithFrame:CGRectMake(0, -SafeAreaTopHeight,KSCREEN_WIDTH, 320)];
    topView.delegate = self;
    [self.mainScollView addSubview:topView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [topView stopAnimation];
    });
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMarkingSystem)];
    topView.userInteractionEnabled = YES;
    [topView addGestureRecognizer:tap];
    
    float space = 15;
    float viewWidth = SWwidth - 40;
    UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(20, topView.bottom - 40, viewWidth, SWwidth * 0.46)];
    messageView.backgroundColor = [UIColor whiteColor];
    messageView.layer.cornerRadius = 10;
    messageView.layer.shadowOffset =  CGSizeMake(0, 2);
    messageView.layer.shadowOpacity = 0.4;
    messageView.layer.shadowColor =  [UIColor grayColor].CGColor;
    [self.mainScollView addSubview:messageView];
    //messageView.centerY = topView.bottom;
    
   
    UILabel *resultLab = [[UILabel alloc]initWithFrame:CGRectMake(space, 0, viewWidth, 35)];
    resultLab.textColor = RGB(236,91,40);
    resultLab.text = @"您一共135个设备，离线126个设备";
    [messageView addSubview:resultLab];
    
    UIButton *scer = [UIButton buttonWithType:UIButtonTypeCustom];
    [scer setFrame:CGRectMake(113, resultLab.bottom+3, 115, 32)];
    [scer setTitle:@"安全检测" forState:0];
    scer.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:184.0f/255.0f blue:27.0f/255.0f alpha:1.0f];
    [scer.layer setCornerRadius:16];
    [scer.layer setMasksToBounds:YES];
    scer.centerX = (viewWidth)*0.5;
    [messageView addSubview:scer];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0,SWwidth * 0.46*0.5, viewWidth, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [messageView addSubview:lineV];
    
    
//    self.messageTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, viewWidth, CGRectGetHeight(messageView.frame) * 0.6)];
//    self.messageTitleView.backgroundColor = RGB(222, 127, 57);
//    [messageView addSubview:self.messageTitleView];
    
    
    self.messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(space, lineV.bottom + 5, 35, 35)];
    self.messageImageView.image = IMAGE(@"shouye_baojing2.png");
    self.messageImageView.contentMode = UIViewContentModeScaleAspectFill;
    [messageView addSubview:self.messageImageView];
    
    
    self.msgView = [self messageViewWithTitle:@"" fram:CGRectMake(CGRectGetMaxX(self.messageImageView.frame) + space, lineV.bottom +5, viewWidth - self.messageImageView.right - 20 ,45*0.5)];
    [messageView addSubview:self.msgView];
    
    self.deviceName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.messageImageView.frame) + space,self.msgView.bottom, viewWidth - self.messageImageView.right - 20, 45*0.5)];
    self.deviceName.numberOfLines = 0;
    self.deviceName.text = @"";
    self.deviceName.textColor = [UIColor orangeColor];
    self.deviceName.font = [UIFont systemFontOfSize:15];
    self.deviceName.text = [NSString stringWithFormat:@"报警设备："];
    self.deviceName.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [messageView addSubview:self.deviceName];
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0,self.deviceName.bottom-15, CGRectGetWidth(messageView.frame), CGRectGetHeight(messageView.frame)*0.4);
    [messageBtn setTitle:@"查看报警历史记录>>" forState:UIControlStateNormal];
    messageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [messageBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setTitleColor:RGB(0,64,225) forState:UIControlStateNormal];
    messageBtn.backgroundColor = [UIColor clearColor];
    [messageView addSubview:messageBtn];
    
    
    
    //管理设备
    [self addTitle:@"管理设备" rect:CGRectMake(messageView.left, messageView.bottom + 25, 4, 18)];
    
    //LoginResult *loginResult = [UDManager getLoginInfo];
    
    NSArray *imageArr1;
    NSArray *imageArr2;
    NSArray *firstColors;
    NSArray *otherColors;
    //loginResult.userType = 3;
//    if (loginResult.userType == 1) {
//        imageArr1 = @[@"重点单位",@"视频监控"];
//        imageArr2 = @[@"shebei_zddw.png",@"shebei_sxt.png"];
//        firstColors = @[@"7973ed",@"0dcdbd"];
//        otherColors = @[@"455bf2",@"2c95de"];
//    }else if (loginResult.userType == 3 || loginResult.userType == 4) {
        imageArr1 = @[@"",@"重点单位",@"传输装置",@"电气防火",@"消防物联",@"视频监控"];
        imageArr2 = @[@"shebei_tj.png",
                      @"shebei_zddw.png",
                      @"shebei_cszz.png",
                      @"shebei_dq.png",
                      @"shebei_xfwl.png",
                      @"shebei_sxt.png",
                    ];
        firstColors = @[@"7973ed",@"7973ed",@"485cf2",@"c4ba1a",@"17c651",@"0dcdbd"];
        otherColors = @[@"7373ed",@"455bf2",@"2c95de",@"13bf54",@"0fc9bf",@"2c95de"];
        
//    }else{
//        imageArr1 = @[@"重点单位",@"传输装置",@"电气防火",@"消防物联",@"视频监控"];
//        imageArr2 = @[@"shebei_zddw.png",
//                      @"shebei_cszz.png",
//                      @"shebei_dq.png",
//                      @"shebei_xfwl.png",
//                      @"shebei_sxt.png",
//                      ];
//        firstColors = @[@"7973ed",@"485cf2",@"c4ba1a",@"17c651",@"0dcdbd"];
//        otherColors = @[@"455bf2",@"2c95de",@"13bf54",@"0fc9bf",@"2c95de"];
//    }
    
    float buttonSW = (messageView.width-20)/3.0;
    float buttonSH = (messageView.width-20)/3.0/1.5;
    float bottom = 0;
    NSInteger rows;
    NSInteger num = [imageArr1 count];
    if (num % 3 > 0) {
        rows = num / 3 + 1;
    }else{
        rows = num / 3;
    }
    for (NSInteger i = 0; i<num; i++) {
        
        NSInteger j = i / 3;
        NSInteger k = i % 3;
        NSInteger t = i-1;// (loginResult.userType == 3 || loginResult.userType == 4) ? i-1 : i;
        [self tapView:imageArr1[i] imageNameStr:imageArr2[i] firstColor:firstColors[i] otherColor:otherColors[i] rect:CGRectMake(messageView.left + (buttonSW+10)*k, messageView.bottom + 53 + (buttonSH+10)*j,buttonSW ,buttonSH) tagNum:t];
        bottom = messageView.bottom + 50 + (buttonSH+10)*(j+1)+10;
    }
    
    //维保系统
    if ( 1) {
        [self addTitle:@"维保系统" rect:CGRectMake(messageView.left, bottom , 4, 18)];
        [self tapView:@"查看巡检>>" imageNameStr:@"weibao.png" firstColor:@"a3a1fb" otherColor:@"aee5ff" rect:CGRectMake(messageView.left, bottom + 28, messageView.width, 70) tagNum:5];
        bottom = bottom + 135;
    }
    self.mainScollView.contentSize = CGSizeMake(SWwidth, bottom);
    
    
//    if (loginResult.userType == 1) {
//        imageArr1 = @[@"重点单位",@"视频监控"];
//        imageArr2 = @[@"shouye_anniu_sxcs_android",@"shouye_anniu_spjk_android"];
//    }else if (loginResult.userType == 3 || loginResult.userType == 4) {
//        imageArr1 = @[@"重点单位",@"传输装置",@"电气防火",@"消防物联",@"视频监控",@"维保系统",@"添加设备",@"主机管理"];
//        imageArr2 = @[@"shouye_anniu_sxcs_android",
//                      @"shouye_anniu_zddw_android",
//                      @"shouye_anniu_dqfh_android",
//                      @"shouye_anniu_xfwl_android",
//                      @"shouye_anniu_spjk_android",
//                      @"shouye_anniu_wbxt_android",
//                      @"shouye_anniu_tjsb_android",
//                      @"shouye_anniu_zjgl"];
//    }else{
//        imageArr1 = @[@"重点单位",@"传输装置",@"电气防火",@"消防物联",@"视频监控",@"维保系统"];
//        imageArr2 = @[@"shouye_anniu_sxcs_android",
//                      @"shouye_anniu_zddw_android",
//                      @"shouye_anniu_dqfh_android",
//                      @"shouye_anniu_xfwl_android",
//                      @"shouye_anniu_spjk_android",
//                      @"shouye_anniu_wbxt_android"];
//    }
//
//    float buttonSW = (SWwidth - 1)/2;
//    float buttonSH = buttonSW * 0.6;
    
//    NSInteger rows;
//    NSInteger num = [imageArr1 count];
    
//    if (num % 2 > 0) {
//        rows = num / 2 + 1;
//    }else{
//        rows = num / 2;
//    }
    
//    UIView *buttonBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(messageView.frame) + 10, SWwidth, buttonSH * rows + 2)];
//    buttonBackView.backgroundColor = RGB(221, 221, 221);
//    [self.mainScollView addSubview:buttonBackView];
//    self.mainScollView.contentSize = CGSizeMake(KSCREEN_WIDTH, buttonBackView.bottom);
//    for (NSInteger i = 0; i < [imageArr1 count]; i ++) {
//
//        NSInteger j = i / 2;
//        NSInteger k = i % 2;
//
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitleColor:RGB(35, 35, 35) forState:0];
//        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//        [button setBackgroundColor:[UIColor whiteColor]];
//        [button setFrame:CGRectMake((buttonSW + 1)* k , (buttonSH + 1) * j, buttonSW, buttonSH)];
//        [button setTitle:[NSString stringWithFormat:@"%@",imageArr1[i]] forState:0];
//        [button setImage:IMAGE(imageArr2[i]) forState:UIControlStateNormal];
//        //[button setImage:IMAGE(imageArr2[i]) forState:UIControlStateHighlighted];
//        button.tag = i;
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//        [button.layer setBorderWidth:0.1];
//        [buttonBackView addSubview:button];
//
//    }
    
}

- (void)tapView:(NSString *)str imageNameStr:(NSString *)imageName firstColor:(NSString *)fColor otherColor:(NSString *)oColor rect:(CGRect)rect tagNum:(NSInteger)tag{
    
    
    UIView *tapView = [[UIView alloc] initWithFrame:rect];
    tapView.layer.cornerRadius = 5;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width/3.0, rect.size.width/3.0/1.2)];
    imageV.image = [UIImage imageNamed:imageName];
    imageV.center = CGPointMake(tapView.width*0.5, tapView.height*0.5);
    
    if (str.length > 0) {
        
        UILabel *title = [[UILabel alloc]init];
        title.text = str;
        
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:fColor].CGColor,(__bridge id)[UIColor colorWithHexString:oColor].CGColor];
        
        
        if ([imageName isEqualToString:@"weibao.png"]) {
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(0.8, 0.6);
            imageV.frame = CGRectMake(30, 0, 65, 65);
            
            title.textColor = RGB(72,92,242);
            title.frame = CGRectMake(0, imageV.bottom +3, 120, 30);
            [title sizeToFit];
            title.right = tapView.width - 20;
            title.centerY = tapView.height*0.5;
            title.textAlignment = NSTextAlignmentLeft;
        }else {
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(1, 1);
            imageV.centerY = tapView.height*0.35;
            title.textColor = [UIColor whiteColor];
            title.frame = CGRectMake(0, imageV.bottom +3, tapView.width, 30);
            title.textAlignment = NSTextAlignmentCenter;
        }
        
        gradientLayer.locations = @[@0,@1];
        [tapView.layer addSublayer:gradientLayer];
        
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:tapView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = tapView.bounds;
        maskLayer.path = path.CGPath;
        tapView.layer.mask = maskLayer;
        
        
        [tapView addSubview:title];
        
        
        
        
    }else {
        tapView.backgroundColor = [UIColor colorWithHexString:fColor];
        tag = 6;
    }
    [tapView addSubview:imageV];
    
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:tag];
    [btn setTitleColor:[UIColor clearColor] forState:0];
    [btn setTitle:str forState:0];
    [tapView addSubview:btn];
    
    [self.mainScollView addSubview:tapView];
}


- (void)addTitle:(NSString *)title rect:(CGRect)rect {
    UIView *colorView = [[UIView alloc]initWithFrame:rect];
    colorView.backgroundColor = RGB(92,121,226);
    [self.mainScollView addSubview:colorView];
    
    UILabel *manageDeviceLab = [[UILabel alloc]initWithFrame:CGRectMake(colorView.right+10, colorView.top, 100, 18)];
    manageDeviceLab.text = title;
    [self.mainScollView addSubview:manageDeviceLab];
}

- (UIView *)messageViewWithTitle:(NSString *)message fram:(CGRect)fram {
    // 背景视图
    UIView *view = [[UIView alloc] initWithFrame:fram];
    [self.view addSubview:view];
    view.clipsToBounds = YES;
    // 手势响应
    //UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    //view.userInteractionEnabled = YES;
    //[view addGestureRecognizer:tapRecognizer];
    // 标签视图1
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, view.frame.size.width, view.frame.size.height)];
    [view addSubview:label];
    label.textColor = [UIColor redColor];
    label.text = message;
    self.messageLabel = label;
    // 标签视图2
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width+30, 0.0, view.frame.size.width, view.frame.size.height)];
    [view addSubview:label2];
    label2.textColor = [UIColor redColor];
    label2.text = message;
    self.messageTempLabel = label2;
    
    [self.messageLabel sizeToFit];
    [self.messageTempLabel sizeToFit];
    
    // 动画
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatCount:999999];
    
    CGRect frame = label.frame;
    frame.origin.x = -frame.size.width;
    label.frame = frame;
    
    CGRect frame2 = label2.frame;
    frame2.origin.x = 0.0;
    label2.frame = frame2;
    
    [UIView commitAnimations];
    return view;
}



- (void)buttonClick:(UIButton *)sender{
    
  
}



//- (void)showLastMessageData:(MessageModel *)model{
//    NSString *message;
//    if (model.ifDealAlarm == 1) {
//        //self.messageLabel.text = self.messageTempLabel.text = [NSString stringWithFormat:@"%@[已处理]   ",self.messageLabel.text = model.address];
//        message = [NSString stringWithFormat:@"%@[已处理]         ",self.messageLabel.text = model.address];
//        //self.messageTitleView.backgroundColor = RGB(222, 127, 57);
//        self.messageLabel.textColor = self.messageTempLabel.textColor = [UIColor blackColor];//RGB(236,91,40);
//    }else{
//        //self.messageTitleView.backgroundColor = //RGB(205, 50, 31);
//        self.messageLabel.textColor = self.messageTempLabel.textColor = [UIColor redColor];
//        //self.messageLabel.text = self.messageTempLabel.text = [model.address stringByAppendingString:@"   "];//[model.address stringByAppendingString:model.address];
//        message = [model.address stringByAppendingString:@"         "];
//        self.messageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"shouye_baojing2.png"]];
//        
//        NSMutableArray *mArray = [[NSMutableArray alloc] init];
//        for (int i = 1; i < 3; i++) {
//            NSString *imageName = [NSString stringWithFormat:@"shouye_baojing%d.png",i];
//            
//            [mArray addObject:[UIImage imageNamed:imageName]];
//        }
//        
//        self.messageImageView.animationImages = mArray;
//        
//        self.messageImageView.animationRepeatCount = 1000;
//        
//        self.messageImageView.animationDuration = 0.8;
//        
//        [self.messageImageView startAnimating];
//        
//    }
//    
//    if (self.msgView) {
//        CGRect frame = self.msgView.frame;
//        UIView *rMSGView = [self messageViewWithTitle:message fram:frame];
//        [self.msgView.superview addSubview:rMSGView];
//        [self.msgView removeFromSuperview];
//        self.msgView = rMSGView;
//        
//    }
//   
//    
//    NSString *deviceName = model.name;
//    deviceName = deviceName.length<1 ? @"" : deviceName;
//    self.deviceName.text = [NSString stringWithFormat:@"设备:%@",deviceName];
//    
//    
//}


#pragma mark - delegates
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"y = %g",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > -SafeAreaTopHeight) {
        self.title = @"";
    }else{
        self.title = @"智能云消防";
    }
}

@end
