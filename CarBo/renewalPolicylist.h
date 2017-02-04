//
//  renewalPolicylist.h
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "renewalCell.h"

@interface renewalPolicylist : UIViewController<UITableViewDelegate,UITableViewDataSource,RenewalDelegate>
{
    UITableView *renewaltableview;
}
@end
