//
//  NSParagraphStyle+FBTEditorCategory.h
//  test
//
//  Created by Later on 2017/3/14.
//  Copyright © 2017年 Later. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FBParagraphType) {
    FBParagraphTypeText = 0,
    FBParagraphTypeImage
};
@interface NSParagraphStyle (FBTEditorCategory)
@property (nonatomic, assign) FBParagraphType fbt_paragraphtype;
@end
