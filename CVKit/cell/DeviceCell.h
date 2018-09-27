//
//  DeviceCell.h
//  Intelligence
//
//  Created by fsy on 2017/7/14.
//  Copyright © 2017年 hanrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceModel.h"



@protocol DeviceCellDelegate <NSObject>

- (void)jumpToDetailed:(DeviceModel *)model;
- (void)shouUserMesssage:(DeviceModel *)model;
- (void)openDianQi:(DeviceModel *)model;
- (void)consoleBtnActionDelegate:(UIButton *)sender withModel:(DeviceModel *)model;
- (void)deleteDeviceById:(DeviceModel *)model;
- (void)showInstallImage:(DeviceModel *)model;

@end

@protocol CameraDeviceCellDelegate <NSObject>
/*
- (void)cameraJumpToDetailed:(CameraModel *)model;
- (void)cameraShouUserMesssage:(CameraModel *)model;
*/
@end

@protocol SearchDeviceCellDelegate <NSObject>

- (void)searchJumpToDetailed:(DeviceModel *)model;
- (void)searchShouUserMesssage:(DeviceModel *)model;

@end

@interface DeviceCell : UITableViewCell

@property (strong, nonatomic) id<DeviceCellDelegate> delegate;

@property (strong, nonatomic) id<CameraDeviceCellDelegate> cameraDelegate;

@property (strong, nonatomic) id<SearchDeviceCellDelegate> searchDelegate;

@property (nonatomic,assign) BOOL isSearch;

@property (strong, nonatomic) DeviceModel *model;

//@property (strong, nonatomic) CameraModel *cameraModel;


@property (nonatomic,assign) NSInteger type;
@property (nonatomic) int userType;


@property (weak, nonatomic) IBOutlet UIView *cellBackView;

@property (weak, nonatomic) IBOutlet UIView *titleBackView;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIView *detailBackView;

@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (weak, nonatomic) IBOutlet UILabel *sprayLabel;

@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UILabel *zjqLabel;

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rssiImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zjqHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *openHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressLabelHeight;
@property (weak, nonatomic) IBOutlet UIButton *consoleBtn;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;///长按删除烟感 23、22

@property (weak, nonatomic) IBOutlet UIButton *showImageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *electricityImage;


//下方信息、按钮的宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *openBtnWidth_layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showBtnWidth_layout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *electricityImageWidth_layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rssiLableWidth_layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rssiImageWidth_layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *peopleWidth_layout;




- (void)setCellData:(DeviceModel *)model;

//- (void)setCameraCellData:(CameraModel *)model;



@end
