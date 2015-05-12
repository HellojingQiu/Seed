//
//  FriendListViewController.m
//  
//
//  Created by OliHire-HellowJingQiu on 15/5/12.
//
//

#import "FriendListViewController.h"
#import "AIMTableViewIndexBar.h"
#import "ChineseString.h"

@interface FriendListViewController ()<AIMTableViewIndexBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableViewController *tableViewController;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) NSMutableArray *sortedArrayForArrays;
@property (strong,nonatomic) NSMutableArray *sectionHeaderKeys;

@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    _sortedArrayForArrays = [NSMutableArray array];
    _sectionHeaderKeys = [NSMutableArray array];
    
    [self reloadData];
    
    AIMTableViewIndexBar *indexBar = [[AIMTableViewIndexBar alloc]initWithFrame:CGRectMake(__ScreenSize.width-15, 44+20, 15, __ScreenSize.height-49-64)];
    self.tableViewController = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    _tableViewController.tableView.delegate = self;
    _tableViewController.tableView.dataSource = self;
    
    
    
    
    [self.view addSubview:indexBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData{
    [_dataArray addObject:@"郭靖"];
    [_dataArray addObject:@"黄蓉"];
    [_dataArray addObject:@"杨过"];
    [_dataArray addObject:@"苗若兰"];
    [_dataArray addObject:@"令狐冲"];
    [_dataArray addObject:@"小龙女"];
    [_dataArray addObject:@"胡斐"];
    [_dataArray addObject:@"水笙"];
    [_dataArray addObject:@"任盈盈"];
    [_dataArray addObject:@"白琇"];
    [_dataArray addObject:@"狄云"];
    [_dataArray addObject:@"石破天"];
    [_dataArray addObject:@"殷素素"];
    [_dataArray addObject:@"张翠山"];
    [_dataArray addObject:@"张无忌"];
    [_dataArray addObject:@"青青"];
    [_dataArray addObject:@"袁冠南"];
    [_dataArray addObject:@"萧中慧"];
    [_dataArray addObject:@"袁承志"];
    [_dataArray addObject:@"乔峰"];
    [_dataArray addObject:@"王语嫣"];
    [_dataArray addObject:@"段玉"];
    [_dataArray addObject:@"虚竹"];
    [_dataArray addObject:@"苏星河"];
    [_dataArray addObject:@"丁春秋"];
    [_dataArray addObject:@"庄聚贤"];
    [_dataArray addObject:@"阿紫"];
    [_dataArray addObject:@"阿朱"];
    [_dataArray addObject:@"阿碧"];
    [_dataArray addObject:@"鸠魔智"];
    [_dataArray addObject:@"萧远山"];
    [_dataArray addObject:@"慕容复"];
    [_dataArray addObject:@"慕容博"];
    [_dataArray addObject:@"Jim"];
    [_dataArray addObject:@"Lily"];
    [_dataArray addObject:@"Ethan"];
    [_dataArray addObject:@"Green小"];
    [_dataArray addObject:@"Green大"];
    [_dataArray addObject:@"DavidSmall"];
    [_dataArray addObject:@"DavidBig"];
    [_dataArray addObject:@"James"];
    [_dataArray addObject:@"Kobe Brand"];
    [_dataArray addObject:@"Kobe Crand"];
    
    self.sortedArrayForArrays = [self getChineseStringArray:_dataArray];
}

#pragma mark - Sort Function

-(NSMutableArray *)getChineseStringArray:(NSMutableArray *)arrayToSort{
    NSMutableArray *chineseStringArray = [NSMutableArray array];
    for (int i =0 ; i <[arrayToSort count]; i++) {
        //Create ChineseString Object
        ChineseString *chineseString = [[ChineseString alloc]init];
        chineseString.string = arrayToSort[i];
        
        if (chineseString.string == nil) {
            chineseString.string = @"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            //Append the pinyin char
            NSMutableString *strPinYin = [NSMutableString string];
            for (int j=0; j<chineseString.string.length; j++) {
//                judgement the name's pronounce
                NSString *singlePinYinLetter = [NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])].uppercaseString;
                
                [strPinYin appendString:singlePinYinLetter];
            }
            chineseString.pinyin = strPinYin;
        }else{
            chineseString.pinyin = @"";
        }
        [chineseStringArray addObject:chineseString];
    }
    //Sorting Algorithm
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    [chineseStringArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex = NO;//flag tocheck
    NSMutableArray *tempArrayForGroping = nil;
    
    for (int index = 0; index < [chineseStringArray count]; index++) {
        //Chinese String Object
        ChineseString *chineseStr = [chineseStringArray objectAtIndex:index];
        //ChineseString.pinyin
        NSMutableString *strchar = [NSMutableString stringWithString:chineseStr.pinyin];
        //pinyin's first char
        NSString *sr = [strchar substringToIndex:1];//this is the first character of each string
        
        //Check the first char whether join the array,if not yet add and markbool out(NO) of check
        if (![_sectionHeaderKeys containsObject:[sr uppercaseString]]) {
            [_sectionHeaderKeys addObject:sr.uppercaseString];
            tempArrayForGroping = [NSMutableArray array];
            checkValueAtIndex = NO;
        }
        //check again,if added the array,check the string index char,it used to check the word whether join the array
        if ([_sectionHeaderKeys containsObject:[sr uppercaseString]]) {
            //add the string index char in the temp array
            [tempArrayForGroping addObject:[chineseStringArray objectAtIndex:index]];
            //if the char pass the check,add to the array,and markbool in(YES) of check
            if (checkValueAtIndex == NO) {
                [arrayForArrays addObject:tempArrayForGroping];
                checkValueAtIndex = YES;
            }
        }
    }
    return arrayForArrays;
}

#pragma mark - AIMTableViewIndexBarDelegate

-(void)tableViewIndexBar:(AIMTableViewIndexBar *)indexBar didSelectSectionAtIndex:(NSInteger)index{
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  [self.sortedArrayForArrays count]+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 2 : [self.sortedArrayForArrays[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"FriendListCell";
    static NSString *cellTop = @"TopCell";
    
    UITableViewCell *cell = nil;
    indexPath.section == 0 ? [tableView dequeueReusableCellWithIdentifier:cellTop] : [tableView dequeueReusableCellWithIdentifier:cellTop];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
