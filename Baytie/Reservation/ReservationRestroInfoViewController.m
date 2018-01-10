//
//  ReservationRestroInfoViewController.m
//  Baytie
//
//  Created by stepanekdavid on 1/11/17.
//  Copyright © 2017 Lovisa. All rights reserved.
//

#import "ReservationRestroInfoViewController.h"
#import "MainMenuViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ReviewsOfUserCell.h"
@interface ReservationRestroInfoViewController (){
    NSMutableArray *reviewsOfUser;
}

@end

@implementation ReservationRestroInfoViewController
@synthesize restroDetails;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    reviewsView.hidden = YES;
    reviewsOfUser = [[NSMutableArray alloc] init];
    lblRestroName.text = [restroDetails objectForKey:@"restro_name"];
    if (![[restroDetails objectForKey:@"restro_logo"] isKindOfClass:[NSNull class]])
    {
        NSArray *arrForUrl = [[restroDetails objectForKey:@"restro_logo"] componentsSeparatedByString:@"/"];
        NSString *logoUrl = [NSString stringWithFormat:@"http://82.223.68.80/%@/%@", arrForUrl[arrForUrl.count-2], arrForUrl[arrForUrl.count-1]];
        [restroProfileImage setImageWithURL:[NSURL URLWithString:logoUrl]];
    }
    
    lblRestroDetails.text = [restroDetails objectForKey:@"restro_description"];
    
    
    featuredImage.hidden = YES;
    if ([restroDetails objectForKey:@"cuisines"]) {
        NSString *allCuines = @"";
        for (NSDictionary *dc in [restroDetails objectForKey:@"cuisines"]) {
            if ([allCuines isEqualToString:@""]) {
                allCuines = [dc objectForKey:@"name"];
            }else{
                allCuines = [NSString stringWithFormat:@"%@, %@", allCuines, [dc objectForKey:@"name"]];
            }
        }
        lblCuisines.text = allCuines;
    }
    if([[restroDetails objectForKey:@"assign_featured"] integerValue] == 1){
        featuredImage.hidden = NO;
    }
    promoImage.hidden = YES;
    if ([[restroDetails objectForKey:@"promo_id"] isKindOfClass:[NSNull class]]) {
        promoImage.hidden = YES;
    }else if ([[restroDetails objectForKey:@"promo_id"] integerValue] > 0){
        promoImage.hidden = NO;
    }
    
    if ([restroDetails objectForKey:@"busy"] && [[restroDetails objectForKey:@"busy"] integerValue] == 1) {
        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_red.png"]];
        lblRestroStatus.text = @"Busy";
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mmaa"];
        NSInteger fromTime = 0;
        NSInteger toTime = 0;
        NSInteger currentTime = 0;
        switch (APPDELEGATE.dayType) {
            case 1:
                if (![[restroDetails objectForKey:@"sunday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"sunday_to"] isKindOfClass:[NSNull class]]) {
                    fromTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_from"]]];
                    toTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_to"]]];
                    currentTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:APPDELEGATE.currentTime]];
                    if (currentTime > fromTime && currentTime < toTime) {
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_green.png"]];
                        lblRestroStatus.text = @"Open";
                    }else{
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                        lblRestroStatus.text = @"Close";
                    }
                }else{
                    [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                    lblRestroStatus.text = @"Close";
                }
                break;
            case 2:
                if (![[restroDetails objectForKey:@"monday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"monday_to"] isKindOfClass:[NSNull class]]) {
                    fromTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_from"]]];
                    toTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_to"]]];
                    currentTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:APPDELEGATE.currentTime]];
                    if (currentTime > fromTime && currentTime < toTime) {
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_green.png"]];
                        lblRestroStatus.text = @"Open";
                    }else{
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                        lblRestroStatus.text = @"Close";
                    }
                }else{
                    [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                    lblRestroStatus.text = @"Close";
                }
                break;
            case 3:
                if (![[restroDetails objectForKey:@"tuesday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"tuesday_to"] isKindOfClass:[NSNull class]]) {
                    fromTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_from"]]];
                    toTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_to"]]];
                    currentTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:APPDELEGATE.currentTime]];
                    if (currentTime > fromTime && currentTime < toTime) {
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_green.png"]];
                        lblRestroStatus.text = @"Open";
                    }else{
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                        lblRestroStatus.text = @"Close";
                    }
                }else{
                    [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                    lblRestroStatus.text = @"Close";
                }
                break;
            case 4:
                if (![[restroDetails objectForKey:@"wednesday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"wednesday_to"] isKindOfClass:[NSNull class]]) {
                    fromTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_from"]]];
                    toTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_to"]]];
                    currentTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:APPDELEGATE.currentTime]];
                    if (currentTime > fromTime && currentTime < toTime) {
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_green.png"]];
                        lblRestroStatus.text = @"Open";
                    }else{
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                        lblRestroStatus.text = @"Close";
                    }
                }else{
                    [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                    lblRestroStatus.text = @"Close";
                }
                break;
            case 5:
                if (![[restroDetails objectForKey:@"thursday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"thursday_to"] isKindOfClass:[NSNull class]]) {
                    fromTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_from"]]];
                    toTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_to"]]];
                    currentTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:APPDELEGATE.currentTime]];
                    if (currentTime > fromTime && currentTime < toTime) {
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_green.png"]];
                        lblRestroStatus.text = @"Open";
                    }else{
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                        lblRestroStatus.text = @"Close";
                    }
                }else{
                    [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                    lblRestroStatus.text = @"Close";
                }
                break;
            case 6:
                if (![[restroDetails objectForKey:@"friday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"friday_to"] isKindOfClass:[NSNull class]]) {
                    fromTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_from"]]];
                    toTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_to"]]];
                    currentTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:APPDELEGATE.currentTime]];
                    if (currentTime > fromTime && currentTime < toTime) {
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_green.png"]];
                        lblRestroStatus.text = @"Open";
                    }else{
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                        lblRestroStatus.text = @"Close";
                    }
                }else{
                    [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                    lblRestroStatus.text = @"Close";
                }
                break;
            case 7:
                if (![[restroDetails objectForKey:@"saturday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"saturday_to"] isKindOfClass:[NSNull class]]) {
                    fromTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_from"]]];
                    toTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:[restroDetails objectForKey:@"sunday_to"]]];
                    currentTime = [APPDELEGATE secondOfTheDay:[formatter dateFromString:APPDELEGATE.currentTime]];
                    if (currentTime > fromTime && currentTime < toTime) {
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_green.png"]];
                        lblRestroStatus.text = @"Open";
                    }else{
                        [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                        lblRestroStatus.text = @"Close";
                    }
                }else{
                    [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                    lblRestroStatus.text = @"Close";
                }
                break;
                
            default:
                [restroStatusImage setImage:[UIImage imageNamed:@"status_open_black.png"]];
                lblRestroStatus.text = @"Close";
                break;
        }
    }
    
    paymentDimage.hidden = YES;
    paymentCimage.hidden = YES;
    paymentKimage.hidden = YES;
    if (![[restroDetails objectForKey:@"payment_method"] isKindOfClass:[NSNull class]]) {
        NSArray *paymentParsArray = [[restroDetails objectForKey:@"payment_method"] componentsSeparatedByString:@","];
        switch ([paymentParsArray count]) {
            case 1:
                paymentDimage.hidden = NO;
                [paymentDimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[0]]]];
                break;
            case 2:
                paymentDimage.hidden = NO;
                [paymentDimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[0]]]];
                if ([paymentParsArray[1] integerValue] !=4) {
                    paymentCimage.hidden = NO;
                    [paymentCimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[1]]]];
                }
                break;
            case 3:
                paymentDimage.hidden = NO;
                [paymentDimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[0]]]];
                paymentCimage.hidden = NO;
                [paymentCimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[1]]]];
                if ([paymentParsArray[2] integerValue] !=4) {
                    paymentKimage.hidden = NO;
                    [paymentKimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[2]]]];
                }
                break;
            case 4:
                paymentDimage.hidden = NO;
                [paymentDimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[0]]]];
                paymentCimage.hidden = NO;
                [paymentCimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[1]]]];
                if ([paymentParsArray[2] integerValue] !=4) {
                    paymentKimage.hidden = NO;
                    [paymentKimage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"payment_%@_img.png",paymentParsArray[2]]]];
                }
                break;
                
            default:
                paymentCimage.hidden = YES;
                paymentKimage.hidden = YES;
                paymentDimage.hidden = YES;
                break;
        }
    }
    switch (APPDELEGATE.dayType) {
        case 1:
            if (![[restroDetails objectForKey:@"sunday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"sunday_to"] isKindOfClass:[NSNull class]]) {
                lblWorkingTime.text = [NSString stringWithFormat:@"%@ - %@", [restroDetails objectForKey:@"sunday_from"],[restroDetails objectForKey:@"sunday_to"]];
            }
            break;
        case 2:
            if (![[restroDetails objectForKey:@"monday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"monday_to"] isKindOfClass:[NSNull class]]) {
                lblWorkingTime.text = [NSString stringWithFormat:@"%@ - %@", [restroDetails objectForKey:@"monday_from"],[restroDetails objectForKey:@"monday_to"]];
            }
            break;
        case 3:
            if (![[restroDetails objectForKey:@"tuesday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"tuesday_to"] isKindOfClass:[NSNull class]]) {
                lblWorkingTime.text = [NSString stringWithFormat:@"%@ - %@", [restroDetails objectForKey:@"tuesday_from"],[restroDetails objectForKey:@"tuesday_to"]];
            }
            break;
        case 4:
            if (![[restroDetails objectForKey:@"wednesday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"wednesday_to"] isKindOfClass:[NSNull class]]) {
                lblWorkingTime.text = [NSString stringWithFormat:@"%@ - %@", [restroDetails objectForKey:@"wednesday_from"],[restroDetails objectForKey:@"wednesday_to"]];
            }
            break;
        case 5:
            if (![[restroDetails objectForKey:@"thursday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"thursday_to"] isKindOfClass:[NSNull class]]) {
                lblWorkingTime.text = [NSString stringWithFormat:@"%@ - %@", [restroDetails objectForKey:@"thursday_from"],[restroDetails objectForKey:@"thursday_to"]];
            }
            break;
        case 6:
            if (![[restroDetails objectForKey:@"friday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"friday_to"] isKindOfClass:[NSNull class]]) {
                lblWorkingTime.text = [NSString stringWithFormat:@"%@ - %@", [restroDetails objectForKey:@"friday_from"],[restroDetails objectForKey:@"friday_to"]];
            }
            break;
        case 7:
            if (![[restroDetails objectForKey:@"saturday_from"] isKindOfClass:[NSNull class]] && ![[restroDetails objectForKey:@"saturday_to"] isKindOfClass:[NSNull class]]) {
                lblWorkingTime.text = [NSString stringWithFormat:@"%@ - %@", [restroDetails objectForKey:@"saturday_from"],[restroDetails objectForKey:@"saturday_to"]];
            }
            break;
            
        default:
            lblWorkingTime.text = [NSString stringWithFormat:@"%@ - %@", @"E",@"E"];
            break;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar addSubview:navView];
    [self getReviews];
}
- (void)getReviews{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    void ( ^successed )( id _responseObject ) = ^( id _responseObject )
    {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([[_responseObject objectForKey:@"code"] integerValue] == 0) {
            lblReviewsCounts.text = [NSString stringWithFormat:@"%lu reviews", [[_responseObject objectForKey:@"resource"] count]];
            reviewsOfUser = [_responseObject objectForKey:@"resource"];
            NSInteger sumStarValue = 0;
            for (NSDictionary *dict in reviewsOfUser) {
                sumStarValue = sumStarValue + [[dict objectForKey:@"star_value"] integerValue];
            }
            
            switch ((int)roundf(sumStarValue/[reviewsOfUser count])) {
                case 0:
                    [star1 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star2 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star3 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star4 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star5 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    break;
                case 1:
                    [star1 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star2 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star3 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star4 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star5 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    break;
                case 2:
                    [star1 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star2 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star3 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star4 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star5 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    break;
                case 3:
                    [star1 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star2 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star3 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star4 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    [star5 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    break;
                case 4:
                    [star1 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star2 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star3 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star4 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star5 setImage:[UIImage imageNamed:@"blank_star.png"]];
                    break;
                case 5:
                    [star1 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star2 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star3 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star4 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    [star5 setImage:[UIImage imageNamed:@"fill_star.png"]];
                    break;
                default:
                    break;
            }
            
            [reviewsTableView reloadData];
        }
    };
    
    void ( ^failure )( NSError* _error ) = ^( NSError* _error )
    {
        
        [ MBProgressHUD hideHUDForView : self.view animated : YES ] ;
        [ self  showAlert: @"No Internet Connection." :@"Oops!"] ;
        
    } ;
    
    [[Communication sharedManager] GetRestaurantsRating:APPDELEGATE.access_token locationId:[[restroDetails objectForKey:@"location_id"] integerValue] restroId:[[restroDetails objectForKey:@"restro_id"] integerValue] successed:successed failure:failure];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [navView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [reviewsOfUser count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"ReviewOfUserItem";
    ReviewsOfUserCell *cell = (ReviewsOfUserCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSDictionary *dict = [reviewsOfUser objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [ReviewsOfUserCell sharedCell];
    }
    [cell setReviewsItem:dict];
    cell.lblUserName.text = [dict objectForKey:@"user_name"];
    cell.lblMsg.text = [dict objectForKey:@"msg"];
    [cell.ratingImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"rating_%@.png",[dict objectForKey:@"star_value"]]]];
    return cell;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:NO];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:NO];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)showAlert:(NSString*)msg :(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
- (IBAction)onMenu:(id)sender {
    MainMenuViewController *viewcontroller = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onReviewsChecking:(id)sender {
    reviewsView.hidden = NO;
}

- (IBAction)onCloseReviewview:(id)sender {
    reviewsView.hidden = YES;
}

- (IBAction)onFoodMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
