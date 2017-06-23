//
//  ViewController.m
//  UPLoad2.0
//
//  Created by Apple on 16/12/1.
//  Copyright © 2016年 仝兴伟. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "ASProgressPopUpView.h"
#import "HMStatusToolbar.h"
#import "HMComposePhotosView.h"
#import "UIView+Extension.h"
#import "TWProgressView.h"
#import "CircleProgressView.h"

@interface ViewController ()<ASProgressPopUpViewDataSource, HMStatusToolbarDelegate, UITextViewDelegate>
@property (strong, nonatomic) ASProgressPopUpView *progressView1;

@property (nonatomic, strong)UITextView *field;
@property (nonatomic, strong)HMStatusToolbar *toolbar;

@property (nonatomic, strong)TWProgressView *views;
@property (nonatomic, strong)UIImageView *imageViews;

@property (nonatomic, strong) CircleProgressView *circleProgress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIButton *button = [[UIButton alloc]init];
//    button.backgroundColor = [UIColor redColor];
//    button.frame = CGRectMake(100, 100, 100, 100);
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    
//    self.progressView1 = [[ASProgressPopUpView alloc]init];
//    self.progressView1.backgroundColor = [UIColor blackColor];
//    self.progressView1.frame = CGRectMake(10, 50, 300, 20);
//    self.progressView1.progress = 0.00000000;
//    self.progressView1.progressViewStyle = UIProgressViewStyleDefault;
//    self.progressView1.progressTintColor = [UIColor redColor];
//    self.progressView1.trackTintColor = [UIColor lightGrayColor];
//    [self.view addSubview:self.progressView1];
//
    
    [self addCricleProgress];
    
    [self addProgress];
    
    [self addTextView];

}


- (void)addCricleProgress {
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(60, 210, 200, 30)];
    slider.maximumValue = 1.0;
    slider.minimumValue = 0.0;
    slider.backgroundColor = [UIColor blueColor];
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventValueChanged];
    
    
    self.circleProgress = [[CircleProgressView alloc]init];
    self.circleProgress.frame = CGRectMake(50, 80, 80, 80);
    self.circleProgress.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.circleProgress];
}

- (void)addProgress {
    self.imageViews = [[UIImageView alloc]init];
    self.imageViews.width = self.view.width;
    self.imageViews.height = self.view.height;
    self.imageViews.userInteractionEnabled = YES;
    [self.view addSubview:self.imageViews];
    
    TWProgressView *views = [[TWProgressView alloc]init];
    views.width = 60;
    views.height = 60;
    views.backgroundColor = [UIColor lightGrayColor];
    [self.imageViews addSubview:views];
    views.centerX = self.imageViews.centerX;
    views.centerY = self.imageViews.centerY - 50;
    self.views = views;
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(60, 410, 200, 30)];
    slider.maximumValue = 1.0;
    slider.minimumValue = 0.0;
    slider.backgroundColor = [UIColor blueColor];
    [self.imageViews addSubview:slider];
    [slider addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark -- 滑块
- (void)sliderClick:(UISlider *)slider {
    NSLog(@"%f", [slider value]);
    self.views.progress = [slider value];
    NSLog(@"======%f", self.views.progress);
    
    self.views.centerLabel.text = [NSString stringWithFormat:@"%.2f%%", [slider value] * 100];
//    if ([slider value] == 1) {
//        self.imageViews.hidden = YES;
//    }
}

- (void)addTextView {
        UITextView *field = [[UITextView alloc]init];
        field.frame = CGRectMake((self.view.size.width - 300) / 2, 30, 300, 100);
        field.backgroundColor = [UIColor redColor];
        field.alwaysBounceVertical = YES;
        // 成为第一相应者  就能叫出键盘
        field.delegate = self;
        [self.view addSubview:field];
        self.field = field;
    //    //  监听键盘
    //    UIKeyboardDidShowNotification
    //    UIKeyboardDidHideNotification
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
        HMStatusToolbar *toolbar = [[HMStatusToolbar alloc]init];
        toolbar.width = self.view.size.width;
        toolbar.height = 44;
        toolbar.y = self.view.height - toolbar.height;
        toolbar.delegate = self;
        [self.view addSubview:toolbar];
        self.toolbar = toolbar;
    // 设置工具条
        field.inputAccessoryView = toolbar;
        [self setupPhotosView];

}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}



-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /**
     *  让键盘成为第一相应者
     */
    [self.field becomeFirstResponder];

}

#pragma mark --  UITextView代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"开始拖拽");
    [self.view endEditing:YES];
}

#pragma mark -- toobar 代理方法
- (void)composeTool:(HMStatusToolbar *)toolbar didClickedButton:(HMComposeToolbarButtonType)buttonType {
    
    switch (buttonType) {
        case HMComposeToolbarleft: // 照相机
            NSLog(@"打开照相机");
            break;
            
        case HMComposeToolbarButtonTypemodel: // 相册
            NSLog(@"打开相册");
            break;
            
        case HMComposeToolbarButtonTyperight: // 表情
            NSLog(@"打开表情");
            break;
            
        default:
            break;
    }

}

// 添加显示图片的相册控件
- (void)setupPhotosView
{
    HMComposePhotosView *photosView = [[HMComposePhotosView alloc] init];
    photosView.x = 0;
    photosView.y = 100;
    photosView.backgroundColor = [UIColor redColor];
    photosView.width = self.view.bounds.size.width;
    photosView.height = self.view.bounds.size.height;
    [self.view addSubview:photosView];
}


- (void)buttonClick:(UIButton *)button {
    
    // http://116.255.251.220:680/api/Files/PostFile
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"1111.jpg"], 1.0);
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST" URLString:@"http://116.255.251.220:680/api/Files/PostFile"
                                    parameters:nil
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                         [formData appendPartWithFileData:imageData
                                                     name:@"attachment"
                                                 fileName:@"myimage.jpg"
                                                 mimeType:@"image/jpeg"];
                     }];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         [self.progressView1 hidePopUpViewAnimated:YES];

                                         NSLog(@"Success %@", responseObject);
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         [self.progressView1 hidePopUpViewAnimated:YES];

                                         NSLog(@"Failure %@", error.description);
                                     }];
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        [self.progressView1 showPopUpViewAnimated:YES];

        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView1.progress = 1.0 * totalBytesWritten/ totalBytesExpectedToWrite;
        });
    }];
    
    // 5. Begin!
    [operation start];

}



#pragma mark --  注销通知

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
