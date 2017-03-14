//
//  FBTEditorView.m
//  test
//
//  Created by Later on 2017/2/17.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "FBTEditorView.h"
#import "FBTEditorView+FBTEditorCategory.h"
#import "FBTEditorModel.h"
#import <MJExtension/NSObject+MJKeyValue.h>
#import "NSParagraphStyle+FBTEditorCategory.h"

@interface FBTEditorView ()<UITextViewDelegate>
@property (assign, nonatomic) NSInteger         editorRangeLocation;
@property (assign, nonatomic) NSInteger         editorRangeLence;
@property (assign, nonatomic) NSRange         editorRange;
@property (strong, nonatomic) NSMutableDictionary         * textAttributes;
@property (strong, nonatomic) NSMutableParagraphStyle         * style;
@property (nonatomic, strong) NSMutableArray <FBTEditorRangeImage *>*imageRanges;
@end

@implementation FBTEditorView
- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
    }
    return self;
}

- (void)setAlignment:(NSTextAlignment)alignment {
    _alignment = alignment;
    
    self.style.alignment = alignment;
    self.textAttributes[NSParagraphStyleAttributeName] = [self.style copy];
    self.typingAttributes = self.textAttributes;    

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = alignment;
    NSMutableAttributedString *att = self.attributedText.mutableCopy;
    NSRange cRange = [self currentEditorRange];
    [att addAttributes:@{NSParagraphStyleAttributeName : style} range:cRange];
    self.attributedText = att;
    self.selectedRange = NSMakeRange(cRange.location+cRange.length, 0);
    
}
- (void)setIsBoard:(BOOL)isBoard {
    _isBoard = isBoard;
    if (isBoard) {
        self.textAttributes[NSFontAttributeName] =  [UIFont boldSystemFontOfSize:self.fontSize > 0 ? self.fontSize : self.font.pointSize];
    } else {
        self.textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:self.fontSize > 0 ? self.fontSize : self.font.pointSize];
    }
    self.typingAttributes = self.textAttributes;

}
- (void)setIsOblique:(BOOL)isOblique {
    _isOblique = isOblique;
    if (isOblique) {
        self.textAttributes[NSObliquenessAttributeName] = @(0.5);
    } else {
        self.textAttributes[NSObliquenessAttributeName] = @(0);

    }
    self.typingAttributes = self.textAttributes;


}
- (void)setIsUnderline:(BOOL)isUnderline {
    _isUnderline = isUnderline;
    self.textAttributes[NSUnderlineStyleAttributeName] = @(isUnderline);
    self.typingAttributes = self.textAttributes;

}
- (void)setIsStrikethrough:(BOOL)isStrikethrough {
    _isStrikethrough = isStrikethrough;
    self.textAttributes[NSStrikethroughStyleAttributeName] = @(isStrikethrough);
    self.typingAttributes = self.textAttributes;

}
- (void)setForegroundColor:(UIColor *)foregroundColor {
    _foregroundColor = foregroundColor;
    if (foregroundColor) {
        self.textAttributes[NSForegroundColorAttributeName] =  foregroundColor;
    } else {
        self.textAttributes[NSForegroundColorAttributeName] = self.textColor;
    }
    self.typingAttributes = self.textAttributes;
}


- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    if (self.isBoard) {
        self.textAttributes[NSFontAttributeName] =  [UIFont boldSystemFontOfSize:fontSize];
    } else {
        self.textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    }
    self.typingAttributes = self.textAttributes;

}

- (void)insertIamge:(UIImage *)image atIndex:(NSInteger)index {
    CGSize imageSize = image.size;
    CGFloat width = CGRectGetWidth(self.bounds) - (self.textContainerInset.left + self.textContainerInset.right + self.textContainer.lineFragmentPadding * 2);
    CGFloat height = imageSize.height * width/imageSize.width;
    
    FBTEditorRangeImage *rangeImage = [[FBTEditorRangeImage alloc] init];
    rangeImage.index = @(index);
    rangeImage.originImageWidth = @(imageSize.width);
    rangeImage.originImageHeight = @(imageSize.height);
    rangeImage.imageWidth = @(width);
    rangeImage.imageHeidth = @(height);
    [self.imageRanges addObject:rangeImage];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init] ;
    textAttachment.image = image; //要添加的图片
    textAttachment.bounds = CGRectMake(0, 0, width, height);
    NSString *insertString = @"";
    if (self.attributedText.length > 0) {
        insertString = @"\n";
    }
    NSMutableAttributedString *insertAtt = [[NSMutableAttributedString alloc] initWithString:insertString];

    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [insertAtt appendAttributedString:textAttachmentString];
    [insertAtt appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.fbt_paragraphtype = FBParagraphTypeImage;
    style.alignment = NSTextAlignmentCenter;
    [insertAtt addAttributes:@{NSParagraphStyleAttributeName : style} range:NSMakeRange(0, 1)];
    
    NSMutableAttributedString *att = self.attributedText.mutableCopy;
    [att insertAttributedString:insertAtt atIndex:self.selectedRange.location];//index为用户指定要插入图片的位置

    self.attributedText = att;
    self.typingAttributes = self.textAttributes;

}


- (FBTEditorModel *)editorModel {
    [self uploadImage];
    return [self.attributedText editorModelWithImageRanges:self.imageRanges];
}
- (void)uploadImage{
    for (int i = 0; i < self.imageRanges.count; i++) {
        FBTEditorRangeImage *imageRange = self.imageRanges[i];
        imageRange.imageLink = @"http://img10.fblife.com/attachments/20170313/1489381712.jpg.450x300.jpg";
    }
}
- (NSDictionary *)editorJsonDic {
    if (self.editorModel) {
        NSDictionary *dic = [self.editorModel mj_keyValues];
        return dic;
    }
    return nil;
    
}
- (NSString *)editorJsonString {
    if (self.editorModel) {
        NSString *editorJson = [self.editorModel mj_JSONString];
        return editorJson;
    }
    return nil;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
     return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView {

}




- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    return NO;
    
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    return NO;
    
}

- (NSMutableArray<FBTEditorRangeImage *> *)imageRanges {
    if (!_imageRanges) {
        _imageRanges = [[NSMutableArray alloc] init];
    }
    return _imageRanges;
}
- (NSArray<FBTEditorRangeImage *> *)images {
    return [self.imageRanges copy];
}

- (NSMutableDictionary *)textAttributes {
    if (!_textAttributes) {
        _textAttributes = [self.typingAttributes mutableCopy];
        _textAttributes[NSFontAttributeName] = self.font;
        _textAttributes[NSForegroundColorAttributeName] = self.textColor;
        _textAttributes[NSParagraphStyleAttributeName] = self.style;
    }
    return _textAttributes;
}
- (NSMutableParagraphStyle *)style {
    if (!_style) {
        _style = [[NSMutableParagraphStyle alloc] init];
        _style.alignment = NSTextAlignmentLeft;
    }
    return _style;
}
@end
