//
//  VITabBar.m
//  Vinoli
//
//  Created by Nicolas Goles on 6/6/14.
//  Copyright (c) 2014 Goles. All rights reserved.
//

#import "GGTabBar.h"
#import "GGTabBarAppearanceKeys.h"

static const NSInteger kSeparatorOffsetTag = 7000;
static const NSInteger kMarginSeparatorOffsetTag = 8000;

@interface GGTabBar ()
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *separators; // Between-buttons separators
@property (nonatomic, strong) NSMutableArray *marginSeparators; // Start/End Separators

// Appearance
@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, strong) UIColor *tabBarBackgroundColor;
@property (nonatomic, strong) UIColor *tabBarTintColor;

// References to Constraints
@property (nonatomic, weak) NSLayoutConstraint *heightConstraint;
@end

@implementation GGTabBar{
    NSUInteger oldButtonIndex;
    NSUInteger newButtonIndex;
}

#pragma mark - Public API

- (instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray *)viewControllers appearance:(NSDictionary *)appearance
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttons = [[NSMutableArray alloc] init];
        _separators = [[NSMutableArray alloc] init];
        _marginSeparators = [[NSMutableArray alloc] init];
        _viewControllers = viewControllers;
        self.tabBarHeight = 44;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self initSubViewsWithControllers:_viewControllers];

        if (appearance) {
            [self setAppearance:appearance];
        }

        [self addHeightConstraints];
        [self addAllLayoutConstraints];
    }
    return self;
}

- (void)setSelectedButton:(UIButton *)selectedButton
{
    oldButtonIndex = [_buttons indexOfObject:_selectedButton];
    newButtonIndex = [_buttons indexOfObject:selectedButton];
    if (oldButtonIndex != NSNotFound) {
        UIViewController *oldSelectedViewController = _viewControllers[oldButtonIndex];
        [_selectedButton setImage:oldSelectedViewController.tabBarItem.image forState:UIControlStateNormal];
    }

    if (newButtonIndex != NSNotFound) {
        UIViewController *newSelectedViewController = _viewControllers[newButtonIndex];
        [selectedButton setImage:newSelectedViewController.tabBarItem.selectedImage forState:UIControlStateNormal];
    }
    if(oldButtonIndex != newButtonIndex){
        [selectedButton setBackgroundImage:[UIImage imageNamed:@"home_cp@2x"] forState:UIControlStateNormal];
        [selectedButton setTitleColor:[UIColor colorWithRed:(48.0/255) green:(130.0/255) blue:(210.0/255) alpha:1.0] forState:UIControlStateNormal];

        [selectedButton setUserInteractionEnabled:NO];
        [_selectedButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_selectedButton setUserInteractionEnabled:YES];
        [_selectedButton setTitleColor:[UIColor colorWithRed:(88.0/255) green:(173.0/255) blue:(57.0/255) alpha:1.0] forState:UIControlStateNormal];

    }
    _selectedButton = selectedButton;
}

- (void)setAppearance:(NSDictionary *)appearance
{
    if (appearance[kTabBarAppearanceBackgroundColor]) {
//        self.backgroundColor = self.tabBarBackgroundColor = [UIColor whiteColor];
    }

    if (appearance[kTabBarAppearanceHeight]) {
        self.tabBarHeight = [appearance[kTabBarAppearanceHeight] floatValue];
    }

    if (appearance[kTabBarAppearanceTint]) {
        // Do something with the tint here.
    }
}

- (void)startDebugMode
{
    [self paintDebugViews];
    [self addDebugConstraints];
    [self updateConstraints];
}

#pragma mark - UIView
- (void)didMoveToSuperview
{
    // When the app is first launched set the selected button to be the first button
    [self setSelectedButton:[_buttons firstObject]];
}

#pragma mark - Delegate

- (void)tabButtonPressed:(id)sender
{
    NSUInteger buttonIndex = [_buttons indexOfObject:sender];
    [_delegate tabBar:self didPressButton:sender atIndex:buttonIndex];
}

#pragma mark - Subviews


/** takes an array of ViewControllers to internally instanciate
 * it's Subview structure. (buttons, separators & margins).
 * note: will not lay it out right away.
 */
