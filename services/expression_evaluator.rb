class ExpressionEvaluator
  VALID_OPERATORS = ["+","-","/","*"]

  def validate(expression)
    return false unless valid_brackets?(expression)
    return space_check_in_expression(expression)
    return valid_expression?(expression)
  end

  def valid_brackets?(expression)
    stack = []
    expression.each_char do|char|
      if opening_bracket?(char)
        stack.push(char)
      elsif closing_bracket?(char)
        return false if stack.empty? || !in_valid_brace_sequence?(stack.pop,char)
      end
    end

    stack.empty?    
  end

  def valid_expression?(expression)
    if expression.include?('-')
      expression.gsub('-','(-)')
    end
    
    if is_mixed_number?(expression)
      expression_arr = expression.scan(/-?\d+&\d+\/\d+|-?\d+|[+\-*\/]/)
    else
      expression_arr = expression.scan(/[\d.]+|\s+|[\+\-\*\/]/)
    end
    is_valid?(expression_arr)
  end

  private

  def opening_bracket?(char)
    char == '(' || char == '{' || char == '[' 
  end

  def closing_bracket?(char)
    char == ')' || char == '}' || char == ']' 
  end

  def in_valid_brace_sequence?(opening_exp,closing_exp)
    (opening_exp == '(' && closing_exp == ')') ||
    (opening_exp == '{' && closing_exp == '}') ||
    (opening_exp == '[' && closing_exp == ']')
  end

  def is_valid?(expression)
    operator_stack = []
    operand_count = 0

    expression.each_with_index do |exp, ind|
      if VALID_OPERATORS.include?(exp)
        next_exp = expression[ind + 1]
        if VALID_OPERATORS.include?(next_exp)
          precedence = [exp,next_exp].max
          expression.delete(next_exp) if exp != precedence
          operator_stack.push(precedence)
        else
          operator_stack.push(exp)
        end

      else
        if exp.match?(/^(-?\d+&\d+\/\d+|-?\d+(\.\d+)?|-?\d+\/\d+|-?\d+)$/)
          operand_count += 1
        else
          return false
        end
      end
    end
    operator_stack.size == operand_count - 1
  end

  def is_mixed_number?(expression)
    mixed_num_pattern = /(-?\d+&\d+\/\d+)/
    invalid_mixed_num_pattern = /(\d+&\d+&|&\d+\/\d+&)/
    if expression.match?(mixed_num_pattern) && !expression.match?(invalid_mixed_num_pattern)
      return true
    else
      return false
    end
  end

  def space_check_in_expression(expression)
    expression.match?(/-?\d+\s+[\+\-\*\/]\s+-?\d+/)
  end
end
