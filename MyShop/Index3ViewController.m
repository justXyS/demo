//
//  Index3ViewController.m
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Index3ViewController.h"
#import "Index2_cell.h"
#import "Index3_cell.h"
#import "MyOrderViewController.h"

@interface Index3ViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray * titles;
@property (nonatomic,copy) NSString *headPath;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *erea;
@end

@implementation Index3ViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    self.images = [NSMutableArray arrayWithArray:@[@"buy.jpg",@"rob.jpg",@"team_buy.jpg",@"buy.jpg",@"buy.jpg",@"rob.jpg"]];
    self.titles = [NSMutableArray arrayWithArray:@[@"我的订单",@"我的钱包",@"联系我们",@"快递查询",@"水电缴费",@"爱上"]];
    self.nickName = @"150****1314";
    self.headPath = @"exchange.jpg";
    self.erea = @"乔庄生活馆";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return section==0?1:6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        Index3_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Index3_cell_2" forIndexPath:indexPath];
        cell.headImageView.image = [UIImage imageNamed:self.headPath];
        cell.ereaLable.text = self.erea;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.nickNameLable.text = self.nickName;
        return cell;
    }else{
        Index2_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Index3_cell_1" forIndexPath:indexPath];
        cell.titleLable.text = self.titles[indexPath.row];
        cell.imageTitle.image = [UIImage imageNamed:self.images[indexPath.row]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self actionForRow:indexPath.row+indexPath.section*1];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==0?80:60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

#pragma mark - Navigation
-(void)actionForRow:(NSInteger)row{
    NSString *storyboardIdentifier;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller;
    switch (row) {
        case 0:
            [self showAction];
            return;
        case 1:
            storyboardIdentifier = @"myOrder";
            controller = [storyboard instantiateViewControllerWithIdentifier:storyboardIdentifier];
            break;
        case 2:
            storyboardIdentifier = @"myWalletViewController";
            controller = [storyboard instantiateViewControllerWithIdentifier:storyboardIdentifier];
            break;
        case 3:
            [self callOurs];
            return;
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 弹出拨打电话提示框
-(void)callOurs{
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"免费客服电话:400-0909-516" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打",nil] show];
}

#pragma mark - 换头像
-(void)showAction{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    if(buttonIndex==1){
        imagePick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePick.allowsEditing = YES;
        imagePick.delegate = self;
        [self presentViewController:imagePick animated:YES completion:^{}];
   }else if(buttonIndex==0){
       if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
           imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
           imagePick.allowsEditing = YES;
           [self presentViewController:imagePick animated:YES completion:^{}];
       }else{
           NSLog(@"no camera");
       }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *path = info[UIImagePickerControllerMediaURL];
    if (path) {
        self.headPath = path;
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerEditedImage];
        NSLog(@"%@",image);
        [self.tableView reloadData];
    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4000909516"]];
    }
}

@end
