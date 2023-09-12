
require_relative '../../services/expression_evaluator'

describe ExpressionEvaluator do
  context 'valid expressions' do
    describe '#validate' do
      it 'validates a  mathemetical expression' do
        evaluator = ExpressionEvaluator.new
        result = evaluator.validate('1/2 * 3&3/4')
        expect(result).to be(true)
      end

      it 'validates an expression with fractions and mixed numbers' do
        evaluator = ExpressionEvaluator.new
        result = evaluator.validate('2&3/8 + 9/8')
        expect(result).to be(true)
      end

      it 'validates an expression with brackets' do
        evaluator = ExpressionEvaluator.new
        result = evaluator.validate('(7/2 + 9) * 2')
        expect(result).to be(true)
      end

      it 'validates an expression with negative number' do
        evaluator = ExpressionEvaluator.new
        result = evaluator.validate('5/2 + -2')
        expect(result).to be(true)
      end 
    end
  end

  context 'invalid expressions' do
    describe '#validate' do
      it 'invalidates an expression with mismatched brackets' do
        evaluator = ExpressionEvaluator.new
        result = evaluator.validate('(9/2 + 8/5 * 9')
        expect(result).to be(false)
      end

      it 'invalidates an expression with invalid characters' do
        evaluator = ExpressionEvaluator.new
        result = evaluator.validate('9/2 $9/4')
        expect(result).to be(false)
      end

      it 'invalidates an expression with consecutive operators' do
        evaluator = ExpressionEvaluator.new
        result = evaluator.validate('2 + + 11/8')
        expect(result).to be(false)
      end

      it 'invalidates an expression with improper spacing' do
        evaluator = ExpressionEvaluator.new
        result = evaluator.validate('3/9+3/7')
        expect(result).to be(false)
      end
    end
  end
end
