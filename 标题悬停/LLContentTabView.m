//
//  LLContentTabView.m
//  标题悬停
//
//  Created by 周尊贤 on 2018/1/25.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import "LLContentTabView.h"

@interface LLContentTabView()
@end

@implementation LLContentTabView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([gestureRecognizer.view isKindOfClass:[self class]]) {
        return true;
    }
    return false;
}



@end
