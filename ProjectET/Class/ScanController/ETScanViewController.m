//
//  HBK_ScanViewController.m
//  HBK_Scan
//
//  Created by 黄冰珂 on 2017/11/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "ETScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ET_ScaningView.h"
#import "ETDirectTransferController.h"
#import "ETShopPaymentViewController.h"

@interface ETScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) ET_ScaningView *scanningView;

@end

@implementation ETScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建扫描边框
    self.scanningView = [[ET_ScaningView alloc] initWithFrame:self.view.frame outsideViewLayer:self.view.layer];
    [self.view addSubview:self.scanningView];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 二维码扫描
    [self setupScanningQRCode];
}
// 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scanningView removeTimer];
}

#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、 创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    output.rectOfInterest = CGRectMake(0.15, 0.24, 0.7, 0.52);
    
    // 5、 初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 会频繁的扫描，调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    // 3. 设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        if ([obj.stringValue hasPrefix:@"http"]) {
            // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
            NSLog(@"扫描网址为----------%@", obj.stringValue);
            if (self.isDirection) {
                ETDirectTransferController *dvc = [ETDirectTransferController new];
                dvc.address = obj.stringValue;
                dvc.coinNameString = @"ETH";
                [self.navigationController pushViewController:dvc animated:YES];
            }else {
                if (self.scanBlock) {
                    self.scanBlock(obj.stringValue);
                }
                [self.navigationController popViewControllerAnimated:true];
            }
           
        } else { // 扫描结果为条形码
            NSLog(@"扫描条形码为----------%@", obj.stringValue);
            if (self.isDirection) {
                NSDictionary *dic = [Tools dictionaryWithJsonString:obj.stringValue];
                NSLog(@"%@",dic);
                if (dic == nil) {
                    ETDirectTransferController *dvc = [ETDirectTransferController new];
                    dvc.hidesBottomBarWhenPushed = YES;
                    dvc.address = obj.stringValue;
                    dvc.coinNameString = @"ETH";
                    NSMutableArray *vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
                    [vcs removeLastObject];
                    [vcs addObject:dvc];
                    [self.navigationController setViewControllers:vcs];
                }else if (dic[@"version"] == nil) {
                    ETShopPaymentViewController *pvc = [ETShopPaymentViewController new];
                    pvc.hidesBottomBarWhenPushed = YES;
                    pvc.jsonStr = obj.stringValue;
                    NSMutableArray *vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
                    [vcs removeLastObject];
                    [vcs addObject:pvc];
                    [self.navigationController setViewControllers:vcs];
                }else {
                    [KMPProgressHUD showText:@"请扫描正确的二维码"];
                    [self setupScanningQRCode];
                }
            }else {
                if (self.scanBlock) {
                    self.scanBlock(obj.stringValue);
                }
                [self.navigationController popViewControllerAnimated:true];
            }
        }
        
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
