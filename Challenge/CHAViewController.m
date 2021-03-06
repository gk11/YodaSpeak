//
//  CHAViewController.m
//  Challenge
//
//  Created by Galia Kaufman on 5/17/14.
//
//

#import "CHAViewController.h"
#import "CHAYodaRequest.h"

#define STANDARD_FONT_COLOR [UIColor colorWithRed:0.153 green:0.190 blue:0.331 alpha:1.000]
#define LIGHT_FONT_COLOR [UIColor colorWithRed:0.549 green:0.549 blue:0.654 alpha:1.000]


@interface CHAViewController ()

@property (strong, nonatomic) CHAYodaRequest *yodaRequest;

@end

@implementation CHAViewController

#pragma mark - initialization

- (void)viewDidLoad
{
    [super viewDidLoad];

    // setup text edit controls
    [self.userTextView setDelegate:self];
    [self.translatedTextView setEditable:NO];
    
    
    self.yodaRequest = [[CHAYodaRequest alloc] init];
    // setup buttons
    NSString *title = [NSString stringWithFormat:@"%@ Speak", [self.yodaRequest languageName]];
    [self.speakButton setTitle:title forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - translation

- (void)translateUserText
{
    [self.translatedTextView setTextColor:LIGHT_FONT_COLOR];
    [self.translatedTextView setText:@" thinking..."];
    
    // hit the translation endpoint and update the restul when it arrives asynchronously
    [self.yodaRequest translate:self.userTextView.text result:^(NSString *string) {
        
        [self.translatedTextView setText:string ? string : @"Cannot translate"];
        [self.translatedTextView setTextColor:STANDARD_FONT_COLOR];
        
    }];
}

#pragma mark - delegates

- (IBAction)speakButtonTouched:(id)sender {
    [self.view endEditing:YES];
    [self translateUserText];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self translateUserText];
    [super touchesBegan:touches withEvent:event];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.backgroundColor = [UIColor whiteColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    textView.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000];
}

@end
