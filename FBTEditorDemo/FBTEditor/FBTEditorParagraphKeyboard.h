//
//  FBTEditorParagraphKeyBoard.h
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBTEditorParagraphKeyboardDelegate;
@interface FBTEditorParagraphKeyboard : UIView
@property (weak,   nonatomic) id<FBTEditorParagraphKeyboardDelegate> delegate;
@property (assign, nonatomic) NSTextAlignment         textAlignment;
+(instancetype)paragraphKeyboard;
@end
@protocol FBTEditorParagraphKeyboardDelegate <NSObject>

- (void)editorParagraphKeyboard:(FBTEditorParagraphKeyboard *)keyboard textAlignmentChanged:(NSTextAlignment)textAlignment;

@end
