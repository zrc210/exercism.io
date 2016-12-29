module PrimeFactors
  class << self
    def for(number)
      factors = []
      current_divisor = 2
      remaining_number = number
      while remaining_number > 1
        while (remaining_number % current_divisor).zero?
          factors << current_divisor
          remaining_number /= current_divisor
        end
        current_divisor += 1
      end
      factors
    end
  end
end
