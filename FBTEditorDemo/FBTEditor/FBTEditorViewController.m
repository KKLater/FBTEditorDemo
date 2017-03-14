
//
//  FBTEditorViewController.m
//  test
//
//  Created by Later on 2017/2/17.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "FBTEditorViewController.h"
#import "FBTEditorView.h"
#import "FBTEditorKeyboardToolBar.h"
#import "FBTEditorTextKeyboard.h"
#import "FBTEditorParagraphKeyboard.h"

@interface FBTEditorViewController ()<FBTKeyboardToolBarDelegate, FBTEditorTextKeyboardDelegate, FBTEditorParagraphKeyboardDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet FBTEditorView *editorView;
@property (strong, nonatomic) FBTEditorKeyboardToolBar         * keyboardBar;
@property (strong, nonatomic) FBTEditorTextKeyboard         * textKeyBoard;
@property (strong, nonatomic) FBTEditorParagraphKeyboard         * paragraphKeyboard;

@end

@implementation FBTEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keyboardBar = [FBTEditorKeyboardToolBar editorKeyboardToolBar];
    self.keyboardBar.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44);
    self.keyboardBar.delegate = self;
    
    self.textKeyBoard = [FBTEditorTextKeyboard textKeyboard];
    self.textKeyBoard.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 250);
    self.textKeyBoard.delegate = self;
    
    self.paragraphKeyboard = [FBTEditorParagraphKeyboard paragraphKeyboard];
    self.paragraphKeyboard.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 250);
    self.paragraphKeyboard.delegate = self;
    
    self.textKeyBoard.fontSize = 18;
    self.editorView.fontSize = 18;
    self.paragraphKeyboard.textAlignment = NSTextAlignmentLeft;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.editorView.inputAccessoryView = self.keyboardBar;
    
}
#pragma mark FBTKeyboardToolBarDelegate
- (void)keyboardToolBar:(FBTEditorKeyboardToolBar *)keyboardToolBar keyboardChoose:(FBTKeyboardType)keyboardType {
    switch (keyboardType) {
        case FBTKeyboardTypeSystem:
        {
            self.editorView.inputView = nil;
            [self.editorView reloadInputViews];
        }
            break;
        case FBTKeyboardTypeText:
        {
            self.editorView.inputView = self.textKeyBoard;
            [self.editorView reloadInputViews];
            
        }
            break;
        case FBTKeyboardTypeParagrapa:
        {
            self.editorView.inputView = self.paragraphKeyboard;
            [self.editorView reloadInputViews];
        }
            break;
    }
    
}
- (void)keyboardToolBar:(FBTEditorKeyboardToolBar *)keyboardToolBar imagePickerButtonClicked:(UIButton *)imagePickerBurron {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取点击的图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    __weak typeof(self)weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf.editorView insertIamge:image atIndex:weakSelf.editorView.selectedRange.location];
        [weakSelf.editorView becomeFirstResponder];
    }];

}
#pragma mark FBTEditorTextKeyboardDelegate
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard colorChoose:(UIColor *)color {

    self.editorView.foregroundColor = color;
    
    
}
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard fontSizeChange:(CGFloat)fontSize {
    self.editorView.fontSize = fontSize;
    
}
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard isBoard:(BOOL)isBoard {
    self.editorView.isBoard = isBoard;
    
}
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard isOblique:(BOOL)isOblique {
    
    self.editorView.isOblique = isOblique;
}
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard isUnderline:(BOOL)isUnderline {
    self.editorView.isUnderline = isUnderline;
    
}
- (void)editorTextKeyboard:(FBTEditorTextKeyboard *)textKeyboard isStrikethrough:(BOOL)isStrikethrough {
    self.editorView.isStrikethrough = isStrikethrough;
}
#pragma mark FBTEditorParagraphKeyboardDelegate
- (void)editorParagraphKeyboard:(FBTEditorParagraphKeyboard *)keyboard textAlignmentChanged:(NSTextAlignment)textAlignment {
    self.editorView.alignment = textAlignment;
}
- (IBAction)save:(UIButton *)sender {
    NSLog(@"************************************ model : %@ \n ***************************************\n   jsonDic : %@\n **************************************\n jsonString : %@", self.editorView.editorModel, self.editorView.editorJsonDic, self.editorView.editorJsonString);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
