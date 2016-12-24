module BookKeeping
  VERSION = 1
end

class Sieve
  def initialize(number)
    @number_range = (2..number).freeze
  end

  def primes
    @primes ||= compute_primes
  end

  private

  attr_reader :number_range

  def compute_primes
    primes = number_range.to_a
    primes.each_with_index do |factor, index|
      next unless factor
      start = index + factor
      (start..primes.length).step(factor).each do |mark_index|
        primes[mark_index] = nil
      end
    end
    primes.compact
  end
end
