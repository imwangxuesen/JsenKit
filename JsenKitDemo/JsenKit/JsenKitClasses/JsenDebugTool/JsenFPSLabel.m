//
//  JsenFPSLabel.m
//  JsenKit
//
//  Created by WangXuesen on 2017/8/1.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "JsenFPSLabel.h"


@interface JsenFPSLabel()

@property(nonatomic,strong) CADisplayLink *link;

@end

@implementation JsenFPSLabel {
    NSTimeInterval _lastTime;
    NSUInteger _count;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 50, 20);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor greenColor];
        
    }
    return self;
}

+ (void)show {
    JsenFPSLabel *label = [[JsenFPSLabel alloc] initWithFrame:CGRectMake(20, 64, 70, 20)];
    [label.link setPaused:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] keyWindow]) {
            [[UIApplication sharedApplication].keyWindow addSubview:label];
        }
    });

    
}

#pragma mark - private
- (void)dispalyLinkTick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) {
        return;
    }
    
    _lastTime = link.timestamp;
    float fps = _count/delta;
    _count = 0;
    self.text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    
}

#pragma mark - getter
- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(dispalyLinkTick:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}

@end
