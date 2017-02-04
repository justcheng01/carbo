//
//  NotificationDetailVC.h
//  CarBo
//
//  Created by Shirish Vispute on 31/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDetailVC : UIViewController
{

}
@property (strong,nonatomic)IBOutlet UILabel *notificationlabel;
@property (strong, nonatomic) IBOutlet UILabel *label_notification;

@property (strong,nonatomic) NSString *notificationlabelA;
@property (strong,nonatomic) NSString *notificationDAteA;

@property (strong,nonatomic)IBOutlet UILabel *notificationDAte;
@property(strong,nonatomic) IBOutlet UIButton *OkBtn;
- (IBAction)OKButtonClicked:(id)sender;

@end
