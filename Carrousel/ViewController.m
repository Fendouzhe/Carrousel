//
//  ViewController.m
//  Carrousel
//
//  Created by leilurong on 2017/1/3.
//  Copyright © 2017年 leilurong. All rights reserved.
//

#import "ViewController.h"
#import "LRCarrouselView.h"
#import "LRSlider.h"
#import "UIButton+Category.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self testCarrouselView];
}

- (void)testCarrouselView{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 8; i ++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"mm%ld.jpeg", (long)i]];
        [array addObject:image];
    }
    LRCarrouselView *carr = [[LRCarrouselView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 198) images:array callback:^(NSInteger index, NSInteger event) {
        
        NSLog(@"%ld %@", index, event == 1 ? @"点击" : @"长按");
    }];
    [carr addImage:[UIImage imageNamed:@"mm8.jpeg"]];
    carr.backgroundColor = [UIColor blackColor];
    carr.animationSpeed = 2;
    carr.showReflectLayer = YES;
    [self.view addSubview:carr];
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setFrame:CGRectMake(self.view.bounds.size.width*0.5-100-40, CGRectGetMaxY(carr.frame)+30, 100, 48)];
    [start setTitle:@"开始" forState:UIControlStateNormal];
    [start setBackgroundColor:[UIColor blueColor]];
    [start handleControlEvents:UIControlEventTouchUpInside withBlock:^(UIControlEvents events) {
        
        [carr startRotateRight:YES];
    }];
    [self.view addSubview:start];
    
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    [stop setFrame:CGRectMake(self.view.bounds.size.width*0.5+40, CGRectGetMinY(start.frame), 100, 48)];
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    [stop setBackgroundColor:[UIColor blueColor]];
    [stop handleControlEvents:UIControlEventTouchUpInside withBlock:^(UIControlEvents events) {
        
        [carr stopRotate];
    }];
    [self.view addSubview:stop];
    
    LRSlider *slopex = [[LRSlider alloc] initWithWidth:280 center:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 120) horizontal:YES];
    [self.view addSubview:slopex];
    slopex.thumbcolor = [UIColor magentaColor];
    slopex.gradientBackInfo = [self sliderBackGraidentInfo];
    slopex.value = 2 / 6.0;
    [slopex handleSliderAction:UIControlEventValueChanged callback:^(LRSlider *slider, UIControlEvents event) {
        
        carr.animationSpeed = slider.value * 6;
    }];
}

- (NSDictionary *)sliderBackGraidentInfo{
    return @{@"locations" : @[@(0),
                              @(60 / 360.),
                              @(120 / 360.),
                              @(180 / 360.),
                              @(240 / 360.),
                              @(300 / 360.),
                              @(1)],
             @"colors" : @[[UIColor redColor],
                           [UIColor yellowColor],
                           [UIColor greenColor],
                           [UIColor cyanColor],
                           [UIColor blueColor],
                           [UIColor magentaColor],
                           [UIColor redColor]]};
}



@end
