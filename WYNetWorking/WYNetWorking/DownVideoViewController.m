//
//  DownVideoViewController.m
//  WYNetWorking
//
//  Created by 吴述雄 on 2019/3/1.
//  Copyright © 2019 Triumen. All rights reserved.
//

#import "DownVideoViewController.h"
#import "WYNetworkManage.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

static NSString *const downloadUrl = @"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4";

@interface DownVideoViewController ()
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *down;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController *PlayerVC;
    
@end

@implementation DownVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
    
- (IBAction)down:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitle:@"取消下载" forState:UIControlStateNormal];
        [WYNetworkManage downloadWithURL:downloadUrl fileDir:@"video" progress:^(NSProgress * _Nonnull progress) {
            CGFloat stauts = 100.f * progress.completedUnitCount / progress.totalUnitCount;
            self.slider.value = stauts / 100.f;
            
            NSLog(@"下载进度 :%.2f%%,,%@",stauts,[NSThread currentThread]);
            self.slider.value = stauts / 100.f;
        } success:^(NSString * _Nonnull filePath) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"下载完成，即将开始播放视频" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
            self.PlayerVC.player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithAsset:[AVAsset assetWithURL:[NSURL URLWithString:filePath]]]];
            [self.PlayerVC.player play];
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }else{
        self.slider.value = 0.f;
        [WYNetworkManage cancelRequestWithURL:downloadUrl];
        [sender setTitle:@"开始下载" forState:UIControlStateNormal];
    }
}

-(AVPlayerViewController *)PlayerVC {
    if (!_PlayerVC) {
        _PlayerVC = [[AVPlayerViewController alloc] init];
        NSURL * url = [NSURL URLWithString:@"http://v.cctv.com/flash/mp4video6/TMS/2011/01/05/cf752b1c12ce452b3040cab2f90bc265_h264818000nero_aac32-1.mp4"];
        _PlayerVC.player = [AVPlayer playerWithURL:url];
        _PlayerVC.view.frame = self.playerView.bounds;
        _PlayerVC.player.volume = 1.f;
        _PlayerVC.showsPlaybackControls = YES;
        [self.playerView addSubview:_PlayerVC.view];
    }
    return _PlayerVC;
}

@end
