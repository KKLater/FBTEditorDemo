//
//  NSParagraphStyle+FBTEditorCategory.m
//  test
//
//  Created by Later on 2017/3/14.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "NSParagraphStyle+FBTEditorCategory.h"
#import <objc/runtime.h>

static NSString *const kFBTParagraphtype = @"com.FBTEditor.kFBTParagraphtype";
@implementation NSParagraphStyle (FBTEditorCategory)
- (void)setFbt_paragraphtype:(FBParagraphType)fbt_paragraphtype {
    objc_setAssociatedObject(self, &kFBTParagraphtype, @(fbt_paragraphtype), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (FBParagraphType)fbt_paragraphtype {
    return [objc_getAssociatedObject(self, &kFBTParagraphtype) integerValue];
}
@end
