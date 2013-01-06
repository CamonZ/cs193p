//
//  Calculator.m
//  RPNCalculator
//
//  Created by CamonZ on 1/6/13.
//
//

#import "Calculator.h"
#import "math.h"

@interface Calculator()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end


@implementation Calculator

@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack{
  if(!_operandStack) _operandStack = [[NSMutableArray alloc] init];
  return _operandStack;
}

-(void)setOperandStack:(NSMutableArray *)anArray{ _operandStack = anArray; }

-(void)pushOperand:(double)operand{
  [self.operandStack addObject : [NSNumber numberWithDouble:operand]];
}

-(double)popOperand{
  NSNumber *operand = [self.operandStack lastObject];
  if (operand) { [self.operandStack removeLastObject]; }
  return [operand doubleValue];
}


-(double)performOperation:(NSString *)operation{
  double result = 0;
  
  if([operation isEqualToString:@"*"]){ result = [self multiplicationOperation]; }
  else if([operation isEqualToString:@"/"]){ result = [self divisionOperation]; }
  else if([operation isEqualToString:@"+"]){ result = [self sumOperation]; }
  else if([operation isEqualToString:@"-"]){ result = [self substractionOperation]; }
  else if([operation isEqualToString:@"sqrt"]){ result = [self squareRootOperation]; }
  else if([operation isEqualToString:@"sin"]){ result = [self sinOperation]; }
  else if([operation isEqualToString:@"cos"]){ result = [self cosineOperation]; }
  else if([operation isEqualToString:@"π"]){ result = [self piOperation]; }
  
  [self pushOperand:result];
  
  return result;
}

-(double)divisionOperation{
  double result = 0;
  double divisor = [self popOperand];

  if(divisor) result = [self popOperand] / divisor;
  else result = INFINITY;
  
  return result;
}
-(double)substractionOperation{
  double subtrahend = [self popOperand];
  return [self popOperand] - subtrahend;
}
-(double)multiplicationOperation{ return [self popOperand] * [self popOperand]; }
-(double)sumOperation{ return [self popOperand] + [self popOperand]; }
-(double)squareRootOperation{ return sqrt([self popOperand]); }
-(double)sinOperation{ return sin([self popOperand]);}
-(double)cosineOperation{ return cos([self popOperand]);}
-(double)piOperation{ return M_PI;}


-(void)clearOperands {
  [self.operandStack removeAllObjects];
}

@end
