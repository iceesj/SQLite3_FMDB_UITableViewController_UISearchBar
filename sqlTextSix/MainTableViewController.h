//
//  MainTableViewController.h
//  sqlTextSix
//
//  Created by 曹 盛杰 on 13-5-11.
//  Copyright (c) 2013年 曹 盛杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITableViewController<UISearchBarDelegate>
{
    UIBarButtonItem *addBtn;
    NSMutableArray *cities;
}

@property (nonatomic,strong) IBOutlet UISearchBar *m_SearchBar;
@end
