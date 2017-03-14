//
//  FBTEditorTextKeyBoard.m
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "FBTEditorTextKeyboard.h"

static CGFloat const kMaxFontSize = 30;
static CGFloat const kMinFontSize = 8;
@interface FBTEditorTextKeyboard ()
@property (weak, nonatomic) IBOutlet UILabel *showFontSizeLabel;


@end
@implementation FBTEditorTextKeyboard
+(instancetype)textKeyboard{
    return [[[NSBundle mainBundle] loadNibNamed:@"FBTEditorTextKeyboard" owner:nil options:nil] lastObject];
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    self.showFontSizeLabel.text = [NSString stringWithFormat:@"%.f",fontSize];
    self.showFontSizeLabel.font = [UIFont systemFontOfSize:fontSize];
    self.showFontSizeLabel.text = [NSString stringWithFormat:@"%.f",self.fontSize];
    self.showFontSizeLabel.font = [UIFont systemFontOfSize:self.fontSize];
    if ([self.delegate respondsToSelector:@selector(editorTextKeyboard:fontSizeChange:)]) {
        [self.delegate editorTextKeyboard:self fontSizeChange:self.fontSize];
    }
}

- (IBAction)textColorChoose:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(editorTextKeyboard:colorChoose:)]) {
        [self.delegate editorTextKeyboard:self colorChoose:sender.backgroundColor];
    }
}
- (IBAction)reduceFontSize:(UIButton *)sender {
    CGFloat size = self.fontSize;
    size -- ;
    if (size < kMinFontSize) {
        size = kMinFontSize;
    }
    self.fontSize = size;
}
- (IBAction)addFontSize:(UIButton *)sender {
    CGFloat size = self.fontSize;
    size ++;
    if (size > kMaxFontSize) {
        size = kMaxFontSize;
    }
    self.fontSize = size;
}

- (IBAction)boardChoose:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(editorTextKeyboard:isBoard:)]) {
        [self.delegate editorTextKeyboard:self isBoard:sender.selected];
    }
}
- (IBAction)obliqueChoose:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(editorTextKeyboard:isOblique:)]) {
        [self.delegate editorTextKeyboard:self isOblique:sender.selected];
    }
}
- (IBAction)underlineChoose:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(editorTextKeyboard:isUnderline:)]) {
        [self.delegate editorTextKeyboard:self isUnderline:sender.selected];
    }
}
- (IBAction)strikethroughChoose:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(editorTextKeyboard:isStrikethrough:)]) {
        [self.delegate editorTextKeyboard:self isStrikethrough:sender.selected];
    }
}

@end
