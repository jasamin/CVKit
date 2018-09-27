//
//  DeviceCell.m
//  Intelligence
//
//  Created by fsy on 2017/7/14.
//  Copyright © 2017年 hanrun. All rights reserved.
//

#import "DeviceCell.h"
//#import "DataHeader.h"
#import "UIColor+YYAdd.h"
#import "CVHeader.h"
@implementation DeviceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //self.contentView.backgroundColor = RGB(230, 230, 230);
    
    //self.cellBackView.backgroundColor = RGB(202, 202, 202);
    
    UIColor *btnColot = [UIColor colorWithHexString:@"2578f3"];
    self.showImageBtn.layer.cornerRadius = 12.5;
    self.showImageBtn.layer.borderColor = btnColot.CGColor;
    self.showImageBtn.layer.borderWidth = 0.5;
    [self.showImageBtn setTitleColor:btnColot forState:0];
    
    self.openBtn.hidden = NO;
    self.openBtn.backgroundColor = [UIColor redColor];
    
    if (IS_IPHONE6PLUS) {
        self.electricityImageWidth_layout.constant=38;//33;
        self.rssiLableWidth_layout.constant *=1.2;
        self.showBtnWidth_layout.constant=80;
        self.peopleWidth_layout.constant =72;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)userBtnClick:(UIButton *)sender {
    
    if (self.isSearch == YES) {
        
        if ([self.searchDelegate respondsToSelector:@selector(searchShouUserMesssage:)]) {
            [self.searchDelegate searchShouUserMesssage:self.model];
        }
        
    }else{
        if (self.type == 4) {
            if ([self.cameraDelegate respondsToSelector:@selector(cameraShouUserMesssage:)]) {
                //[self.cameraDelegate cameraShouUserMesssage:self.cameraModel];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(shouUserMesssage:)]) {
               [self.delegate shouUserMesssage:self.model];
            }
        }

    }
}

- (IBAction)openBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(openDianQi:)]) {
        [self.delegate openDianQi:self.model];
    }
}

- (IBAction)nameBtnClick:(UIButton *)sender {
    
    if (self.isSearch == YES) {
        [self.searchDelegate searchJumpToDetailed:self.model];
    }else{
        if (self.type == 4) {
            //[self.cameraDelegate cameraJumpToDetailed:self.cameraModel];
        }else{
            [self.delegate jumpToDetailed:self.model];
            
        }
    }
    
}

