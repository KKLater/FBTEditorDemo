//
//  FBTEditorTextKeyBoard.h
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBTEditorTextKeyboardDelegate;
@interface FBTEditorTextKeyboard : UIView
+(instancetype)textKeyboard;
@property (weak,   nonatomic) id<FBTEditorTextKeyboardDelegate>         delegate;
@property (assign, nonatomic) CGFloat         fontSize;
@end
@protocol FBTEditorTextKeyboardDelegate <NSObject>

/**
 颜色切换

 @param textKeyboard keyboard
 @param color 已选择颜色
 */
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard colorChoose:(UIColor *)color;

/**
 字号改变

 @param textKeyboard keyboard
 @param fontSize 字号大小
 */
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard fontSizeChange:(CGFloat)fontSize;

/**
 是否加粗

 @param textKeyboard keyboard
 @param isBoard 加粗
 */
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard isBoard:(BOOL)isBoard;

/**
 是否斜体

 @param textKeyboard keyboard
 @param isOblique 斜体
 */
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard isOblique:(BOOL)isOblique;

/**
 是否下划线

 @param textKeyboard keyboard
 @param isUnderline 下划线
 */
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard isUnderline:(BOOL)isUnderline;

/**
 是否显示删除线

 @param textKeyboard keyboard
 @param isStrikethrough 删除线
 */
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard isStrikethrough:(BOOL)isStrikethrough;
@end
