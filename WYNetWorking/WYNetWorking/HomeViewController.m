//
//  HomeViewController.m
//  WYNetWorking
//
//  Created by 吴述雄 on 2019/3/1.
//  Copyright © 2019 Triumen. All rights reserved.
//

#import "HomeViewController.h"
#import "RequestViewController.h"
#import "DownVideoViewController.h"
#import "UploadImageViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"GET请求",@"POST请求",@"文件下载"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RequestViewController *ctrl = [[RequestViewController alloc] initWithHttpType:@"GET"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if (indexPath.row == 1) {
        RequestViewController *ctrl = [[RequestViewController alloc] initWithHttpType:@"POST"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
//    else if (indexPath.row == 2) {
//        UploadImageViewController *ctrl = [[UploadImageViewController alloc] init];
//        [self.navigationController pushViewController:ctrl animated:YES];
//    }
    else if (indexPath.row == 2) {
        DownVideoViewController *ctrl = [[DownVideoViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
    
@end
