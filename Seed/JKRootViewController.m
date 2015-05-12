//
//  JKRootViewController.m
//  Seed
//
//  Created by OliHire-HellowJingQiu on 15/5/11.
//  Copyright (c) 2015年 OliHire-JokerV. All rights reserved.
//

#import "JKRootViewController.h"
#import "ViewController.h"
#import "UIImage-Helpers.h"

@interface JKRootViewController (){
    NSInteger _tabIndex;
}
@property (assign,nonatomic) CGRect screenSize;
@property (weak,nonatomic) UIStoryboard *storyBoard;
@end

@implementation JKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    self.selectedIndex = 2;
    
//    ViewController *vc = [[ViewController alloc]init];
//    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:vc];
//    self.viewControllers = [NSArray arrayWithObject:nv];
    
    self.screenSize = [UIScreen mainScreen].bounds;
    
    //Custom Tabbar
    self.slideBg = [self createCustomTabbarWithFrame:CGRectMake(0, _screenSize.size.height-self.tabBar.bounds.size.height, _screenSize.size.width, self.tabBar.bounds.size.height)];
    
    //Tabbar image array
    NSArray *arrayImageName = @[@"img_main_message",@"img_main_friendlist",@"img_main_theworld",@"img_main_prop",@"img_main_pollen"];
    self.arrayButtons = [self createTabBarItemWithImageArray:arrayImageName];
    
    [self.view addSubview:self.slideBg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma init custom tabbar

-(UIImageView *)createCustomTabbarWithFrame:(CGRect)frame{
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:frame];
    
    bgView.backgroundColor = [UIColor colorWithRed:33.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1];
    bgView.userInteractionEnabled = YES;
    return bgView;
}

-(NSArray *)createTabBarItemWithImageArray:(NSArray *)images{
    NSInteger viewCount = images.count >5 ? 5:images.count;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:viewCount];
    double _width = _screenSize.size.width/(double)viewCount;
    
    for (int i=0; i<viewCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //UIView Frame
        UIView *tabBarItemView = [[UIView alloc]initWithFrame:CGRectMake(i*_width, 0, _width, _slideBg.bounds.size.height)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedTab:)];
        //Button Frame
        btn.frame = CGRectMake(0, 0, 24, 24);
        btn.center = tabBarItemView.center;
        
        
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        btn.tintColor = (i == 2) ? [UIColor whiteColor] :[UIColor lightGrayColor];
        
        tabBarItemView.backgroundColor = [UIColor clearColor];
        tabBarItemView.userInteractionEnabled = YES;
        tabBarItemView.gestureRecognizers = [NSArray arrayWithObject:tapGesture];
        
        btn.tag = 1011+i;
        tabBarItemView.tag = 1021+i;
        
//        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
        [array addObject:btn];
        [self.slideBg addSubview:btn];
        [self.slideBg addSubview:tabBarItemView];
    }
    return array;
}


-(void)selectedTab:(id)sender{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UIView *view = [(UITapGestureRecognizer *)sender view];
        _tabIndex = view.tag-1021;//1021-1025
        self.selectedIndex = _tabIndex;
        for (UIButton *btn in _arrayButtons) {
            btn.tag-1011 == _tabIndex ? (btn.tintColor = [UIColor whiteColor]) :(btn.tintColor = [UIColor lightGrayColor]);
        }
        
    }
}

#pragma mark - three method


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
