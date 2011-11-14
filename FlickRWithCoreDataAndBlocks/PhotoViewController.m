//
//  PhotoViewController.m
//  FlickingQuery
//
//  Created by Salim Benabbou on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController ()

@property (retain) UIActivityIndicatorView *spinner;
@end

@implementation PhotoViewController
@synthesize imageURL,spinner;

- (void)dealloc {
    [imageURL release];
    [spinner release];
    [super dealloc];
}
-(void)loadView
{
    
     
}
-(void)viewWillAppear:(BOOL)animated{
        // UIImage * image =[UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithURLString:imageURL]];
    
    [FlickrFetcher processImageDataWithBlock:^(NSData *imageData){
        UIImage * image = [UIImage imageWithData:imageData];
        imageView = [[UIImageView alloc] initWithImage:image];
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        scrollView.minimumZoomScale = 0.5;
        scrollView.maximumZoomScale = 5.0;
        scrollView.contentSize = image.size;
        [scrollView addSubview:imageView];
        scrollView.delegate = self;
        self.view = scrollView;
        [spinner stopAnimating];
    } withUrl:imageURL];
   
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //[image release];
    self.view = spinner;
    [spinner startAnimating];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return 
    imageView;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void) viewDidLoad
{
    [super viewDidLoad];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
