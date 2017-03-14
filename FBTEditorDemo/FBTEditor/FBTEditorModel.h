//
//  FBTEditorModel.h
//  test
//
//  Created by Later on 2017/2/17.
//  Copyright © 2017年 Later. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FBTEditorParagraph,FBTEditorRangeObject, FBTMutableParagraphStyle;
@interface FBTEditorModel : NSObject
@property (strong, nonatomic) NSMutableArray <FBTEditorParagraph *>         * paragraphs;
@end

@interface FBTEditorParagraph : NSObject
@property (strong, nonatomic) NSParagraphStyle         * style;
@property (strong, nonatomic) NSMutableArray <FBTEditorRangeObject *>         * attribuateRanges;
@end
@interface FBTEditorRangeObject : NSObject

@end
@interface FBTEditorRangeString : FBTEditorRangeObject
@property (copy,   nonatomic) NSString         * text;
@property (copy,   nonatomic) NSString         * fontFamilyName;
@property (copy,   nonatomic) NSString         * fontSize;
@property (copy,   nonatomic) NSString         * foregroundColor;
@property (copy,   nonatomic) NSString         * backGroundColor;
@property (assign, nonatomic) BOOL         isBoard;
@property (assign, nonatomic) BOOL         isItalic;
@property (assign, nonatomic) BOOL         hasUnderline;
@property (assign, nonatomic) BOOL         hasStrikeThrough;
@end
@interface FBTEditorRangeImage : FBTEditorRangeObject
@property (nonatomic, strong) NSNumber *originImageWidth;
@property (nonatomic, strong) NSNumber *originImageHeight;
@property (nonatomic, strong) NSNumber *imageWidth;
@property (nonatomic, strong) NSNumber *imageHeidth;
@property (nonatomic, strong) NSNumber *index;

@property (copy,   nonatomic) NSString         * imageLink;

@end
