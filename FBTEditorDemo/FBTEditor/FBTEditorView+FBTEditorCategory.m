
//
//  FBTEditorView+FBTEditorCategory.m
//  test
//
//  Created by Later on 2017/2/20.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "FBTEditorView+FBTEditorCategory.h"
#import "FBTEditorModel.h"
#import "UIFont+FBTEditorCategory.h"
#import "FBTEditorConfig.h"
#import <objc/runtime.h>
#import "NSParagraphStyle+FBTEditorCategory.h"

@interface NSAttributedString ()
- (NSArray *)rangeOfParagraphsFromTextRange:(NSRange)textRange;
@end

@implementation FBTEditorView (FBTEditorCategory)
- (NSRange)currentEditorRange {
    if (self.attributedText.length > 0) {
        NSArray *paragraphRanges = [self.attributedText rangeOfParagraphsFromTextRange:NSMakeRange(0, self.attributedText.string.length-1)];
        NSValue *rangeValue = paragraphRanges.lastObject;
        NSRange range = [rangeValue rangeValue];
        if (range.location == self.selectedRange.location) {
            return range;
        } else {
            for (NSValue *rangeValue in paragraphRanges) {
                NSRange range = [rangeValue rangeValue];
                if (self.selectedRange.location >=  range.location  && range.location + range.length >= self.selectedRange.location) {
                    return range;
                }
            }
            return NSMakeRange(self.selectedRange.location - 1, 0);
        }
    }
    
    return NSMakeRange(0, 0);
    
}
@end

@implementation NSAttributedString (FBTEditorCategory)

- (NSRange)firstParagraphRangeFromTextRange:(NSRange)range
{
    NSInteger start = -1;
    NSInteger end = -1;
    NSInteger length = 0;
    
    NSInteger startingRange = (range.location == self.string.length || [self.string characterAtIndex:range.location] == '\n') ?
    range.location-1 :
    range.location;
    
    for (NSInteger i = startingRange ; i>=0 ; i--)
    {
        char c = [self.string characterAtIndex:i];
        if (c == '\n')
        {
            start = i+1;
            break;
        }
    }
    
    start = (start == -1) ? 0 : start;
    
    NSInteger moveForwardIndex = (range.location > start) ? range.location : start;
    
    for (NSInteger i = moveForwardIndex; i<= self.string.length-1 ; i++)
    {
        char c = [self.string characterAtIndex:i];
        if (c == '\n')
        {
            end = i;
            break;
        }
    }
    
    end = (end == -1) ? self.string.length : end;
    length = end - start;
    
    return NSMakeRange(start, length);
}
- (NSArray *)rangeOfParagraphsFromTextRange:(NSRange)textRange
{
    if (self.length > 0) {
        
        NSMutableArray *paragraphRanges = [NSMutableArray array];
        NSInteger rangeStartIndex = textRange.location;
        
        while (true)
        {
            NSRange range = [self firstParagraphRangeFromTextRange:NSMakeRange(rangeStartIndex, 0)];
            rangeStartIndex = range.location + range.length + 1;
            
            [paragraphRanges addObject:[NSValue valueWithRange:range]];
            
            if (range.location + range.length >= textRange.location + textRange.length)
                break;
        }
        
        return paragraphRanges;
    }
    return nil;
}
- (FBTEditorModel *)editorModelWithImageRanges:(NSArray <FBTEditorRangeImage *> *)imageRanges {
    FBTEditorModel *editorModel = [[FBTEditorModel alloc] init];
    
    NSArray *paragraphRanges = [self rangeOfParagraphsFromTextRange:NSMakeRange(0, self.string.length-1)];
    
    for (int i=0 ; i<paragraphRanges.count ; i++)
    {
        FBTEditorParagraph *paragraph = [[FBTEditorParagraph alloc] init];
        NSValue *value = [paragraphRanges objectAtIndex:i];
        NSRange range = [value rangeValue];
        NSDictionary *paragraphDictionary = [self attributesAtIndex:range.location effectiveRange:nil];
        NSParagraphStyle *paragraphStyle = [paragraphDictionary objectForKey:NSParagraphStyleAttributeName];
        
        
        paragraph.style = paragraphStyle;
        

            
            [self enumerateAttributesInRange:range
                                     options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                  usingBlock:^(NSDictionary *dictionary, NSRange range, BOOL *stop){
                                      
                                      UIFont *font = [dictionary objectForKey:NSFontAttributeName];
                                      UIColor *foregroundColor = [dictionary objectForKey:NSForegroundColorAttributeName];
                                      UIColor *backGroundColor = [dictionary objectForKey:NSBackgroundColorAttributeName];
                                      
                                      NSNumber *underline = [dictionary objectForKey:NSUnderlineStyleAttributeName];
                                      
                                      BOOL hasUnderline = (!underline || underline.intValue == NSUnderlineStyleNone) ? NO :YES;
                                      NSNumber *strikeThrough = [dictionary objectForKey:NSStrikethroughStyleAttributeName];
                                      BOOL hasStrikeThrough = (!strikeThrough || strikeThrough.intValue == NSUnderlineStyleNone) ? NO :YES;
                                      
                                      if (paragraphStyle.fbt_paragraphtype == FBParagraphTypeImage) {
                                          for (FBTEditorRangeImage *rangeImage in imageRanges) {
                                              if ([rangeImage.index integerValue] == range.location) {
                                                  [paragraph.attribuateRanges addObject:rangeImage];
                                              }
                                          }
                                          
                                      }
                                      if (paragraphStyle.fbt_paragraphtype == FBParagraphTypeText) {
                                      
                                      FBTEditorRangeString *rangeStr = [[FBTEditorRangeString alloc] init];
                                      rangeStr.isBoard = [font isBold];
                                      rangeStr.isItalic = [font isItalic];
                                      rangeStr.hasUnderline = hasUnderline;
                                      rangeStr.hasStrikeThrough = hasStrikeThrough;
                                      
                                      rangeStr.text = [[self.string substringFromIndex:range.location] substringToIndex:range.length];
                                      rangeStr.fontFamilyName = font.familyName;
                                      rangeStr.fontSize = [@(font.pointSize) stringValue];
                                      if (foregroundColor) {
                                          rangeStr.foregroundColor = [self hexStringForColor:foregroundColor];
                                      }
                                      if (backGroundColor) {
                                          rangeStr.backGroundColor = [self hexStringForColor:backGroundColor];
                                      }
                                      
                                      [paragraph.attribuateRanges addObject:rangeStr];
                                      }
                                      
                                  }];
            [editorModel.paragraphs addObject:paragraph];        
    }
    return editorModel;
}
-(NSString*)hexStringForColor:(UIColor*)color{
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    return [NSString stringWithFormat:@"%06x", rgb];
}

@end

