//
//  FBTEditorView+FBTEditorCategory.h
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "FBTEditorView.h"

@class FBTEditorModel;
@interface FBTEditorView (FBTEditorCategory)
- (NSRange)currentEditorRange;
@end
@interface NSAttributedString (FBTEditorCategory)
- (FBTEditorModel *)editorModelWithImageRanges:(NSArray <FBTEditorRangeImage *> *)imageRanges;
@end
