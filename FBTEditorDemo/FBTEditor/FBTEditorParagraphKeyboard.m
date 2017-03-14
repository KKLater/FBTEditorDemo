//
//  FBTEditorParagraphKeyBoard.m
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "FBTEditorParagraphKeyboard.h"
@interface FBTEditorParagraphKeyboard ()
@property (weak, nonatomic) IBOutlet UIButton *leftAlignmentButton;
@property (weak, nonatomic) IBOutlet UIButton *centerAlignmentButton;
@property (weak, nonatomic) IBOutlet UIButton *rightAlignmentButton;
@property (weak, nonatomic) IBOutlet UIButton *justifiedAlignmentButton;
@end
@implementation FBTEditorParagraphKeyboard
+(instancetype)paragraphKeyboard{
    return [[[NSBundle mainBundle] loadNibNamed:@"FBTEditorParagraphKeyboard" owner:nil options:nil] lastObject];
}
- (IBAction)textAlignmentLeftSetClicked:(UIButton *)sender {
    self.textAlignment = NSTextAlignmentLeft;
}
- (IBAction)textAlignmentCenterSetClicked:(UIButton *)sender {
    self.textAlignment = NSTextAlignmentCenter;

}
- (IBAction)textAlignmentRightSetClicked:(UIButton *)sender {
    self.textAlignment = NSTextAlignmentRight;

}
- (IBAction)textAlignmentJustifierSetClicked:(UIButton *)sender {
    self.textAlignment = NSTextAlignmentJustified;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    switch (_textAlignment) {
        case NSTextAlignmentLeft:
        case NSTextAlignmentNatural:
        {
            self.centerAlignmentButton.selected = NO;
            self.rightAlignmentButton.selected = NO;
            self.justifiedAlignmentButton.selected = NO;
            self.leftAlignmentButton.selected = YES;
        }
            break;
        case NSTextAlignmentRight:
        {
            self.leftAlignmentButton.selected = NO;
            self.centerAlignmentButton.selected = NO;
            self.justifiedAlignmentButton.selected = NO;
            self.rightAlignmentButton.selected = YES;
        }
            break;
        case NSTextAlignmentCenter:
        {
            self.leftAlignmentButton.selected = NO;
            self.rightAlignmentButton.selected = NO;
            self.justifiedAlignmentButton.selected = NO;
            self.centerAlignmentButton.selected = YES;
        }
            break;
        case NSTextAlignmentJustified:
        {
            self.leftAlignmentButton.selected = NO;
            self.centerAlignmentButton.selected = NO;
            self.rightAlignmentButton.selected = NO;
            self.justifiedAlignmentButton.selected = YES;
        }
            break;
    }

    if ([self.delegate respondsToSelector:@selector(editorParagraphKeyboard:textAlignmentChanged:)]) {
        [self.delegate editorParagraphKeyboard:self textAlignmentChanged:textAlignment];
    }
}

@end
