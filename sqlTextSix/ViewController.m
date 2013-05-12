//
//  ViewController.m
//  sqlTextSix
//
//  Created by 曹 盛杰 on 13-5-11.
//  Copyright (c) 2013年 曹 盛杰. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseManager.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize flag,dicDatas;
@synthesize citycodeTextField,citynameTextField;

#pragma mark - lifd
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *btn;
    if (flag == 1){
        self.title = @"Add";
        btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addNewCity:)];
    }else if (flag ==2) {
        self.title = @"Edit";
        btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editCity:)];
    }
    self.navigationItem.rightBarButtonItem = btn;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    citycodeTextField.text = [dicDatas objectForKey:@"CityCode"];
    citynameTextField.text = [dicDatas objectForKey:@"CityName"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - added
-(void)addNewCity:(id)send{
    [[DatabaseManager sharedInstance]insertCityName:citynameTextField.text CityCode:citycodeTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editCity:(id)send{
    [[DatabaseManager sharedInstance]updateCityName:citynameTextField.text CityCode:citycodeTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
