require_relative 'expression_evaluator'

class ExpressionCalculation
  OPERATOR_PRECEDENCE = { '*' => 2, '/' => 2, '+' => 1, '-' => 1 }

  def self.calculate_expression(expression)
    evaluator = ExpressionEvaluator.new
    raise ArgumentError, 'Expression is not valid' unless evaluator.validate(expression)
      result = operation(expression)
      return format_result(result)
    rescue ZeroDivisionError
      'Division by zero is not a valid expression'
       operation(expression)
   end

   private

    def self.apply_operator(operators, values)
      operator = operators.pop
      right = values.pop
      left = values.pop
      case operator
      when '+'
        values.push(left + right)
      when '-'
        values.push(left - right)
      when '*'
        values.push(left * right)
      when '/'
        raise ZeroDivisionError if right == 0
        values.push(left / right)
      end
    end

    def self.greater_precedence(op1, op2)
      OPERATOR_PRECEDENCE[op1] > OPERATOR_PRECEDENCE[op2]
    end

    def self.parse_mixed_number(mixed_number)
      whole, fraction = mixed_number.split('&')
      whole.to_i + Rational(fraction)
    end

    def self.operation(expression) 
      expression_arr = expression.scan(/-?\d+&\d+\/\d+|-?\d+\/\d+|-?\d+|[+\-*\/]/)
      values = []
      operators = []

      expression_arr.each do |element|
        case element
          when /-?\d+&\d+\/\d+/
            values.push(parse_mixed_number(element))
          when /-?\d+\/\d+/
            values.push(Rational(element))
          when /-?\d+/
            values.push(element.to_i)
          when /[+\-*\/]/
            while operators.any? && greater_precedence(operators.last, element)
              apply_operator(operators, values)
            end
            operators.push(element)
          end
        end

      while operators.any?
        apply_operator(operators, values)
      end

      values.first.to_s
    end

    def self.format_result(result)
      rational_pattern = /^-?\d+\/\d+$/
      if result.match?(rational_pattern)
        fraction = Rational(result)
        numerator = fraction.numerator
        denominator = fraction.denominator
        whole_part = numerator / denominator
        remainder = numerator % denominator
        return "#{whole_part}&#{remainder}/#{denominator}"
      else
        result.to_s
      end
    end
 end
