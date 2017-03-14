//
//  UIFont+FBTEditorCategory.m
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "UIFont+FBTEditorCategory.h"

@implementation UIFont (FBTEditorCategory)

- (BOOL)isBold {
    CTFontSymbolicTraits trait = CTFontGetSymbolicTraits((__bridge CTFontRef)self);
    if ((trait & kCTFontTraitBold) == kCTFontTraitBold)
        return YES;
    return NO;
}

- (BOOL)isItalic {
    CTFontSymbolicTraits trait = CTFontGetSymbolicTraits((__bridge CTFontRef)self);
    
    if ((trait & kCTFontTraitItalic) == kCTFontTraitItalic)
        return YES;
    
    return NO;
}
@end
