//
//  LZBProgressView.m
//  LZBProject
//
//  Created by hicity on 2019/11/5.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBProgressView.h"

@interface LZBProgressView (){
    UIView *_progressView;
    float _progress;
    UILabel *_progressTitleLabel;
    UILabel *_progressCountLabel;
}

@end

@implementation LZBProgressView

//- (id)init{
//    self = [super init];
//    if (self) {
//        ;
//    }
//    return self;
//}
-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame progressViewStyle:LZBProgressViewStyleDefault];
}

- (instancetype)initWithFrame:(CGRect)frame progressViewStyle:(LZBProgressViewStyle)style
{
    if (self=[super initWithFrame:frame]) {
        _progressView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        _progress=0;
        self.progressViewStyle=style;
        [self addSubview:_progressView];
    }
    return self;
}


- (void)progressViewStyle:(LZBProgressViewStyle)style{
        
    CGFloat height = self.bounds.size.height;
    
    _progressTitleLabel = [[UILabel alloc] init];
    _progressTitleLabel.font = KMAINFONT14;
    _progressCountLabel.textAlignment = NSTextAlignmentLeft;
    _progressTitleLabel.textColor = kMAIN9696;
    [self addSubview:_progressTitleLabel];
    
    _progressView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, height)];
    _progress=0;
    self.progressViewStyle=style;
    [self addSubview:_progressView];
    
    _progressCountLabel = [[UILabel alloc] init];
    _progressCountLabel.font = LZBFont(12, NO);
    _progressCountLabel.textColor = KMAIN5868;
    _progressCountLabel.textAlignment = NSTextAlignmentRight;
    [_progressCountLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self addSubview:_progressCountLabel];
    
    [_progressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self).offset(0);
        make.top.equalTo(self);
        make.height.equalTo(self);
    }];
    
    [_progressCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo(30);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_progressTitleLabel.mas_right).offset(5);
        make.right.equalTo(_progressCountLabel.mas_left).offset(-5);
        make.height.mas_equalTo(8);
        make.centerY.equalTo(_progressTitleLabel);
    }];

    
}

-(void)setProgressViewStyle:(LZBProgressViewStyle)progressViewStyle
{
    _progressViewStyle = progressViewStyle;
    
    if (progressViewStyle==LZBProgressViewStyleTrackFillet) {
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=self.bounds.size.height/2;
    }
    else if (progressViewStyle==LZBProgressViewStyleAllFillet)
    {
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=self.bounds.size.height/2;
        _progressView.layer.cornerRadius=self.bounds.size.height/2;
    }
}

-(void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor=trackTintColor;
    if (self.trackImage) {
        
    }
    else
    {
        self.backgroundColor=trackTintColor;
    }
}
-(void)setProgress:(float)progress
{
    _progress=MIN(progress, 1);
    _progressView.frame=CGRectMake(0, 0, self.bounds.size.width*_progress, self.bounds.size.height);
}
-(float)progress
{
    return _progress;
}
-(void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor=progressTintColor;
    _progressView.backgroundColor=progressTintColor;
}

- (void)setProgressTitle:(NSString *)progressTitle{
    _progressTitle = progressTitle;
    _progressTitleLabel.text = _progressTitle;
}

- (void)setCountString:(NSString *)countString{
    _countString = countString;
    _progressCountLabel.text = _countString;
}
-(void)setTrackImage:(UIImage *)trackImage
{
    _trackImage=trackImage;
    if(self.isTile)
    {
        self.backgroundColor=[UIColor colorWithPatternImage:trackImage];
    }
    else
    {
        self.backgroundColor=[UIColor colorWithPatternImage:[self stretchableWithImage:trackImage]];
    }
}
-(void)setIsTile:(BOOL)isTile
{
    _isTile = isTile;
    if (self.progressImage) {
        [self setProgressImage:self.progressImage];
    }
    if (self.trackImage) {
        [self setTrackImage:self.trackImage];
    }
}
-(void)setProgressImage:(UIImage *)progressImage
{
    _progressImage = progressImage;
    if(self.isTile)
    {
        _progressView.backgroundColor=[UIColor colorWithPatternImage:progressImage];
    }
    else
    {
        _progressView.backgroundColor=[UIColor colorWithPatternImage:[self stretchableWithImage:progressImage]];
    }
}
- (UIImage *)stretchableWithImage:(UIImage *)image{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.f);
    [image drawInRect:self.bounds];
    UIImage *lastImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return lastImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
