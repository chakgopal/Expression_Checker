
require_relative '../../services/expression_calculation'

describe ExpressionCalculation do
  context 'valid expressions' do
    describe '.calculate_expression' do
      it 'handles addition' do
        result = ExpressionCalculation.calculate_expression('1/2 + 3/4')
        expect(result).to eq('1&1/4')
      end

      it 'handles basic fraction addition' do
        result = ExpressionCalculation.calculate_expression('2 * 9/8')
        expect(result).to eq('2&1/4')
      end
      it 'handles subtraction' do
        result = ExpressionCalculation.calculate_expression('3 - 9/7')
        expect(result).to eq('1&5/7')
      end

      it 'handles division' do
        result = ExpressionCalculation.calculate_expression('9 / 8&4/6')
        expect(result).to eq('1&1/26')
      end
    end
  end

  context 'invalid expressions' do
    describe '.calculate_expression' do
      it 'raises ArgumentError for an invalid expression' do
        expect { ExpressionCalculation.calculate_expression('(2 + 3') }.to raise_error(ArgumentError, 'Expression is not valid')
      end

      it 'handles division by zero' do
        expect { ExpressionCalculation.calculate_expression('1 + 2/0') }.to raise_error(ZeroDivisionError, 'divided by 0')
      end
    end
  end
end
