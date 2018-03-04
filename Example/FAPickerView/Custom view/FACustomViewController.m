//
//  FACustomViewController.m
//  FAPickerView_Example
//
//  Created by Fadi Abuzant on 3/1/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

#import "FACustomViewController.h"
#import "FAImageView.h"
#import "FAPickerView.h"

@interface FACustomViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation FACustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_customViewImageView setImageWithURL:@"https://cdn.pixabay.com/photo/2017/08/20/10/30/facebook-2661207_960_720.jpg" ThumbImage:[UIImage imageNamed:@"Thumb"]];
    
    [_closeButton setHidden:!_isCustomPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SwitchImage:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0://Facebook
            [_customViewImageView setImageWithURL:@"https://cdn.pixabay.com/photo/2017/08/20/10/30/facebook-2661207_960_720.jpg" ThumbImage:[UIImage imageNamed:@"Thumb"]];
            break;
        case 1://Twitter
            [_customViewImageView setImageWithURL:@"https://cdn.pixabay.com/photo/2017/08/23/11/30/twitter-2672572_960_720.jpg" ThumbImage:[UIImage imageNamed:@"Thumb"]];
            break;
        default:
            break;
    }
}

- (IBAction)CloseButton:(UIButton *)sender {
    [FAPickerView ClosePicker];
}


@end
