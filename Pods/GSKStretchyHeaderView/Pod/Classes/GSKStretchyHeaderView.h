#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GSKStretchyHeaderViewContentAnchor) {
    GSKStretchyHeaderViewContentAnchorTop = 0,
    GSKStretchyHeaderViewContentAnchorBottom = 1
};

@interface GSKStretchyHeaderView : UIView

/**
 The main view to which you add your custom content.
 */
@property (nonatomic, readonly) UIView *contentView;

/**
 The height of the header view when it's expanded. Default value is equal to the initial frame height, or 240 if unspecified.
 */
@property (nonatomic) IBInspectable CGFloat maximumContentHeight; // defaults to initial frame height

/**
 The minimum height of the header view. You usually want to set it to a value larger than 64 if you want to simulate a navigation bar. Defaults to 0.
 */
@property (nonatomic) IBInspectable CGFloat minimumContentHeight; // defaults to 0

/**
 The contentInset for the contentView. Defaults to UIEdgeInsetsZero.
 */
@property (nonatomic) IBInspectable UIEdgeInsets contentInset; // default UIEdgeInsetsZero

/**
 Specifies wether the contentView sticks to the top or the bottom of the headerView. Default value is GSKStretchyHeaderContentViewAnchorTop.
 */
#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSUInteger contentAnchor;
#else
@property (nonatomic) GSKStretchyHeaderViewContentAnchor contentAnchor;
#endif

/**
 Specifies wether the contentView height stretches when scrolling up. Default is YES.
 */
@property (nonatomic) IBInspectable BOOL contentStretches;

/**
 Specifies wether the contentView height will be increased when scrolling down. Default is YES.
 */
@property (nonatomic) IBInspectable BOOL contentBounces;

/**
 Sets a new maximumContent height and scrolls to the top.
 */
- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight
                  resetAnimated:(BOOL)animated;

@end


@protocol GSKStretchyHeaderViewStretchDelegate <NSObject>

- (void)stretchyHeaderView:(GSKStretchyHeaderView *)headerView
    didChangeStretchFactor:(CGFloat)stretchFactor;

@end


@interface GSKStretchyHeaderView (StretchFactor)

/**
 The stretch factor is the relation between the current content height and the maximum (1) and minimum (0) contentHeight.
 Can be greater than 1 if contentViewBounces equals YES.
 */
@property (nonatomic, readonly) CGFloat stretchFactor;

/**
 The stretch delegate will be notified every time the stretchFactor changes.
 */
@property (nonatomic, weak) id<GSKStretchyHeaderViewStretchDelegate> stretchDelegate;

/**
 This method will be called every time the stretchFactor changes. 
 Can be overriden by subclasses to adjust subviews depending on the value of the stretchFactor.
 */
- (void)didChangeStretchFactor:(CGFloat)stretchFactor;

@end


@interface GSKStretchyHeaderView (Layout)

/**
 This method will be called after the contentView performs -layoutSubviews. It can be useful to
 retrieve initial values for views added to the contentView. The default implementation does nothing.
 */
- (void)contentViewDidLayoutSubviews;

@end

NS_ASSUME_NONNULL_END
