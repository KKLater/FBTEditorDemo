//
//  ViewController.m
//  FBTEditorDemo
//
//  Created by Later on 2017/3/14.
//  Copyright © 2017年 Later. All rights reserved.
//

#import "ViewController.h"
#import "FBTEditorViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FBTEditorViewController *editor = [[FBTEditorViewController alloc] initWithNibName:NSStringFromClass([FBTEditorViewController class]) bundle:nil];
    [self presentViewController:editor animated:YES completion:nil];
}

@end