- (void)initSubViewsWithControllers:(NSArray *)viewControllers
{
    // Add Buttons
    NSUInteger tagCounter = 0;

    for (UIViewController *viewController in viewControllers) {

        UIButton *button = [[UIButton alloc] init];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.tag  = tagCounter;
        [button setImage:viewController.tabBarItem.image forState:UIControlStateNormal];
        [button setImage:viewController.tabBarItem.selectedImage forState:UIControlStateSelected];
        button.imageEdgeInsets = UIEdgeInsetsMake(-95,20,-5,20);
        
        [button setTitle:viewController.tabBarItem.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        button.titleLabel.textAlignment =NSTextAlignmentCenter ;
        [button setTitleColor:[UIColor colorWithRed:(88.0/255) green:(173.0/255) blue:(57.0/255) alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        button.titleEdgeInsets = UIEdgeInsetsMake(-52, -31, 0, 0);
        [button setContentEdgeInsets:UIEdgeInsetsMake(65, 0, -20, 0)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //设置button的内容横向居中。。设置content是title和image一起变化
        [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [button setBackgroundColor:[UIColor redColor]];
       [button sizeToFit];
        NSLog(@"%f",button.frame.size.width);
        [self addSubview:button];
        [_buttons addObject:button];
//        //放置image对象
//        UIImageView *iv = [[UIImageView alloc] init ];
//        iv.image = [UIImage imageNamed:@"四标签图标"];
//        iv.frame = CGRectMake(11, 5, 40, 40);
//        [button addSubview:iv];
        tagCounter++;
     

    }
        //设置底部图片
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_backgroud.png"]]] ;
    //设置背景图片

 
    
    // Add Separators
    NSInteger limit = [self.subviews count] - 1;

    for (int i = 0; i < limit; ++i) {
        UIView *separator = [[UIView alloc] init];

        separator.translatesAutoresizingMaskIntoConstraints = NO;
        separator.tag = i + kSeparatorOffsetTag;

        [self addSubview:separator];
        [_separators addObject:separator];
    }

    // Add Margin Separators (we always have two margins)
    for (int i = 0; i < 2; ++i) {
        UIView *marginSeparator = [[UIView alloc] init];

        marginSeparator.translatesAutoresizingMaskIntoConstraints = NO;
        marginSeparator.tag = i + kMarginSeparatorOffsetTag;

        [self addSubview:marginSeparator];
        [_marginSeparators addObject:marginSeparator];
    }
}

#pragma mark - Constraints -

- (void)removeSubViews
{
    while ([self.subviews count] > 0)
        [[self.subviews lastObject] removeFromSuperview];
}

- (void)reloadTabBarButtons
{
    [self removeConstraints:[self constraints]];
    [self removeSubViews];
    [self initSubViewsWithControllers:_viewControllers];
}

#pragma mark Add

- (void)addHeightConstraints
{
    // Adjust the constraint multiplier and item depending if there's a custom tabBarHeight
    CGFloat multiplier = self.tabBarHeight == CGFLOAT_MIN ? 1.5 : 0.0;

    id item = self.tabBarHeight == CGFLOAT_MIN ? [_buttons firstObject] : nil;
    CGFloat layoutConstant = item ? 0.0 : self.tabBarHeight;

    if (_heightConstraint) {
        [self removeConstraint:_heightConstraint];
        _heightConstraint = nil;
    }

    _heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:item
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:multiplier
                                                      constant:layoutConstant];
    
    [self addConstraint:_heightConstraint];
}

- (void)addAllLayoutConstraints
{
    NSDictionary *viewsDictionary = [self visualFormatStringViewsDictionaryWithButtons:_buttons
                                                          separators:_separators
                                                    marginSeparators:_marginSeparators];

    NSString *visualFormatString = [self visualFormatConstraintStringWithButtons:_buttons
                                                                      separators:_separators
                                                                marginSeparators:_marginSeparators];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormatString
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];

    NSMutableArray *allSeparators = [NSMutableArray arrayWithArray:_separators];
    [allSeparators addObjectsFromArray:_marginSeparators];

    [self addConstraints:[self separatorWidthConstraintsWithSeparators:allSeparators]];
    [self addConstraints:[self centerAlignmentConstraintsWithButtons:_buttons
                                                          separators:allSeparators]];
}

- (void)addDebugConstraints
{
    [self addConstraints:[self heightConstraintsWithSeparators:_separators]];
    [self addConstraints:[self heightConstraintsWithSeparators:_marginSeparators]];
}

#pragma Creation

- (NSArray *)separatorWidthConstraintsWithSeparators:(NSArray *)separators
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];

    [separators enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *separator = (UIView *)obj;
        UIView *targetSeparator;

        if ([obj isEqual:[separators lastObject]]) {
            targetSeparator = [separators firstObject];
        } else {
            targetSeparator = [separators objectAtIndex:(idx + 1)];
        }

        NSLayoutConstraint *constraint;
        constraint = [NSLayoutConstraint constraintWithItem:separator
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:targetSeparator
                                                  attribute:NSLayoutAttributeWidth
                                                 multiplier:1.0
                                                   constant:0.0];
        [constraints addObject:constraint];
    }];

    return constraints;
}

