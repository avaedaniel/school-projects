# Author: Ava Daniel
class ExpressionEvaluator
    def initialize(expression)
      @expression = expression
    end
  
    def evaluate
      # Remove spaces from the expression
      expression = @expression.gsub(/\s+/, '')
  
      # Handle parentheses first
      while expression.include?('(')
        expression = expression.gsub(/\(([^()]+)\)/) do |match|
          evaluate_simple_expression(Regexp.last_match(1))
        end
      end
  
      # Evaluate the final simplified expression
      evaluate_simple_expression(expression)
    end
  
    private
  
    def evaluate_simple_expression(expr)
      # Handle multiplication, division, and modulo
      while expr =~ /(\d+(\.\d+)?)([\*\/%])(\d+(\.\d+)?)/
        left, operator, right = $1.to_f, $3, $4.to_f
        result = case operator
                 when '*' then left * right
                 when '/' then (right.zero? ? raise("Division by zero error!") : left / right)
                 when '%' then left % right
                 end
        expr.sub!("#{$1}#{$3}#{$4}", result.to_s)
      end
  
      # Handle addition and subtraction
      while expr =~ /(-?\d+(\.\d+)?)([+-])(-?\d+(\.\d+)?)/
        left, operator, right = $1.to_f, $3, $4.to_f
        result = case operator
                 when '+' then left + right
                 when '-' then left - right
                 end
        expr.sub!("#{$1}#{$3}#{$4}", result.to_s)
      end
  
      # Return the final result
      expr.to_f
    end
  end
  
  # Example usage
  expression = "(4 + 2) * (5 - 4) = 6"
  begin
    # Strip out the `=` and evaluate
    expression_to_evaluate = expression.split('=').first
    evaluator = ExpressionEvaluator.new(expression_to_evaluate)
    result = evaluator.evaluate
  
    puts "The result of '#{expression_to_evaluate}' is #{result}"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end 