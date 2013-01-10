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
@property (nonatomic, strong) NSMutableArray *programStack;
@end


@implementation Calculator

@synthesize programStack = _programStack;
static NSDictionary *_operations;

-(NSMutableArray *)programStack{
  if(!_programStack) _programStack = [[NSMutableArray alloc] init];
  return _programStack;
}

-(void)setprogramStack:(NSMutableArray *)anArray{ _programStack = anArray; }

-(void)pushOperand:(double)operand{
  [self.programStack addObject : [NSNumber numberWithDouble:operand]];
}

-(double)performOperation:(NSString *)operation{
  [self.programStack addObject:operation];
  return [Calculator runProgram:self.program];
}

-(id)program{ return [self.programStack copy]; }

+(NSDictionary *)operations{
  if(_operations) return _operations;
  
  _operations = [
    NSDictionary dictionaryWithObjectsAndKeys:
      [NSValue valueWithPointer:@selector(divisionOperation:)], @"/",
      [NSValue valueWithPointer:@selector(multiplicationOperation:)], @"*",
      [NSValue valueWithPointer:@selector(sumOperation:)], @"+",
      [NSValue valueWithPointer:@selector(substractionOperation:)], @"-",
      [NSValue valueWithPointer:@selector(squareRootOperation:)], @"sqrt",
      [NSValue valueWithPointer:@selector(sinOperation:)], @"sin",
      [NSValue valueWithPointer:@selector(cosineOperation:)], @"cos",
      [NSValue valueWithPointer:@selector(piOperation:)], @"π",
    nil
  ];
  
  return _operations;
}
+(NSString *)programDescription:(id)program{ return @"Pending"; }


+(double)popOperand:(id)stack{
  double result = 0;
  NSString *operation;
  id topOfStack = [stack lastObject];
  if(topOfStack) [stack removeLastObject];
  
  if([topOfStack isKindOfClass:[NSNumber class]]) result = [topOfStack doubleValue];
  else if([topOfStack isKindOfClass:[NSString class]]){
    operation = topOfStack;
    SEL operationFunction = [[[self operations] objectForKey:operation] pointerValue];
    result = [[[self class] performSelector:operationFunction withObject:stack] doubleValue];
  }
  
  return result;
}

+(double)runProgram:(id)program{
  NSMutableArray *stack;
  if([program isKindOfClass:[NSArray class]]) stack = [program mutableCopy];
  
  return [self popOperand:stack];
}


+(NSNumber *)divisionOperation:(id)stack{
  double result = 0;
  double divisor = [self popOperand:stack];

  if(divisor) result = [self popOperand:stack] / divisor;
  else result = INFINITY;
  
  return [NSNumber numberWithDouble:result];
}

+(NSNumber *)substractionOperation:(id)stack{
  double result;
  double subtrahend = [self popOperand:stack];
  result = [self popOperand:stack] - subtrahend;
  return [NSNumber numberWithDouble:result];
}

+(NSNumber *)multiplicationOperation:(id)stack{ return [NSNumber numberWithDouble:([self popOperand:stack] * [self popOperand:stack])]; }

+(NSNumber *)sumOperation:(id)stack{ return [NSNumber numberWithDouble:([self popOperand:stack] + [self popOperand:stack])]; }

+(NSNumber *)squareRootOperation:(id)stack{ return [NSNumber numberWithDouble:sqrt([self popOperand:stack])]; }

+(NSNumber *)sinOperation:(id)stack{ return [NSNumber numberWithDouble:sin([self popOperand:stack])]; }

+(NSNumber *)cosineOperation:(id)stack{ return [NSNumber numberWithDouble:cos([self popOperand:stack])];}

+(NSNumber *)piOperation:(id)stack{ return [NSNumber numberWithDouble:M_PI];}


-(void)clearOperands {
  [self.programStack removeAllObjects];
}

@end
