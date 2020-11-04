//
//  StressTestTableViewController.m
//  StressTest
//
//  Created by Ortwin Gentz on 9/26/19.
//  Copyright (c) 2019 Tractable Labs. All rights reserved.
//

/**
 Demonstrates block based data model initializer used to organize a list of sorted
 strings into sections based on the first letter of each string.
 */

#import "StressTestTableViewController.h"

@interface StressTestTableViewController ()
@property (nonatomic) NSInteger selectedItems;
@property (nonatomic) NSArray *items;
@end

@implementation StressTestTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.tableView reloadData];
	self.indexPathController.items = @[];
	self.items = @[@"Jelly Bean",
				   @"Fredricksburg",
				   @"Lorem ipsum",
				   @"dolor sit",
				   @"amet, consectetur",
				   @"adipiscing elit.",
				   @"Donec ut",
				   @"adipiscing massa.",
				   @"Aliquam vitae",
				   @"nibh ac",
				   @"dui lobortis",
				   @"Fredricksburg",
				   @"Jelly Bean",
				   @"George Washington",
				   @"Grand Canyon",
				   @"Bibliography",
				   @"Keyboard Shortcut",
				   @"Metadata",
				   @"Fundamental",
				   @"Cellar Door",
				   @"Lorem ipsum",
				   @"dolor sit",
				   @"amet, consectetur",
				   @"adipiscing elit.",
				   @"Donec ut",
				   @"adipiscing massa.",
				   @"Aliquam vitae",
				   @"nibh ac",
				   @"dui lobortis",
				   @"congue in",
				   @"non dui.",
				   @"Duis hendrerit",
				   @"metus ut",
				   @"neque sodales",
				   @"sodales. Duis",
				   @"a elit",
				   @"nibh. Praesent",
				   @"risus tortor,",
				   @"rutrum ac",
				   @"lobortis in,",
				   @"malesuada ac",
				   @"turpis. Fusce",
				   @"rhoncus adipiscing",
				   @"eleifend. Nulla",
				   @"sed arcu",
				   @"erat. Cras",
				   @"aliquam turpis",
				   @"a purus",
				   @"vestibulum vehicula.",
				   @"Pellentesque at",
				   @"sapien id",
				   @"eros ornare",
				   @"rutrum. Pellentesque",
				   @"habitant morbi",
				   @"tristique senectus",
				   @"et netus"
	];

	self.pauseDuringBatchUpdates = YES;
	[self swap];
	[self.tableView reloadData];
	[self reorder];
	self.tableView.estimatedRowHeight = 44;
}

- (void)swap {
	NSUInteger sectionNumber = arc4random() % 10;
	
	NSMutableArray *usedItems = self.items.mutableCopy;
	NSMutableArray *sections = NSMutableArray.array;
	for (NSUInteger i = 0; i < sectionNumber; i++) {
		NSMutableArray *items = NSMutableArray.array;
		NSUInteger itemNumber = arc4random() % 4;
		for (NSUInteger itemIndex = 0; itemIndex < itemNumber; itemIndex++) {
			NSString *item = usedItems[arc4random() % (usedItems.count - 1)];
			[items addObject:item];
			[usedItems removeObject:item];
		}
		[sections addObject:[[TLIndexPathSectionInfo alloc] initWithItems:items name:[NSString stringWithFormat:@"Section %lu", (long)i]]];
	}
	
	TLIndexPathDataModel *datamodel = [[TLIndexPathDataModel alloc] initWithSectionInfos:sections identifierKeyPath:nil];
	self.indexPathController.dataModel = datamodel;
//	if (self.selectedItems == 2) {
//		self.indexPathController.items = self.items[self.selectedItems];
//	}
//	NSUInteger rows = [self.tableView numberOfRowsInSection:0];
//	NSLog(@"swap: %ld (datasource) %ld (tableView) %ld (visible)", self.indexPathController.items.count, rows, self.tableView.visibleCells.count);
	NSTimeInterval delay = 0.005 * (arc4random() % 50);
	if (delay > 0.15) {
//		[self.tableView reloadData];
		[self swap];
	} else {
		[self performSelector:@selector(swap) withObject:nil afterDelay:0.01 * (arc4random() % 50)];
	}
}

- (void)reorder {
	self.indexPathController.items = [self.indexPathController.items sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	[self performSelector:@selector(reorder) withObject:nil afterDelay:0.001 * (arc4random() % 50)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	cell.textLabel.text = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
	cell.selectionStyle = (arc4random() % 2) == 0 ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
}
		 
		 
//		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
//    return cell;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [self.indexPathController.dataModel sectionNameForSection:section];
//}
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return [self.indexPathController.dataModel sectionNames];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return [self.indexPathController.dataModel sectionForSectionName:title];
//}

@end
