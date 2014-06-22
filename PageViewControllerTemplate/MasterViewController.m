//
//  MasterViewController.m
//  PageViewControllerTemplate
//
//  Created by Jeremy Margaritondo on 5/31/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController () {
    NSArray *pages;
    NSMutableArray *viewControllers;
}

@end

@implementation MasterViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}



- (void)viewDidLoad
{
    [super viewDidLoad];
    pages = @[@"Page1", @"Page2", @"Page3", @"Page4"];
    
    // Set up and initialize the page view controller
    UIPageViewController *pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    pageViewController.dataSource = self;
    
    // Create all of the view controlers that display each page on the story board
    viewControllers = [NSMutableArray array];
    
    for (int i = 0; i < pages.count; i++) {
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:pages[i]];
        vc.index = i;
        [viewControllers addObject:vc];
    }
    
    // Set the default page to the first in the array and send it to the page view controller
    NSArray *defaultViewController = [NSArray arrayWithObject:viewControllers[0]];
    
    [pageViewController setViewControllers:defaultViewController direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = ((ViewController*) viewController).index;
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return viewControllers[index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = ((ViewController*) viewController).index;
    
    if (index == viewControllers.count - 1) {
        return nil;
    }
    
    index++;
    return viewControllers[index];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
