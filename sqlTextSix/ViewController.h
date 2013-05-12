//
//  ViewController.h
//  sqlTextSix
//
//  Created by 曹 盛杰 on 13-5-11.
//  Copyright (c) 2013年 曹 盛杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *citynameTextField;
@property (weak, nonatomic) IBOutlet UITextField *citycodeTextField;

@property (assign,nonatomic) NSInteger flag;
@property (strong,nonatomic) NSDictionary *dicDatas;
@end
