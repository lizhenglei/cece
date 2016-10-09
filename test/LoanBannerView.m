//
//  LoanBannerView.m
//  LoanBannerView
//
//  Created by jia on 16/4/15.
//  Copyright © 2016年 AS. All rights reserved.
//

#import "LoanBannerView.h"

#import "UIImageView+WebCache.h"

#define Width self.frame.size.width
#define Height self.frame.size.height
#define kInfoVHeight   30.0f
#define kInfoLabelTag   10000
#define kInfoViewTag    10001

@interface LoanBannerView()<UIScrollViewDelegate>
@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, weak)UIPageControl *pageControl;

@property (nonatomic, weak)UIImageView *firstImgView;
@property (nonatomic, weak)UIImageView *secondImgView;
@property (nonatomic, weak)UIImageView *thirdImgView;

@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, strong)NSArray *imgs;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign)BOOL isLink;



@end

@implementation LoanBannerView

- (void)awakeFromNib {
    [self setupScrolleView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrolleView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame BannerArray:(NSArray<NSString *> *)imgs infoArray:(NSArray<NSString *> *)infos {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrolleView];
        [self addBanners:imgs isLink:NO info:infos];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame BannerLinksArray:(NSArray<NSString *> *)imgs infoArray:(NSArray<NSString *> *)infos {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrolleView];
        [self addBanners:imgs isLink:NO info:infos];
    }
    return self;
}

- (void)setupScrolleView {
    [self initAttributes];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView = scrollView;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, Height-50, Width, 20)];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    [self addTimer];
}

- (void)initAttributes {
    self.isAutoLoan = YES;
    self.showInfoView = YES;
    self.fontSize = 14.0f;
}

- (void)addBanners:(NSArray *)imgs isLink:(BOOL)isLink info:(NSArray *)infos {
    self.imgs = imgs;
    self.isLink = isLink;
    if (imgs.count < 2) {
        [self createImageViewWithX:0];
        return;
    }
    for (int i = 0; i<3; i++) {
        UIImageView *imgView = [self createImageViewWithX:Width * i];
        
        switch (i) {
            case 0:
                self.firstImgView = imgView;
                [self set:imgView img:[imgs lastObject] isLink:isLink];
                break;
            case 1:
                self.secondImgView = imgView;
                [self set:imgView img:[imgs firstObject] isLink:isLink];
                break;
            case 2:
                self.thirdImgView = imgView;
                [self set:imgView img:imgs[1] isLink:isLink];
                break;
            default:
                break;  }
    }
    self.scrollView.contentSize = CGSizeMake(Width * 3, Height);
    self.scrollView.contentOffset = CGPointMake(Width, 0);
    self.currentPage = 0;
    self.pageControl.numberOfPages = imgs.count;
    self.pageControl.currentPage = self.currentPage;
}

- (void)set:(UIImageView *)imgView img:(NSString *)img isLink:(BOOL)isLink {
    if (isLink) {
        [imgView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"1"]];
    } else {
        imgView.image = [UIImage imageNamed:img];
    }
}

- (UIImageView *)createImageViewWithX:(CGFloat)originX {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, 0, Width, Height)];
    [self.scrollView addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [imgView addGestureRecognizer:tap];
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, Height - kInfoVHeight, Width, kInfoVHeight)];
    infoView.tag = kInfoViewTag;
    [imgView addSubview:infoView];
    infoView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, Height - kInfoVHeight, Width - 20, kInfoVHeight)];
    infoLabel.tag = kInfoLabelTag;
    [imgView addSubview:infoLabel];
    infoLabel.font = [UIFont systemFontOfSize:self.fontSize];
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.text = @"这就是占位置的信息";
   
    return imgView;
}

