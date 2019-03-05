//
//  UploadImageViewController.m
//  WYNetWorking
//
//  Created by 吴述雄 on 2019/3/5.
//  Copyright © 2019 Triumen. All rights reserved.
//

#import "UploadImageViewController.h"
#import "WYNetworkManage.h"

@interface UploadImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *beginUpload;

@end

@implementation UploadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)beginUpload:(UIButton *)sender {
    UIImage *image = [UIImage imageNamed:@"123.jpg"];
    [WYNetworkManage uploadImagesWithURL:@"www.abc.com/images/upload" parameters:@{} name:@"image" images:@[image] fileNames:@[@"123"] imageScale:0.5 imageType:@"image/png" progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
@end
