//
//  FBTEditorView.h
//  test
//
//  Created by Later on 2017/2/17.
//  Copyright © 2017年 Later. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBTEditorModel, FBTEditorConfig, FBTEditorRangeImage;
@interface FBTEditorView : UITextView
@property (assign, nonatomic) NSTextAlignment         alignment;
@property (strong, nonatomic) UIColor         * foregroundColor;

@property (assign, nonatomic) CGFloat         fontSize;
@property (assign, nonatomic) BOOL         isBoard;
@property (assign, nonatomic) BOOL         isOblique;
@property (assign, nonatomic) BOOL         isUnderline;
@property (assign, nonatomic) BOOL         isStrikethrough;
@property (assign, nonatomic) BOOL         isTitle;

@property (strong, nonatomic) FBTEditorModel         * editorModel;
@property (copy,   nonatomic) NSString         * editorJsonString;
@property (strong, nonatomic) NSDictionary         * editorJsonDic;

@property (nonatomic, strong) NSArray <FBTEditorRangeImage *>*images;
- (void)insertIamge:(UIImage *)image atIndex:(NSInteger)index;
@end
