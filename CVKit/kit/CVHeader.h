//
//  CVHeader.h
//  CVKit
//
//  Created by Hanrun on 2018/8/1.
//  Copyright © 2018年 Hanrun. All rights reserved.
//

#ifndef CVHeader_h
#define CVHeader_h

#import "UIView+YYAdd.h"

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4s (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE6PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONEX (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0f)

#endif /* CVHeader_h */
