//
//  Index1ViewController.m
//  E小区
//
//  Created by apple on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Index1ViewController.h"
#import "Index0_cell_1.h"
#import "Index1_cell_2.h"
#import "ViewStyle.h"
#import "Index1_cell_3.h"
#import "KeyBroad.h"

@interface Index1ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *adImages;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,strong)NSMutableArray *cell_3_phoneNumbers;
@property (nonatomic,strong)NSMutableArray *cell_3_phoneTimers;
@property (nonatomic,strong)NSMutableArray *cell_3_phoneTimes;
@property (nonatomic,strong)UIButton *callView;
@property (nonatomic,strong)UIDynamicAnimator *dynamicAnimator;
@property (nonatomic,strong)UIGravityBehavior *gravityBehavior;
@property (nonatomic,strong)UICollisionBehavior *collsionBehavior;
@property (nonatomic,strong)UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic,strong)UIView *backview;
@end

@implementation Index1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.backview];
    //KeyBroad *keyBroad = [[KeyBroad alloc] initWithFrame:CGRectMake(0,K_SCREEN_BOUNDS_SIZE.height-200-80, K_SCREEN_BOUNDS_SIZE.width, 200)];
    //[self.view addSubview:keyBroad];
    // Do any additional setup after loading the view.
}

-(UIGravityBehavior *)gravityBehavior{
    if(!_gravityBehavior){
        _gravityBehavior = [[UIGravityBehavior alloc] init];
        _gravityBehavior.magnitude = 0.8;
        [self.dynamicAnimator addBehavior:_gravityBehavior];
    }
    return _gravityBehavior;
}

-(UICollisionBehavior *)collsionBehavior{
    if(!_collsionBehavior){
        _collsionBehavior = [[UICollisionBehavior alloc] init];
        _collsionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        [self.dynamicAnimator addBehavior:_collsionBehavior];
    }
    return _collsionBehavior;
}

-(UIDynamicAnimator *)dynamicAnimator{
    if(!_dynamicAnimator){
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.backview];
    }
    return _dynamicAnimator;
}

-(UIButton *)callView{
    if(!_callView){
        _callView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_callView setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
    }
    return _callView;
}

-(UIView *)backview{
    if(!_backview){
        CGRect frame = self.view.frame;
        frame.size.width = frame.size.width/2;
        frame.size.height = frame.size.height-55*2;
        _backview = [[UIView alloc]initWithFrame:frame];
        _backview.backgroundColor = [UIColor clearColor];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        //pan.delegate = self;
        [_backview addGestureRecognizer:pan];
    }
    return _backview;
}

-(void)pan:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.backview];
    if(sender.state==UIGestureRecognizerStateBegan){
        [self attachmentCallView:point];
    }else if(sender.state==UIGestureRecognizerStateChanged){
        self.attachmentBehavior.anchorPoint = point;
    }else if(sender.state==UIGestureRecognizerStateEnded){
        [self.dynamicAnimator removeBehavior:self.attachmentBehavior];
    }
}

-(void)attachmentCallView:(CGPoint)point{
    _attachmentBehavior = [[UIAttachmentBehavior alloc]initWithItem:self.callView attachedToAnchor:point];
    self.attachmentBehavior.anchorPoint = point;
    [self.dynamicAnimator addBehavior:self.attachmentBehavior];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.gravityBehavior removeItem:self.callView];
    [self.collsionBehavior removeItem:self.callView];
    [self.callView removeFromSuperview];
    self.callView = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.backview addSubview:self.callView];
    [self.gravityBehavior addItem:self.callView];
    [self.collsionBehavior addItem:self.callView];
    _adImages = [NSMutableArray arrayWithArray:@[@"http://f.hiphotos.baidu.com/image/pic/item/b90e7bec54e736d1c2ae2b0899504fc2d5626975.jpg",@"http://b.hiphotos.baidu.com/image/h%3D200/sign=a9221bd39c3df8dcb93d8891fd1072bf/78310a55b319ebc46ea863bd8126cffc1f1716c5.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/50da81cb39dbb6fdeab1f0020a24ab18972b372f.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/024f78f0f736afc3aca32a41b019ebc4b7451262.jpg"]];
    _time = @"37分钟";
    _cell_3_phoneNumbers = [NSMutableArray arrayWithArray:@[@"13574883233",@"15084989009",@"15073151015",@"13135372814",@"13016155554",@"13617375922"]];
    _cell_3_phoneTimers = [NSMutableArray arrayWithArray:@[@"1分钟",@"2分钟",@"3分钟",@"3分钟",@"12分钟",@"50分钟"]];
    _cell_3_phoneTimes = [NSMutableArray arrayWithArray:@[@"2014-02-02",@"2014-08-02",@"2014-02-14",@"2014-02-12",@"2014-13-22",@"2014-02-23"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview 数据源和委托
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cell_3_phoneTimers.count+2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if(row==0){
        Index0_cell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"index1_cell_1" forIndexPath:indexPath];
        [cell setUrls:_adImages AndTimer:4 isAuto:YES placeholderImage:nil animationType:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if(row == 1){
        Index1_cell_2 *cell = [tableView dequeueReusableCellWithIdentifier:@"Index1_cell_2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setTimeLable:_time];
        [ViewStyle addRadius:cell.qd];
        return cell;
    }else{
        Index1_cell_3 *cell = [tableView dequeueReusableCellWithIdentifier:@"Index1_cell_3" forIndexPath:indexPath];
        cell.phoneNumber.text = _cell_3_phoneNumbers[row-2];
        cell.callTimer.text = _cell_3_phoneTimers[row-2];
        cell.callTime.text = _cell_3_phoneTimes[row-2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if(row==0){
        return 100;
    }else if(row==1){
        return 60;
    }else{
        return 50;
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
