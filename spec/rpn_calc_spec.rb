require_relative '../rpn_calc'

describe 'RPNCalc' do
  context 'RPNCalc class' do
    before :all do
      @calc = RPNCalc.new
    end

    it 'accepts input' do
      int = rand_int
      expect(@calc.input(int)).to eq int
      float = rand_float
      expect(@calc.input(float)).to eq float
    end

    context 'operations' do
      # NOTE: since RPNCalc converts all input to floats, floats also need to be used here.
      before :each do
        @int_1 = rand_int
        @int_2 = rand_int
        @float_1 = rand_float
        @float_2 = rand_float
      end

      after :each do
        @calc.clear
      end

      it 'correctly multiplies' do
        @calc.input(@int_1)
        @calc.input(@int_2)
        expect(@calc.input('*')).to eq @int_1.to_f * @int_2.to_f
        @calc.input(@float_1)
        @calc.input(@float_2)
        expect(@calc.input('*')).to eq @float_1.to_f * @float_2.to_f
      end

      it 'correctly divides' do
        @calc.input(@int_1)
        @calc.input(@int_2)
        expect(@calc.input('/')).to eq @int_1.to_f / @int_2.to_f
        @calc.input(@float_1)
        @calc.input(@float_2)
        expect(@calc.input('/')).to eq @float_1.to_f / @float_2.to_f
        @calc.input(@float_1)
        @calc.input('0')
        expect(@calc.input('/')).to eq 'Invalid operation!'
      end

      it 'correctly adds' do
        @calc.input(@int_1)
        @calc.input(@int_2)
        expect(@calc.input('+')).to eq @int_1.to_f + @int_2.to_f
        @calc.input(@float_1)
        @calc.input(@float_2)
        expect(@calc.input('+')).to eq @float_1.to_f + @float_2.to_f
      end

      it 'correctly subtracts' do
        @calc.input(@int_1)
        @calc.input(@int_2)
        expect(@calc.input('-')).to eq @int_1.to_f - @int_2.to_f
        @calc.input(@float_1)
        @calc.input(@float_2)
        expect(@calc.input('-')).to eq @float_1.to_f - @float_2.to_f
      end
    end

    context 'correctly passes tests from GitHub' do
      it 'passes test 2' do
        @calc.input('-3')
        @calc.input('-2')
        @calc.input('*')
        @calc.input('5')
        result = @calc.input('+')
        expect(result).to eq 11
      end

      it 'passes test 3' do
        @calc.input('2')
        @calc.input('9')
        @calc.input('3')
        @calc.input('+')
        result = @calc.input('*')
        expect(result).to eq 24
      end

      it 'passes test 4' do
        @calc.input('20')
        @calc.input('13')
        @calc.input('-')
        @calc.input('2')
        result = @calc.input('/')
        expect(result).to eq 3.5
      end
    end

    def rand_int
      (rand(999) + 1).to_s
    end

    def rand_float
      (rand * 999 + 1).to_s
    end
  end

  context 'String class' do
    it 'has the valid_num? method' do
      expect('Test string'.valid_num?).to eq false
      expect('5'.valid_num?).to eq true
      expect('63.7'.valid_num?).to eq true
    end

    it 'has the to_number method' do
      expect('45'.to_number).to be 45
      expect('163.7'.to_number).to be 163.7
    end
  end

  context 'Float class' do
    it 'has the cleanup method' do
      expect(164.0.cleanup).to be 164
      expect(136.732.cleanup).to be 136.732
    end
  end
end
