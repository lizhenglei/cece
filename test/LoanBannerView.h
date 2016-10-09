//
//  LoanBannerView.h
//  LoanBannerView
//
//  Created by jia on 16/4/15.
//  Copyright © 2016年 AS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(NSInteger index);
@interface LoanBannerView : UIView

/** 是否自动循环展示 (默认 YES) */
@property (nonatomic, assign) BOOL isAutoLoan;

/** 是否显示信息条 (默认 YES) */
@property (nonatomic, assign) BOOL showInfoView;

/** 信息条的字体 (默认 14.0f) */
@property (nonatomic, assign) float fontSize;

@property (nonatomic, copy) ClickBlock block;

- (instancetype)initWithFrame:(CGRect)frame BannerArray:(NSArray<NSString *> *)imgs infoArray:(NSArray<NSString *> *)infos;
- (instancetype)initWithFrame:(CGRect)frame BannerLinksArray:(NSArray<NSString *> *)imgs infoArray:(NSArray<NSString *> *)infos;

@end