- (void)setCellData:(DeviceModel *)model{
    //移除长按手势
    if (self.longPress) {
        [self removeGestureRecognizer:self.longPress];
    }
    self.model = model;
    if (self.model.repeater.length == 0) {
        self.zjqHeight.constant = 0;
        [self.zjqLabel setHidden:YES];
    }else{
        self.zjqHeight.constant = 21;
        [self.zjqLabel setHidden:NO];
    }

    if (self.model.deviceType == 18) {
        self.openHeight.constant = 21;
    }else{
        self.openHeight.constant = 0;
    }

    if (self.model.rssivalue == nil || [self.model.rssivalue isEqualToString:@"0"]) {
        self.rssiLabel.hidden = self.rssiImage.hidden = YES;
    }else{
        self.rssiLabel.hidden = self.rssiImage.hidden = NO;
    }
    [self.openBtn setHidden:YES];
    [self.consoleBtn setHidden:YES];
    
    NSString *deviceTypeName;
    switch (self.model.deviceType) {
        case 1:case 21:case 31:case 55:case 57:
        {
            if (self.type == 1) {
                deviceTypeName = @"有线主机:";
            }else{
                deviceTypeName = @"烟感:";
            }
            
        }
        break;
        case 2:
        case 16:
        case 51:
        case 72:
        case 73:
        {
            deviceTypeName = @"燃气:";
        }break;
        case 22:
        case 23://日海燃气
        {
            deviceTypeName = @"燃气:";
            self.longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressAction:)];
            [self addGestureRecognizer:self.longPress];
        }
        break;
        case 3:
        {
            deviceTypeName = @"摄像机:";
        }
        break;

        case 5:case 52:case 53:case 75:
        {
            deviceTypeName = @"电气:";
            
            if (self.userType == 3 || self.userType == 4) {
                [self.openBtn setHidden:NO];
                
                switch (model.electrState) {
                    case 1:
                    {
                        if (self.model.netState == 1) {
                            [self.openBtn setBackgroundImage:[UIImage imageNamed:@"sblb_qddy.png"] forState:UIControlStateNormal];
                        }else{
                            [self.openBtn setBackgroundImage:[UIImage imageNamed:@"sblb_yqd.png"] forState:UIControlStateNormal];
                        }
                    }
                        break;
                    case 2:
                    {
                        if (self.model.netState == 1) {
                            [self.openBtn setBackgroundImage:[UIImage imageNamed:@"sblb_yqd.png"] forState:UIControlStateNormal];
                        }else{
                            [self.openBtn setBackgroundImage:[UIImage imageNamed:@"sblb_yqd.png"] forState:UIControlStateNormal];
                        }
                        
                    }
                        break;
                        
                    default:
                    {
                        [self.openBtn setHidden:YES];
                    }
                        break;
                }
            }else{
                [self.openBtn setHidden:YES];
            }
        }
        break;
        case 59:{ //NB北秦 无切断电源功能
            deviceTypeName = @"电气:";
            [self.openBtn setHidden:YES];
        }break;
        case 7:{
            deviceTypeName = @"声光:";
        }break;
        case 8:{
            deviceTypeName = @"手报:";
        } break;
        case 9:{
            deviceTypeName = @"主机:";
        }break;
        case 10:
        case 42:
        case 125:
        case 43:
        case 70://恒星水压
        {
            deviceTypeName = @"水压:";
        }break;
        case 11:{
            deviceTypeName = @"红外:";
        }break;
        case 12:{
            deviceTypeName = @"门磁:";
        } break;
        case 13:{
            deviceTypeName = @"环境:";
        }break;
        case 14:{
            deviceTypeName = @"GPRS:";
        }break;
        case 15:{
            deviceTypeName = @"水浸:";
        }break;
        case 18:
        {
            deviceTypeName = @"喷淋阀:";
            switch (self.model.electrState) {
                case 1:
                {
                    self.sprayLabel.text = @"开关:开";
                }
                    break;
                case 2:
                {
                    self.sprayLabel.text = @"开关:关";
                }
                    break;
                default:
                {
                    self.sprayLabel.text = @"开关:关";
                }
                    break;
            }
        }
            break;
        case 19:
        case 124:
        case 69:
        case 46://NB w-y
        {
            deviceTypeName = @"水位:";
        }
            break;
        case 20:
        {
            deviceTypeName = @"无线输入输出模块:";
        }
            break;
        case 25:case 26:
        {
            deviceTypeName = @"温湿度:";
        }
            break;
        case 45:
        {
            deviceTypeName = @"气感:";
        }
            break;
        case 41:case 56:case 58:case 61:
        {
            deviceTypeName = @"烟感:";
            [self.openBtn setHidden:NO];
            if (self.model.netState == 1) {
                [self.openBtn setBackgroundImage:[UIImage imageNamed:@"xiaoyin.png"] forState:UIControlStateNormal];
            }else {
                [self.openBtn setBackgroundImage:[UIImage imageNamed:@"xiaoyin_gray"] forState:UIControlStateNormal];
            }
            
            if (self.model.deviceType == 58 ||self.model.deviceType == 61) {
                self.longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressAction:)];
                [self addGestureRecognizer:self.longPress];
            }
        }
            break;
        case 119:
        {
            deviceTypeName = @"传输装置:";
            if (self.model.netState == 1) {
                [self.openBtn setHidden:NO];
                [self.openBtn setBackgroundImage:[UIImage imageNamed:@"xiaoyin.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 126:
        {
            deviceTypeName = @"有线主机:";
        }
            break;
        case 35: case 34:{
             deviceTypeName = @"电弧:";
            self.consoleBtn.hidden = NO;
            self.nextBtn.hidden = YES;
        }break;
        case 36:{
            deviceTypeName = @"电弧:";
            self.nextBtn.hidden = NO;
        }break;
        default:
        {
            [self.openBtn setHidden:YES];

            deviceTypeName = @"未知设备:";
        }
            break;
            
    }
    
    [self.nameBtn setTitle:[NSString stringWithFormat:@"%@%@",deviceTypeName,self.model.name] forState:UIControlStateNormal];
    
    self.idLabel.text = [NSString stringWithFormat:@"ID:%@",self.model.mac];
    self.rssiLabel.text = [NSString stringWithFormat:@"%@",self.model.rssivalue];
    self.areaLabel.text = [NSString stringWithFormat:@"区域:%@",self.model.areaName];
    self.typeLabel.text = [NSString stringWithFormat:@"类型:%@",self.model.placeType];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@                   ",self.model.address];

    switch (self.type) {
        case 0:
        {
            self.zjqLabel.text = [NSString stringWithFormat:@"主机:%@",self.model.repeater];
            if (self.model.deviceType == 25) {
                [self.nextBtn setHidden:NO];
            }else{
                [self.nextBtn setHidden:YES];
            }
        }
            break;
        case 1:
        {
            self.zjqLabel.text = [NSString stringWithFormat:@"主机:%@",self.model.repeater];

            [self.nextBtn setHidden:NO];
        }
            break;

        case 2:
        {
            self.zjqLabel.text = [NSString stringWithFormat:@"主机:%@",self.model.repeater];

            [self.nextBtn setHidden:NO];
            if(self.model.deviceType == 35 || self.model.deviceType == 34) {
                [self.nextBtn setHidden:YES];
            }
        }
            break;
        case 3:
        {
            self.zjqLabel.text = [NSString stringWithFormat:@"主机:%@",self.model.repeater];

            switch (self.model.deviceType) {
                case 10:case 19:case 42:case 124:case 125:case 13:case 25:case 43:case 69:case 70:case 46:
                {
                    [self.nextBtn setHidden:NO];
                }
                    break;
                default:
                {
                    [self.nextBtn setHidden:YES];
                }
                    break;
            }
        }
            break;
        case 4:
        {
            [self.nextBtn setHidden:NO];
        }
            break;            
        default:
            break;
    }
    /*
    if (self.model.netState == 1 ) {
        self.titleBackView.backgroundColor = RGB(231, 238, 248);
        [self.nameBtn setTitleColor:[UIColor blackColor] forState:0];
    }else if (self.model.netState == 0 ){
        self.titleBackView.backgroundColor = RGB(236, 236, 236);
        [self.nameBtn setTitleColor:[UIColor redColor] forState:0];
        [self.nameBtn setTitle:[NSString stringWithFormat:@"%@%@(已离线)",deviceTypeName,self.model.name] forState:UIControlStateNormal];
    }
    */
    
//    if (self.model.deviceType == 73) {
//        self.titleBackView.backgroundColor = [UIColor cyanColor];
//    }
    
    CGSize size1 = [self.areaLabel sizeThatFits:CGSizeMake(self.areaLabel.frame.size.width, MAXFLOAT)];
    
    if (size1.height > 30) {
        self.areaHeight.constant = 36;
    }else{
        self.areaHeight.constant = 21;
    }
    
    CGSize size2 = [self.addressLabel sizeThatFits:CGSizeMake(self.addressLabel.frame.size.width, MAXFLOAT)];
    
    if (size2.height > 30) {
        self.addressLabelHeight.constant = 36;
    }else{
        self.addressLabelHeight.constant = 21;
    }
    
   
    NSString *str = self.model.lowVoltage == 0 ? @"p0" : self.model.lowVoltage <25 ? @"p1" : self.model.lowVoltage < 50 ? @"p2" : self.model.lowVoltage < 75 ? @"p3" : @"p4";
    self.electricityImage.image = [UIImage imageNamed:str];
    self.electricityImage.hidden = self.model.lowVoltage == 0 ?  YES : NO;
    
    //self.openBtnWidth_layout.constant *=1.2;
    self.electricityImageWidth_layout.constant=32;
    self.rssiImageWidth_layout.constant=30;
    self.rssiLableWidth_layout.constant=35;
    self.showBtnWidth_layout.constant=55;
    self.peopleWidth_layout.constant =60;
    
    if (!IS_IPHONE5) {
        //self.openBtnWidth_layout.constant *=1.2;
        self.electricityImageWidth_layout.constant=33;
        //self.rssiImageWidth_layout.constant=30;
        //self.rssiLableWidth_layout.constant *=1.2;
        self.showBtnWidth_layout.constant=60;
        self.peopleWidth_layout.constant =72;
    }
    
    
    
    //调整下面的按钮位置
    if(self.rssiImage.hidden){
        self.rssiLableWidth_layout.constant = self.rssiImageWidth_layout.constant = 0;
    }
    if (self.electricityImage.hidden) {
        self.electricityImageWidth_layout.constant = 0;
    }
    
   
    
}
/*
- (void)setCameraCellData:(CameraModel *)model{

    [self.rssiLabel setHidden:YES];
    self.openHeight.constant = 0;
    [self.openBtn setHidden:YES];

    self.cameraModel = model;
    
    [self.nameBtn setTitle:[NSString stringWithFormat:@"摄像机:%@",model.cameraName] forState:UIControlStateNormal];
    
    self.idLabel.text = [NSString stringWithFormat:@"ID:%@",model.cameraId];
    
    self.zjqLabel.text = [NSString stringWithFormat:@"关联的烟感:%@",model.mac1];

    self.areaLabel.text = [NSString stringWithFormat:@"区域:%@",model.areaName];
    
    self.typeLabel.text = [NSString stringWithFormat:@"类型:%@",model.placeType];
    
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@                   ",model.cameraAddress];
    
 
    if (model.onLine == 1 ) {
        self.titleBackView.backgroundColor = RGB(231, 238, 248);
    }else if (model.onLine == 0 ){
        self.titleBackView.backgroundColor = RGB(236, 236, 236);
    }
 
    
    if (model.onLine == 1  ) {
        self.titleBackView.backgroundColor = RGB(231, 238, 248);
        [self.nameBtn setTitleColor:[UIColor blackColor] forState:0];
    }else if (self.model.netState == 0 ){
        self.titleBackView.backgroundColor = RGB(236, 236, 236);
        [self.nameBtn setTitleColor:[UIColor redColor] forState:0];
        [self.nameBtn setTitle:[NSString stringWithFormat:@"摄像机:%@(已离线)",model.cameraName] forState:UIControlStateNormal];
    }
    
    
    CGSize size1 = [self.areaLabel sizeThatFits:CGSizeMake(self.areaLabel.frame.size.width, MAXFLOAT)];
    
    if (size1.height > 30) {
        self.areaHeight.constant = 36;
    }else{
        self.areaHeight.constant = 21;
    }
    
    CGSize size2 = [self.addressLabel sizeThatFits:CGSizeMake(self.addressLabel.frame.size.width, MAXFLOAT)];
    
    if (size2.height > 30) {
        self.addressLabelHeight.constant = 36;
    }else{
        self.addressLabelHeight.constant = 21;
    }
 
}*/

- (IBAction)consoleBtnAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(consoleBtnActionDelegate:withModel:)]){
        [self.delegate consoleBtnActionDelegate:sender withModel:self.model];
    }
}

- (void)longpressAction:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按了 当前设备型号 == %ld",(long)self.model.deviceType);
        if ([self.delegate respondsToSelector:@selector(deleteDeviceById:)]) {
            [self.delegate deleteDeviceById:self.model];
        }
    }
}

- (IBAction)showImageBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(showInstallImage:)]) {
        [self.delegate showInstallImage:self.model];
    }
}

@end
