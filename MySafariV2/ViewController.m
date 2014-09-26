//
//  ViewController.m
//  MySafariV2
//
//  Created by Basel Farag on 9/24/14.
//  Copyright (c) 2014 NextTierGames. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *onBackButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *onForwardButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *onStopButtonPressed;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myWebView.delegate = self;
    self.myURLTextField.delegate = self;
    [self.myURLTextField setReturnKeyType:UIReturnKeyGo];
	// Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{   //
    //create a URL with the string you're given
    //load that URL
    [self.myURLTextField resignFirstResponder];
    //NSURL *url = [NSURL URLWithString:text];
    //NSURL *text = [NSURL URLWithString:@""];
    //[NSURL URLWithString:text];
    NSString *text = self.myURLTextField.text;
    NSLog(@"You typed %@", self.myURLTextField.text);
    if ([text hasPrefix:@"http://"]){
        NSLog(@"You typed %@", text);
        NSURL *url = [NSURL URLWithString:text];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.myWebView loadRequest:urlRequest];
    }
    else if (![text hasPrefix:@"http://"]){
        [text stringByAppendingString:@"https://"];
        NSURL *url = [NSURL URLWithString:text];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.myWebView loadRequest:urlRequest];
    }//else {
//        NSURL *url = [NSURL URLWithString:text];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [self.myWebView loadRequest:urlRequest];
//    }
    return 0;
}

- (IBAction)onBackButtonPressed:(id)sender {
    //Remember you're not setting it equal to anything, you're just trying to access a method inherent to UIWebView
    [self.myWebView goBack];
}
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.myWebView goForward];
}
- (IBAction)onStopButtonPressed:(id)sender {
    [self.myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.myWebView reload];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.onBackButtonPressed setEnabled:[self.myWebView canGoBack]];

    [self.onForwardButtonPressed setEnabled:[self.myWebView canGoForward]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