- (NSArray *)heightConstraintsWithSeparators:(NSArray *)separators
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];

    for (UIView *separator in separators) {
        NSLayoutConstraint *constraint;
        constraint = [NSLayoutConstraint constraintWithItem:separator
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1.0
                                                   constant:10.0];
        [constraints addObject:constraint];
    }

    return constraints;
}

- (NSArray *)centerAlignmentConstraintsWithButtons:(NSArray *)buttons
                                        separators:(NSArray *)separators
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];

    NSMutableArray *buttonsAndSeparators = [[NSMutableArray alloc] init];

    [buttonsAndSeparators addObjectsFromArray:buttons];
    [buttonsAndSeparators addObjectsFromArray:separators];

    // We could iterate through buttons only, but having Y axis
    // aligned separators is more visually pleasing for debugging.
    for (UIView *view in buttonsAndSeparators) {
        NSLayoutConstraint *constraint;
        constraint = [NSLayoutConstraint constraintWithItem:view
                                                  attribute:NSLayoutAttributeCenterY
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                  attribute:NSLayoutAttributeCenterY
                                                 multiplier:1.0
                                                   constant:0.0];
        [constraints addObject:constraint];
    }

    return constraints;
}

#pragma mark Helpers

- (NSDictionary *)visualFormatStringViewsDictionaryWithButtons:(NSArray *)buttons
                                                    separators:(NSArray *)separators
                                              marginSeparators:(NSArray *)marginSeparators
{
    // There's always N - 1 Separators
    NSParameterAssert([buttons count] - 1 == [separators count]);

    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];

    for (UIButton *button in buttons) {
        NSString *key = [NSString stringWithFormat:@"button%ld", (long)button.tag];
        viewsDictionary[key] = button;
    }

    for (UIView *separator in separators) {
        NSString *key = [NSString stringWithFormat:@"separator%ld", (long)separator.tag];
        viewsDictionary[key] = separator;
    }

    for (UIView *marginSeparator in marginSeparators) {
        NSString *key = [NSString stringWithFormat:@"marginSeparator%ld", (long)marginSeparator.tag];
        viewsDictionary[key] = marginSeparator;
    }

    return viewsDictionary;
}

- (NSString *)visualFormatConstraintStringWithButtons:(NSArray *)buttons
                                           separators:(NSArray *)separators
                                     marginSeparators:(NSArray *)marginSeparators
{
    NSEnumerator *buttonsEnumerator = [buttons objectEnumerator];
    NSMutableArray *constraintParts = [[NSMutableArray alloc] init];

    UIButton *button;
    NSInteger separatorCounter = 0;

    while (button = [buttonsEnumerator nextObject]) {
        NSString *buttonFormat = [NSString stringWithFormat:@"button%ld", (long)button.tag];
        [constraintParts addObject:[NSString stringWithFormat:@"[%@]", buttonFormat]];

        if ([button isEqual:[buttons lastObject]]) {
            break;
        }

        UIView *separator = separators[separatorCounter];
        NSString *separatorFormat = [NSString stringWithFormat:@"separator%ld", (long)separator.tag];
        [constraintParts addObject:[NSString stringWithFormat:@"[%@]", separatorFormat]];
        separatorCounter++;
    }

    UIView *firstMarginSeparator = marginSeparators[0];
    UIView *lastMarginSeparator = marginSeparators[1];
    NSMutableString *constraint = [NSMutableString stringWithFormat:@"H:|[marginSeparator%ld]", (long)firstMarginSeparator.tag];
    [constraint appendString:[constraintParts componentsJoinedByString:@""]];
    [constraint appendString:[NSString stringWithFormat:@"[marginSeparator%ld]|", (long)lastMarginSeparator.tag]];
    
    return constraint;
}

#pragma mark - Debug

- (void)paintDebugViews
{
    self.backgroundColor = [UIColor blueColor];

    for (UIView *button in _buttons) {
        button.backgroundColor = [UIColor whiteColor];
    }

    for (UIView *separator in _separators) {
        separator.backgroundColor = [UIColor redColor];
    }

    for (UIView *marginSeparator in _marginSeparators) {
        marginSeparator.backgroundColor = [UIColor greenColor];
    }
}

@end
