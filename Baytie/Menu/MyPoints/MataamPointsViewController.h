//
//  MataamPointsViewController.h
//  Baytie
//
//  Created by stepanekdavid on 9/27/16.
//  Copyright © 2016 Lovisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MataamPointsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{

    __weak IBOutlet UITableView *mataamPointsTableView;
}

- (IBAction)onBackMenu:(id)sender;
@end
