//
//  RequestViewController.m
//  WYNetWorking
//
//  Created by 吴述雄 on 2019/3/1.
//  Copyright © 2019 Triumen. All rights reserved.
//

#import "RequestViewController.h"
#import "WYNetworkManage.h"
static NSString *const httpUrl = @"http://api.budejie.com/api/api_open.php";
static NSString *const url = @"http://10.8.1.141:12306/assetApp/login?username=Airfei&password=123456";

@interface RequestViewController ()
@property (weak, nonatomic) IBOutlet UITextView *realTimeData;
@property (weak, nonatomic) IBOutlet UITextView *cacheData;
@property (weak, nonatomic) IBOutlet UISwitch *open;
@property (nonatomic, copy) NSString *httpType;
@end

@implementation RequestViewController

- (instancetype)initWithHttpType:(NSString *)httpType
{
    self = [super init];
    if (self) {
        self.httpType = httpType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendRequest];
}

- (void)sendRequest {
    self.realTimeData.text = @"";
    self.cacheData.text = @"";
    [WYNetworkManage setResponseSerializer:WYResponseSerializerJSON];
     NSDictionary *para = @{ @"a":@"list", @"c":@"data",@"client":@"iphone",@"page":@"0",@"per":@"10", @"type":@"29"};
    if ([self.httpType isEqualToString:@"GET"]) {
        if (self.open.on) {
            [WYNetworkManage GET:httpUrl parameters:para responseCache:^(id  _Nonnull responseCache) {
                self.cacheData.text = [self jsonToString:responseCache];
            } success:^(id  _Nonnull responseObject) {
                self.realTimeData.text = [self jsonToString:responseObject];
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }else{
            [WYNetworkManage GET:httpUrl parameters:para success:^(id  _Nonnull responseObject) {
                self.realTimeData.text = [self jsonToString:responseObject];
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }
    }else {
        if (self.open.on) {
            [WYNetworkManage POST:httpUrl parameters:para responseCache:^(id  _Nonnull responseCache) {
                self.cacheData.text = [self jsonToString:responseCache];
            } success:^(id  _Nonnull responseObject) {
                self.realTimeData.text = [self jsonToString:responseObject];
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }else{
            [WYNetworkManage POST:httpUrl parameters:para success:^(id  _Nonnull responseObject) {
                self.realTimeData.text = [self jsonToString:responseObject];
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }
    }
}
- (IBAction)open:(UISwitch *)sender {
    [self sendRequest];
}
    
/**
 *  json转字符串
 */
- (NSString *)jsonToString:(NSDictionary *)dic
{
    if(!dic){
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
