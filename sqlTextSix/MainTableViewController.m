//
//  MainTableViewController.m
//  sqlTextSix
//
//  Created by 曹 盛杰 on 13-5-11.
//  Copyright (c) 2013年 曹 盛杰. All rights reserved.
//

#import "MainTableViewController.h"
#import "DatabaseManager.h"
#import "ViewController.h"
@interface MainTableViewController ()

@end

@implementation MainTableViewController
@synthesize m_SearchBar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMainNewCity:)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    cities = [[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    cities = [[DatabaseManager sharedInstance]queryCityName];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addMainNewCity:(id)sender{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ViewController *vc = [stb instantiateViewControllerWithIdentifier:@"CityAdd"];
    vc.flag = 1;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController pushViewController:vc animated:YES];//***
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",[[cities objectAtIndex:indexPath.row]objectForKey:@"CityName"],[[cities objectAtIndex:indexPath.row]objectForKey:@"CityCode"]];
    cell.detailTextLabel.text = [[cities objectAtIndex:indexPath.row]objectForKey:@"CityCode"];
    return cell;
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ViewController *vc = [stb instantiateViewControllerWithIdentifier:@"CityAdd"];
    vc.flag = 2;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[cities objectAtIndex:indexPath.row]objectForKey:@"CityName"],@"CityName",[[cities objectAtIndex:indexPath.row]objectForKey:@"CityCode"],@"CityCode",nil];
    vc.dicDatas = dic;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[DatabaseManager sharedInstance]deleteCutyCode:[[cities objectAtIndex:indexPath.row]objectForKey:@"CityCode"]];
        [cities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark - UISearchBarDelegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSString *query = m_SearchBar.text;
    if ([query length] == 0){
        cities = [[DatabaseManager sharedInstance]queryCityName];
    }else{
        cities = [[DatabaseManager sharedInstance]queryCityName:query];
    }
    [self.tableView reloadData];
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *query = m_SearchBar.text;
    
    if ([query length]==0){
        cities = [[DatabaseManager sharedInstance]queryCityName];
    }else{
        cities = [[DatabaseManager sharedInstance]queryCityName:query];
    }
    [self.tableView reloadData];
}
@end
