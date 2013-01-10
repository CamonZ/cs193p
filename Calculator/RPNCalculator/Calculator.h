//
//  Calculator.h
//  RPNCalculator
//
//  Created by CamonZ on 1/6/13.
//
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)clearOperands;

@property (readonly) id program;

+(double)runProgram:(id)program;
+(NSString *)programDescription:(id)program;

@end
