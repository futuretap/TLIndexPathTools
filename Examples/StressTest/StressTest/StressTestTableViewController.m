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
@property (nonatomic) NSArray *titles;
@end

@implementation StressTestTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.tableView reloadData];
	self.indexPathController.items = @[];
	self.items = @[@"Kodiak",
				   @"Cheetah",
				   @"Puma",
				   @"Jaguar",
				   @"Panther",
				   @"Tiger",
				   @"Leopard",
				   @"Snow Leopard",
				   @"Lion",
				   @"Mountain Lion",
				   @"Mavericks",
				   @"Yosemite",
				   @"El Capitan",
				   @"Sierra",
				   @"High Sierra",
				   @"Mojave",
				   @"Catalina",
				   @"Big Sur",
				   @"Pinot",
				   @"Merlot",
				   @"Chardonnay",
				   @"Chablis",
				   @"Barolo",
				   @"Zinfandel",
				   @"Cabernet",
				   @"Syrah",
				   @"Gala",
				   @"Fuji",
				   @"Lobo",
				   @"Liberty"
	];
	self.titles = @[@"Chicago",
					@"New York",
					@"Los Angeles",
					@"San Francisco",
					@"Miami"];
	
	self.pauseDuringBatchUpdates = YES;
	[self swap];
	[self.tableView reloadData];
	self.tableView.estimatedRowHeight = 44;
}

- (void)swap {
	NSUInteger sectionNumber = 1 + arc4random() % 3;
	
	NSMutableArray *usedItems = self.items.mutableCopy;
	NSMutableArray *usedTitles = self.titles.mutableCopy;
	NSMutableArray *sections = NSMutableArray.array;
	for (NSUInteger i = 0; i < sectionNumber; i++) {
		NSMutableArray *items = NSMutableArray.array;
		NSUInteger itemNumber = 1 + arc4random() % 8;
		for (NSUInteger itemIndex = 0; itemIndex < itemNumber; itemIndex++) {
			NSString *item = usedItems[arc4random() % MIN(usedItems.count, 10)];
			[items addObject:item];
			[usedItems removeObject:item];
		}
		NSString *title = usedTitles[arc4random() % usedTitles.count];
		[usedTitles removeObject:title];
		[sections addObject:[[TLIndexPathSectionInfo alloc] initWithItems:items name:title]];
	}
	
	TLIndexPathDataModel *datamodel = [[TLIndexPathDataModel alloc] initWithSectionInfos:sections identifierKeyPath:nil];
	self.indexPathController.dataModel = datamodel;

	NSTimeInterval delay = 0.005 * (double)(arc4random() % 75);
	[self performSelector:@selector(swap) withObject:nil afterDelay:delay];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	cell.textLabel.text = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
	cell.selectionStyle = (arc4random() % 2) == 0 ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
}

@end
