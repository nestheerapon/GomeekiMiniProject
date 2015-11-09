//
//  DetailViewController.m
//  MiniProject
//
//  Created by Nes Theerapon on 11/4/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+URLImage.h"
#import "APIHelper.h"
#import "ArticleDetail.h"

/* image ratio 16:9 */
#define kImageRatio     (9.f/16.f)

@interface DetailViewController () {
    CGFloat imageHeight;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) ArticleDetail *articleDetail;

// constraint for imageView
@property (nonatomic, retain) NSLayoutConstraint *imageViewTopLayoutConstraint;
@property (nonatomic, retain) NSLayoutConstraint *imageViewRightLayoutConstraint;

// constraint for webView
@property (nonatomic, retain) NSLayoutConstraint *webViewTopLayoutConstraint;
@property (nonatomic, retain) NSLayoutConstraint *webViewLeftLayoutConstraint;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.edgesForExtendedLayout = UIRectEdgeNone; /* start view under UINavigationBar */
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _selectedArticle.title;
    
    CGRect viewRect = self.view.frame;
    _imageView = [[UIImageView alloc] init];
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        /* portrait */
        _imageView.frame = CGRectMake(0, 0, viewRect.size.width, viewRect.size.width * kImageRatio);
    } else if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        /* landscape */
        _imageView.frame = CGRectMake(0, 0, viewRect.size.height, viewRect.size.height * kImageRatio);
    }
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageHeight = _imageView.frame.size.height;
    
    _webView = [[UIWebView alloc] init];
    CGFloat heightOffset = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height; /* navigation bar height + status bar height */
    _webView.frame = CGRectMake(0, CGRectGetHeight(_imageView.frame), viewRect.size.width, viewRect.size.height - CGRectGetHeight(_imageView.frame) - heightOffset);
    _webView.backgroundColor = [UIColor clearColor];
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_imageView];
    [self.view addSubview:_webView];
    
    [self initializeViewLayoutConstraint];
    [self loadDetail];
}

- (void)initializeViewLayoutConstraint
{
    /**
     *  Constraints for imageView
     */
    
    _imageViewTopLayoutConstraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:0 toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    /* add top constraint to imageView */
    [self.view addConstraint:_imageViewTopLayoutConstraint];
    
    
    /* add left constraint to imageView */
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:_imageView
                              attribute:NSLayoutAttributeLeft
                              relatedBy:0
                              toItem:self.view
                              attribute:NSLayoutAttributeLeft
                              multiplier:1
                              constant:0]];
    
    
    _imageViewRightLayoutConstraint = [NSLayoutConstraint
                                       constraintWithItem:_imageView
                                       attribute:NSLayoutAttributeRight
                                       relatedBy:0
                                       toItem:self.view
                                       attribute:NSLayoutAttributeRight
                                       multiplier:1
                                       constant:0];
    /* add right constraint to imageView */
    [self.view addConstraint:_imageViewRightLayoutConstraint];
    
    
    /* add bottom constraint to imageView */
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:_imageView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeWidth
                              multiplier:kImageRatio
                              constant:0]];
    
    
    
    /**
     *  Constraints for webView
     */
    
    _webViewTopLayoutConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTop relatedBy:0 toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    /* add top constraint to webView */
    [self.view addConstraint:_webViewTopLayoutConstraint];
    
    
    
    _webViewLeftLayoutConstraint = [NSLayoutConstraint
                                       constraintWithItem:_webView
                                       attribute:NSLayoutAttributeLeft
                                       relatedBy:0
                                       toItem:self.view
                                       attribute:NSLayoutAttributeLeft
                                       multiplier:1
                                       constant:0];
    /* add left constraint to webView */
    [self.view addConstraint:_webViewLeftLayoutConstraint];
    
    
    /* add right constraint to webView */
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:_webView
                              attribute:NSLayoutAttributeRight
                              relatedBy:0
                              toItem:self.view
                              attribute:NSLayoutAttributeRight
                              multiplier:1
                              constant:0]];
    
    
    /* add bottom constraint to webView */
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:_webView
                              attribute:NSLayoutAttributeBottom
                              relatedBy:0
                              toItem:self.view
                              attribute:NSLayoutAttributeBottom
                              multiplier:1
                              constant:0]];
    
    
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (self.view.bounds.size.height < self.view.bounds.size.width) {
        
        /* landscape */
        
        CGFloat screenWidth = self.view.bounds.size.width;
        CGFloat screenHeight = self.view.bounds.size.height;
        
        _imageViewTopLayoutConstraint.constant = -(screenHeight - imageHeight) / 2;
        _imageViewRightLayoutConstraint.constant = -(screenWidth / 2);
        
        _webViewTopLayoutConstraint.constant = 0;
        _webViewLeftLayoutConstraint.constant = screenWidth / 2;
        
    } else {
        
        /* portrait */
        
        _imageViewTopLayoutConstraint.constant = 0;
        _imageViewRightLayoutConstraint.constant = 0;
        
        _webViewTopLayoutConstraint.constant = imageHeight;
        _webViewLeftLayoutConstraint.constant = 0;
    }
}

- (void)loadDetail
{
    NSString *stringURL = [APIHelper loadDetailURLWithArticleID:_selectedArticle.articlesIdentifier];
    NSURL *URL = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *requestURL = [[NSURLRequest alloc] initWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:requestURL queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data) {
            NSError *jsonError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            if (error) {
                
                /* print error log */
                NSLog(@"%@", error.localizedDescription);
                
            } else {
                
                if (responseDict) {
                    
                    NSDictionary *statusDict = [responseDict objectForKey:@"status"];
                    NSString *statusCode = [statusDict objectForKey:@"code"];
                    
                    if ([statusCode isEqualToString:@"200"]) {
                        
                        /* success */
                        
                        NSDictionary *dataDict = [responseDict objectForKey:@"data"];
                        ArticleDetail *detail = [ArticleDetail modelObjectWithDictionary:dataDict];
                        NSString *imageStringURL = [NSString stringWithFormat:@"%@%@", [APIHelper baseURL], detail.image];
                        [self.imageView setImageWithURL:[NSURL URLWithString:imageStringURL] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
                        [self.webView loadHTMLString:detail.content baseURL:[NSURL URLWithString:[APIHelper baseURL]]];
                        
                    } else {
                        
                        /* failed, show alert from service */
                        NSString *failedTitle = [statusDict objectForKey:@"message"];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failed" message:failedTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                }
            }
        }
    }];
}

@end
