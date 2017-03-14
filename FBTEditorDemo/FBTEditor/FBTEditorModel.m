//
//  FBTEditorModel.m
//  test
//
//  Created by Later on 2017/2/17.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "FBTEditorModel.h"

@implementation FBTEditorModel
- (NSMutableArray<FBTEditorParagraph *> *)paragraphs {
    if (!_paragraphs) {
        _paragraphs = [[NSMutableArray alloc] init];
    }
    return _paragraphs;
}
@end
@implementation FBTEditorParagraph
- (NSMutableArray<FBTEditorRangeObject *> *)attribuateRanges {
    if (!_attribuateRanges) {
        _attribuateRanges = [[NSMutableArray alloc] init];
    }
    return _attribuateRanges;
}


@end
@implementation FBTEditorRangeObject


@end
@implementation FBTEditorRangeString


@end
@implementation FBTEditorRangeImage



@end
