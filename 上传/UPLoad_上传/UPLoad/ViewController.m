//
//  ViewController.m
//  UPLoad
//
//  Created by Apple on 16/12/1.
//  Copyright © 2016年 仝兴伟. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "ASProgressPopUpView.h"

@interface ViewController ()<ASProgressPopUpViewDataSource>
@property (strong, nonatomic) ASProgressPopUpView *progressView1;
@property (nonatomic, strong)UIProgressView *progress;
@property (nonatomic, assign)float number;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // http://116.255.251.220:680/api/Files/PostFile
    self.number = 0.0;
    
    
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    self.progressView1 = [[ASProgressPopUpView alloc]init];
    self.progressView1.backgroundColor = [UIColor blackColor];
    self.progressView1.frame = CGRectMake(10, 50, 300, 20);
    self.progressView1.progress = 0.00000000;
    self.progressView1.progressViewStyle = UIProgressViewStyleDefault;
    self.progressView1.progressTintColor = [UIColor redColor];
    self.progressView1.trackTintColor = [UIColor lightGrayColor];
    [self.view addSubview:self.progressView1];
    
}


- (void)buttonClick:(UIButton *)button {
    NSString *url = [NSString stringWithFormat:@"http://116.255.251.220:680/api/Files/PostFile"];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    UIImage *image = [UIImage imageNamed:@"2222.jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *fileName = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];

    [manger POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"pic" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [self.progressView1 showPopUpViewAnimated:YES];
        [self.progress setProgress:self.number animated:YES];
        NSLog(@"self.progressView1.progress====%f", self.number);
        
        NSLog(@"%lld========%lld =======%f", uploadProgress.totalUnitCount, uploadProgress.completedUnitCount, 1.0 * uploadProgress.completedUnitCount/ uploadProgress.totalUnitCount);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView1.progress = 10 * uploadProgress.fractionCompleted;
            self.progressView1.progress = 1.0 * uploadProgress.completedUnitCount/ uploadProgress.totalUnitCount;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.progressView1 hidePopUpViewAnimated:YES];
        NSLog(@"responseObject===%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@", error.description);
    }];
}























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
