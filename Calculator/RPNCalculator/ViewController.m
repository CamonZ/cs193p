//
//  ViewController.m
//  RPNCalculator
//
//  Created by CamonZ on 1/5/13.
//
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsEnteringANumber;
@property (nonatomic) BOOL floatDivisorEntered;
@property (nonatomic, strong) Calculator *calculator;
@end

@implementation ViewController

@synthesize display = _display;
@synthesize userIsEnteringANumber = _userIsEnteringANumber;
@synthesize calculator = _calculator;
@synthesize floatDivisorEntered = _floatDivisorEntered;

-(Calculator *)calculator{
  if(!_calculator) _calculator = [[Calculator alloc] init];
  return _calculator;
}

- (IBAction)digitPressed:(UIButton *)sender {
  NSString *digit = sender.currentTitle;
  
  if([sender.currentTitle isEqualToString:@"."]){
    if (!self.floatDivisorEntered) {
      self.floatDivisorEntered = TRUE;
    }
    else{
      digit = @"";
    }
  }
  
  if(self.userIsEnteringANumber){
    self.display.text = [self.display.text stringByAppendingString:digit];
  }
  else{
    self.display.text = digit;
    self.userIsEnteringANumber = TRUE;
  }
}

- (IBAction)enterPressed{
  [self.calculator pushOperand:[self.display.text doubleValue]];
  self.display.text = [NSString stringWithFormat:@"%g", 0.0];
  self.userIsEnteringANumber = FALSE;
  self.floatDivisorEntered = FALSE;
}

- (IBAction)operationPressed:(UIButton *)sender {
  
  if(self.userIsEnteringANumber){ [self enterPressed]; }
  
  NSString *operation = sender.currentTitle;
  double result = [self.calculator performOperation:operation];
  self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)clearPressed {
  [self.calculator clearOperands];
  self.display.text = [NSString stringWithFormat:@"%g", 0.0];
  self.userIsEnteringANumber = FALSE;
  self.floatDivisorEntered = FALSE;
}

@end