- (void)tapAction {
    if (self.block) {
        self.block(self.currentPage);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX >= 2 * Width) {
        self.currentPage = (self.currentPage + 1 >= self.imgs.count) ? 0 : (self.currentPage + 1);
        self.firstImgView.image = self.secondImgView.image;
        self.secondImgView.image = self.thirdImgView.image;
        
        self.scrollView.contentOffset = CGPointMake(Width, 0);
        
        if (self.currentPage+1 >= self.imgs.count) {
            if (self.isLink) {
                [self.thirdImgView sd_setImageWithURL:[NSURL URLWithString:self.imgs[0]]];
            } else {
                self.thirdImgView.image = [UIImage imageNamed:self.imgs[0]];
            }
            
        } else {
            if (self.isLink) {
                [self.thirdImgView sd_setImageWithURL:[NSURL URLWithString:self.imgs[self.currentPage + 1]]];
            } else {
                self.thirdImgView.image = [UIImage imageNamed:self.imgs[self.currentPage + 1]];
            }
        }
    }
    
    if (offsetX <= 0) {
        self.currentPage = (self.currentPage - 1 < 0) ? (self.imgs.count - 1) : (self.currentPage - 1);
        self.thirdImgView.image = self.secondImgView.image;
        self.secondImgView.image = self.firstImgView.image;
        
        self.scrollView.contentOffset = CGPointMake(Width, 0);
        
        if (self.currentPage - 1 < 0) {
            if (self.isLink) {
                [self.firstImgView sd_setImageWithURL:[NSURL URLWithString:self.imgs[self.imgs.count - 1]]];
            } else {
                self.firstImgView.image = [UIImage imageNamed:self.imgs[self.imgs.count - 1]];
            }
        } else {
            if (self.isLink) {
                [self.firstImgView sd_setImageWithURL:[NSURL URLWithString:self.imgs[self.currentPage - 1]]];
            } else {
                self.firstImgView.image = [UIImage imageNamed:self.imgs[self.currentPage - 1]];
            }
        }
    }
    
    self.pageControl.currentPage = self.currentPage;
}

- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)timerAction {
    [self.scrollView setContentOffset:CGPointMake(Width * 2.0, 0) animated:YES];
}


#pragma mark - 属性设置
- (void)setIsAutoLoan:(BOOL)isAutoLoan {
    _isAutoLoan = isAutoLoan;
    if (_isAutoLoan) {
        [self.timer setFireDate:[NSDate distantPast]];
    } else {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
- (void)setShowInfoView:(BOOL)showInfoView {
    _showInfoView = showInfoView;
    UIView *infoView1 = [self.firstImgView viewWithTag:kInfoViewTag];
    UIView *infolabel1 = [self.firstImgView viewWithTag:kInfoLabelTag];
    UIView *infoView2 = [self.secondImgView viewWithTag:kInfoViewTag];
    UIView *infoLabel2 = [self.secondImgView viewWithTag:kInfoLabelTag];
    UIView *infoView3 = [self.thirdImgView viewWithTag:kInfoViewTag];
    UIView *infoLabel3 = [self.thirdImgView viewWithTag:kInfoLabelTag];
    infoView1.hidden = infolabel1.hidden = infoView2.hidden = infoLabel2.hidden = infoView3.hidden = infoLabel3.hidden = !showInfoView;
    
    CGRect rect = self.pageControl.frame;
    if (!showInfoView) { rect.origin.y = Height - rect.size.height-10; }
    else { rect.origin.y = Height - kInfoVHeight - self.pageControl.frame.size.height; }
    self.pageControl.frame = rect;
}
- (void)setFontSize:(float)fontSize {
    _fontSize = fontSize;
    UILabel *infolabel1 = (UILabel *)[self.firstImgView viewWithTag:kInfoLabelTag];
    UILabel *infoLabel2 = (UILabel *)[self.secondImgView viewWithTag:kInfoLabelTag];
    UILabel *infoLabel3 = (UILabel *)[self.thirdImgView viewWithTag:kInfoLabelTag];
    infolabel1.font = infoLabel2.font = infoLabel3.font = [UIFont systemFontOfSize:fontSize];
}
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
