
//
//  FBTKeyboardToolBar.m
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "FBTEditorKeyboardToolBar.h"

@interface FBTEditorKeyboardToolBar ()
@property (assign, nonatomic) FBTKeyboardType         type;

@end
@implementation FBTEditorKeyboardToolBar
+(instancetype)editorKeyboardToolBar{
    return [[[NSBundle mainBundle] loadNibNamed:@"FBTEditorKeyboardToolBar" owner:nil options:nil] lastObject];
}

- (IBAction)systemKeyboardShow:(UIButton *)sender {
    if (self.type != FBTKeyboardTypeSystem) {
        self.type = FBTKeyboardTypeSystem;
    }
}
- (IBAction)textKeyboardShow:(UIButton *)sender {
    if (self.type != FBTKeyboardTypeText) {
        self.type = FBTKeyboardTypeText;
    }
}
- (IBAction)paragraphKeyboardShow:(UIButton *)sender {
    if (self.type != FBTKeyboardTypeParagrapa) {
        self.type = FBTKeyboardTypeParagrapa;
    }
}
- (IBAction)imagePickShow:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(keyboardToolBar:imagePickerButtonClicked:)]) {
        [self.delegate keyboardToolBar:self imagePickerButtonClicked:sender];
    }
}

- (void)setType:(FBTKeyboardType)type {
    _type = type;
    if ([self.delegate respondsToSelector:@selector(keyboardToolBar:keyboardChoose:)]) {
        [self.delegate keyboardToolBar:self keyboardChoose:type];
    }
}
@end
