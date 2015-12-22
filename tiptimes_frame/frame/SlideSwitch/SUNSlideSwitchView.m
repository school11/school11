//
//  SUNSlideSwitchView.m
//  SUNCommonComponent
//
//  Created by 麦志泉 on 13-9-4.
//  Copyright (c) 2013年 中山市新联医疗科技有限公司. All rights reserved.
//

#import "SUNSlideSwitchView.h"
#import "TTBaseViewController.h"
#import "TTDoString.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kWidthOfButtonMargin = 16.0f;
static const CGFloat kFontSizeOfTabButton = 17.0f;
static const CGFloat kFontSizeOfTabButton1 = 13.0f;
static const NSUInteger kTagOfRightSideButton = 999;
static  float btn_width ;
@implementation SUNSlideSwitchView




#pragma mark - 初始化参数

- (void)initValues
{
    int x = [TTDoString getSlidenum];
    
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.bounds.size.width, kHeightOfTopScrollView)];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor colorWithRed:(22.0/255) green:(125.0/255) blue:(163.0/255) alpha:1.0];
//    _topScrollView.backgroundColor = [UIColor blackColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_topScrollView];
    _userSelectedChannelID = 100;
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView+64, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    //创建导航栏,判断是哪个视图
    
    switch (x) {
        case 1:{
            _top_view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            imageView.image = [UIImage imageNamed:@"navigate.png"];
            
            UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(112, 33, 97, 21)];
            title_label.text = @"导师答疑";
            title_label.textColor = [UIColor whiteColor];
            title_label.font = [UIFont boldSystemFontOfSize:19.0f];;
            
            UIButton *leftarrow = [[UIButton alloc] initWithFrame:CGRectMake(3, 26, 36, 36)];
            
            [leftarrow setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
            leftarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [leftarrow addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            
//            UIButton *help = [[UIButton alloc] initWithFrame:CGRectMake(281, 26, 36, 36)];
            
//            [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
//            help.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            
            [_top_view addSubview:imageView ];
            [_top_view addSubview:leftarrow ];
//            [_top_view addSubview:help ];
            [_top_view addSubview:title_label];
            [self addSubview:_top_view];
            break;
        }
        case 2:{
            _top_view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            imageView.image = [UIImage imageNamed:@"navigate.png"];
            
            UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(112, 33, 97, 21)];
            title_label.text = @"我的消息";
            title_label.textColor = [UIColor whiteColor];
            title_label.font = [UIFont boldSystemFontOfSize:19.0f];;
            
            UIButton *leftarrow = [[UIButton alloc] initWithFrame:CGRectMake(3, 26, 36, 36)];
            
            [leftarrow setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
            leftarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [leftarrow addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            
//            UIButton *help = [[UIButton alloc] initWithFrame:CGRectMake(281, 26, 36, 36)];
            
//            [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
//            help.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            
            [_top_view addSubview:imageView ];
            [_top_view addSubview:leftarrow ];
//            [_top_view addSubview:help ];
            [_top_view addSubview:title_label];
            [self addSubview:_top_view];
            break;
        }
        case 3:{
            _top_view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            imageView.image = [UIImage imageNamed:@"navigate.png"];
            
            UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(112, 33, 97, 21)];
            title_label.text = @"讲话著作";
            title_label.textColor = [UIColor whiteColor];
            title_label.font = [UIFont boldSystemFontOfSize:19.0f];;
            
            UIButton *leftarrow = [[UIButton alloc] initWithFrame:CGRectMake(3, 26, 36, 36)];
            
            [leftarrow setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
            leftarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [leftarrow addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton *rightarrow = [[UIButton alloc] initWithFrame:CGRectMake(275, 26, 36, 36)];
            [rightarrow setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
            rightarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [rightarrow addTarget:self action:@selector(search1:) forControlEvents:UIControlEventTouchUpInside];
//            UIButton *help = [[UIButton alloc] initWithFrame:CGRectMake(281, 26, 36, 36)];
            
//            [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
//            help.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
//            
            [_top_view addSubview:imageView ];
            [_top_view addSubview:leftarrow ];
            [_top_view addSubview:rightarrow ];
//            [_top_view addSubview:help ];
            [_top_view addSubview:title_label];
            [self addSubview:_top_view];
            break;
        }
        case 4:{
            _top_view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            imageView.image = [UIImage imageNamed:@"navigate.png"];
            
            UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(112, 33, 97, 21)];
            title_label.text = @"线下活动";
            title_label.textColor = [UIColor whiteColor];
            title_label.font = [UIFont boldSystemFontOfSize:19.0f];;
            
            UIButton *leftarrow = [[UIButton alloc] initWithFrame:CGRectMake(3, 26, 36, 36)];
            
            [leftarrow setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
            leftarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [leftarrow addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *rightarrow = [[UIButton alloc] initWithFrame:CGRectMake(275, 26, 36, 36)];
            [rightarrow setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
            rightarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [rightarrow addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
            
//            UIButton *help = [[UIButton alloc] initWithFrame:CGRectMake(281, 26, 36, 36)];
//            
//            [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
//            help.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            
            [_top_view addSubview:imageView ];
            [_top_view addSubview:leftarrow ];
            [_top_view addSubview:rightarrow ];
//            [_top_view addSubview:help ];
            [_top_view addSubview:title_label];
            [self addSubview:_top_view];
            break;
        }
        case 5:{
            _top_view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            imageView.image = [UIImage imageNamed:@"navigate.png"];
            
            UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(112, 33, 97, 21)];
            title_label.text = @"辅导材料";
            title_label.textColor = [UIColor whiteColor];
            title_label.font = [UIFont boldSystemFontOfSize:19.0f];;
            
            UIButton *leftarrow = [[UIButton alloc] initWithFrame:CGRectMake(3, 26, 36, 36)];
            
            [leftarrow setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
            leftarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [leftarrow addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            UIButton *rightarrow = [[UIButton alloc] initWithFrame:CGRectMake(275, 26, 36, 36)];
            [rightarrow setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
            rightarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [rightarrow addTarget:self action:@selector(search3:) forControlEvents:UIControlEventTouchUpInside];
//            UIButton *help = [[UIButton alloc] initWithFrame:CGRectMake(281, 26, 36, 36)];
//            
//            [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
//            help.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            
            [_top_view addSubview:imageView ];
            [_top_view addSubview:leftarrow ];
            [_top_view addSubview:rightarrow ];

//            [_top_view addSubview:help ];
            [_top_view addSubview:title_label];
            [self addSubview:_top_view];
            break;
        }
        case 6:{
            _top_view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
            imageView.image = [UIImage imageNamed:@"navigate.png"];
            
            UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(112, 33, 97, 21)];
            title_label.text = @"我的收藏";
            title_label.textColor = [UIColor whiteColor];
            title_label.font = [UIFont boldSystemFontOfSize:19.0f];;
            
            UIButton *leftarrow = [[UIButton alloc] initWithFrame:CGRectMake(3, 26, 36, 36)];
            
            [leftarrow setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
            leftarrow.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            [leftarrow addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            
//            UIButton *help = [[UIButton alloc] initWithFrame:CGRectMake(281, 26, 36, 36)];
//            
//            [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
//            help.imageEdgeInsets = UIEdgeInsetsMake(9,9,9,9);
            
            [_top_view addSubview:imageView ];
            [_top_view addSubview:leftarrow ];
//            [_top_view addSubview:help ];
            [_top_view addSubview:title_label];
            [self addSubview:_top_view];
            break;
        }

        
        default:{
            break;
        
        }
        
            
    }
    
    
    
    _viewArray = [[NSMutableArray alloc] init];
    _isBuildUI = NO;
    
}

-(IBAction)back:(id)sender{
    [[TTBaseViewController getNav] popViewControllerAnimated:YES];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter

- (void)setRigthSideButton:(UIButton *)rigthSideButton
{
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    _rigthSideButton = rigthSideButton;
    [self addSubview:_rigthSideButton];
    
}

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rigthSideButton.bounds.size.width > 0) {
            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
                                                _rigthSideButton.bounds.size.width, _topScrollView.bounds.size.height);
            
            _topScrollView.frame = CGRectMake(0, 0,
                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
        }
        
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
        
        //调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [self adjustScrollViewContentX:button];
    }
}

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
    }
    [self createNameButtons];
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
    
    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons
{
    int x = [TTDoString getSlidenum];
    NSLog(@"456%d",x);
    switch (x) {
        case 4:
            btn_width = self.bounds.size.width/3;
            break;
        case 6:
            btn_width = self.bounds.size.width/3;
            break;
        default:
            break;
    }
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:_shadowImage];
    [_topScrollView addSubview:_shadowImageView];
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = 0;
    //每个tab偏移量
    CGFloat xOffset = 0;
    
    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        switch (x) {
            case 3:
                button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton1];
                break;
            case 4:
                button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton1];
                break;
            case 5:
                button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton1];
                break;
            case 6:
                button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton1];
                break;
            default:
                button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
                break;
        }
     //  [button setBackgroundColor:[UIColor redColor]];
        CGSize textSize = [vc.title sizeWithFont:[UIFont systemFontOfSize:kFontSizeOfTabButton]
                               constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        //累计每个tab文字的长度
        topScrollViewContentWidth +=  textSize.width;
        //设置按钮尺寸,按钮是否均分
        if(x == 4 || x == 6){
            [button setFrame:CGRectMake(xOffset,0,
                                        btn_width, kHeightOfTopScrollView)];
            //计算下一个tab的x偏移量
            xOffset += btn_width;
            [button setTag:i+100];
            if (i == 0) {
                _shadowImageView.frame = CGRectMake(0, 42, btn_width, 2);
                button.selected = YES;
            }
        }else{
            [button setFrame:CGRectMake(xOffset,0,
                                        textSize.width, kHeightOfTopScrollView)];
            //计算下一个tab的x偏移量
            xOffset += textSize.width;
            [button setTag:i+100];
            if (i == 0) {
                _shadowImageView.frame = CGRectMake(0, 42, textSize.width, 2);
                button.selected = YES;
            }
        }
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_topScrollView addSubview:button];
    }
    
    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
   
}


#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender
{
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 42, sender.frame.size.width, 2)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((sender.tag - 100)*self.bounds.size.width, 0) animated:YES];
                }
                _isRootScroll = NO;
                
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}

/*!
 * @method 调整顶部滚动视图x位置
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    //如果 当前显示的最后一个tab文字超出右边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x > self.bounds.size.width - (kWidthOfButtonMargin+sender.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - (_topScrollView.bounds.size.width- (0+sender.bounds.size.width)), 0)  animated:YES];    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x < kWidthOfButtonMargin) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x , 0)  animated:YES];
    }
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width +100;
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

#pragma mark - 工具方法

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

-(void)search:(UIButton *)sender{
    [_parent pushViewController:@"Search1ViewController"];
}
-(void)search1:(UIButton *)sender{
    [_parent pushViewController:@"Search2ViewController"];
}

-(void)search3:(UIButton *)sender{
    [_parent pushViewController:@"Search3ViewController"];
}

@end
