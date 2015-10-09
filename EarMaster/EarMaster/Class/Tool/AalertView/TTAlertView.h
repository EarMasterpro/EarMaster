//
//  TTAlertView.h
//  Rent_OC
//
//  Created by TTc on 14-10-14.
//  Copyright (c) 2014年 com.kuaiyoujia.rent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTAlertView : UIView


- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- (void)show;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;


@end
