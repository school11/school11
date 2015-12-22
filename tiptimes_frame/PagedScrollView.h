//
//  PagedScrollView.h
//
//  Modified from https://github.com/jianpx/ios-cabin/tree/master/PagedImageScrollView
//

#import <UIKit/UIKit.h>

enum PageControlPosition {
    PageControlPositionRightCorner = 0,
    PageControlPositionCenterBottom = 1,
    PageControlPositionLeftCorner = 2,
};


@interface PagedScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) enum PageControlPosition pageControlPos; //default is PageControlPositionRightCorner

- (void)setScrollViewContents: (NSArray *)views;
@end



//用法
//CGFloat scrollViewWidth = self.view.bounds.size.width;
//CGRect pageFrame = CGRectMake((self.view.bounds.size.width - scrollViewWidth), (self.view.bounds.size.height - scrollViewHeight), scrollViewWidth, scrollViewHeight);
//
//pageScrollView = [pageScrollView initWithFrame:pageFrame];
//
//NSString* appID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
//
//NSMutableArray *views = [NSMutableArray arrayWithCapacity:4];
//NSMutableArray *images = [NSMutableArray arrayWithObjects:@"OnboardStep2", @"OnboardStep3", nil];
//
//if ([appID isEqualToString:@"com.inkmobility.ThatPhoto"]) {
//    [images insertObject:@"WelcomeThatPhoto" atIndex:0];
//} else if ([appID isEqualToString:@"com.inkmobility.thatinbox"]) {
//    [images insertObject:@"WelcomeThatInbox" atIndex:0];
//} else if ([appID isEqualToString:@"com.inkmobility.ThatPDF"]) {
//    [images insertObject:@"WelcomeThatPDF" atIndex:0];
//} else if ([appID isEqualToString:@"com.inkmobility.thatcloud"]) {
//    [images insertObject:@"WelcomeThatCloud" atIndex:0];
//}
//for (NSString *imageName in images) {
//    UIView *welcomeScreen = [[UIView alloc] init];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
//    imageView.frame = CGRectMake(CGRectGetMidX(welcomeScreen.bounds) - CGRectGetMidX(imageView.bounds), 0, imageView.bounds.size.width, imageView.bounds.size.height);
//    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//    [welcomeScreen addSubview:imageView];
//    welcomeScreen.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
//    [views addObject:welcomeScreen];
//}
//
//[pageScrollView setScrollViewContents:views];
