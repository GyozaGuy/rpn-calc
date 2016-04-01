require 'bigdecimal'

# RPNCalc object
class RPNCalc
  TITLE = 'RPNCalc 1.0'.freeze
  AUTHOR = 'Steven Stromberg'.freeze
  AUTHOR.freeze
  OPERATIONS = { '*' => ->(nums) { nums[0] * nums[1] },
                 '/' => ->(nums) { nums[0] / nums[1] unless nums[1] == 0 },
                 '+' => ->(nums) { nums[0] + nums[1] },
                 '-' => ->(nums) { nums[0] - nums[1] } }.freeze

  def initialize
    # Create new RPNCalc object
    @input_buffer = []
  end

  def start
    puts TITLE
    puts AUTHOR
    calc_loop
  end

  def stop
    puts 'Thanks for using RPNCalc!'
  end

  def calc_loop
    loop do
      input = gets.chomp
      if OPERATIONS.include? input
        if @input_buffer.length >= 2
          result = OPERATIONS[input].call(@input_buffer[-2..-1].map(&:to_f))
          if result.nil?
            puts 'Invalid operation!'
          else
            2.times { @input_buffer.pop }
            @input_buffer.push(result.cleanup)
            puts "> #{result.cleanup}"
          end
        end
      elsif input.valid_num?
        @input_buffer.push(input.to_number)
        puts "> #{input}"
      end
      break if input == 'q'
    end
    stop
  end
end

# Add method to String class to check for a valid number
# Also add method to convert string to Integer or Float
class String
  def valid_num?
    true if Float self
  rescue
    false
  end

  def to_number
    # Converts input to numeric
    num = BigDecimal.new(self)
    num.frac == 0 ? num.to_i : num.to_f
  end
end

# Add method to Float class to make numbers prettier
class Float
  def cleanup
    to_i == self ? to_i : self
  end
end

calc = RPNCalc.new
calc.start
