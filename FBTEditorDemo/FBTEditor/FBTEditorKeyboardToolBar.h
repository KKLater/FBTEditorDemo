//
//  FBTKeyboardToolBar.h
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBTKeyboardToolBarDelegate;
typedef NS_ENUM(NSInteger, FBTKeyboardType) {
    FBTKeyboardTypeSystem = 0,
    FBTKeyboardTypeText,
    FBTKeyboardTypeParagrapa
};

@interface FBTEditorKeyboardToolBar : UIView
+(instancetype)editorKeyboardToolBar;
@property (weak,   nonatomic) id <FBTKeyboardToolBarDelegate>         delegate;
@end

@protocol FBTKeyboardToolBarDelegate <NSObject>

- (void)keyboardToolBar:(FBTEditorKeyboardToolBar *)keyboardToolBar keyboardChoose:(FBTKeyboardType)keyboardType;
- (void)keyboardToolBar:(FBTEditorKeyboardToolBar *)keyboardToolBar imagePickerButtonClicked:(UIButton *)imagePickerBurron;

@end
