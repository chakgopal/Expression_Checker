
# frozen_string_literal: true
require_relative '../services/expression_calculation'

def main
  while true
    print 'Please Enter an expression to evaluate: '
    expression = gets.chomp

    if expression.downcase == 'exit'
      break
    else
      begin
        result = ExpressionCalculation.calculate_expression(expression)
        puts "Result: #{result}"
      rescue StandardError => e
        puts "Invalid Expression due to #{e.message}" 
      end
    end
  end
end
