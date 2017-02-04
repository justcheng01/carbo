//
//  notificationListVC.h
//  CarBo
//
//  Created by Shirish Vispute on 05/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notificationListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *notificationlist;
    
    NSMutableArray *arr_createDate;
    
    NSMutableArray *arr_msg;
}
@property(nonatomic,strong)IBOutlet UITableView *notificationtableview;

@end
