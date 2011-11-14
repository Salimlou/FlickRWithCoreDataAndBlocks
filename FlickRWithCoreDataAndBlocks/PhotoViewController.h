//
//  PhotoViewController.h
//  FlickingQuery
//
//  Created by Salim Benabbou on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIScrollViewDelegate>{
    NSString * imageURL;
    UIImageView * imageView;
    UIActivityIndicatorView * spinner;
}

@property (copy) NSString * imageURL;
@end
