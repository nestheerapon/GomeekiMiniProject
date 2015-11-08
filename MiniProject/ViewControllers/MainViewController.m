//
//  MainViewController.m
//  MiniProject
//
//  Created by Nes Theerapon on 11/4/15.
//  Copyright © 2015 Nes Theerapon. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "UIImageView+URLImage.h"
#import "Article.h"
#import "APIHelper.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *articleList;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Articles";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _articleList = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    // add constraints to tableView, to fit tableView with superView
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-[_tableView]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [self loadArticles];
}

- (void)loadArticles
{
    NSString *stringURL = [APIHelper loadArticlesURL];
    NSURL *URL = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *requestURL = [[NSURLRequest alloc] initWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:requestURL queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data) {
            NSError *jsonError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            if (error) {
                
                NSLog(@"%@", error.localizedDescription);
                
            } else {
                
                NSDictionary *statusDict = [responseDict objectForKey:@"status"];
                NSString *statusCode = [statusDict objectForKey:@"code"];
                
                if ([statusCode isEqualToString:@"200"]) {
                    
                    // success
                    NSDictionary *dataDict = [responseDict objectForKey:@"data"];
                    NSArray *articles = [dataDict objectForKey:@"articles"];
                    
                    for (NSDictionary *dict in articles) {
                        
                        Article *article = [Article modelObjectWithDictionary:dict];
                        [self.articleList addObject:article];
                    }
                    
                    [self.tableView reloadData];
                    
                } else {
                    
                    // failed, show alert from service
                    NSString *failedTitle = [statusDict objectForKey:@"message"];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failed" message:failedTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }
        }
     }];
}

#pragma mark -
#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _articleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ArticleCell"];
    }
    
    Article *article = (Article *)[self.articleList objectAtIndex:indexPath.row];
    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = article.shortDescription;
    
    NSString *imageStringURL = [NSString stringWithFormat:@"%@%@", [APIHelper baseURL], article.image];
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageStringURL] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    
    return cell;
}

#pragma mark -
#pragma mark UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Article *selectedArticle = [self.articleList objectAtIndex:indexPath.row];
    
    DetailViewController *detailViewCon = [[DetailViewController alloc] init];
    detailViewCon.selectedArticle = selectedArticle;
    [self.navigationController pushViewController:detailViewCon animated:YES];
}


@end
