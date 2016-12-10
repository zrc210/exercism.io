module BookKeeping
  VERSION = 1
end

class Sieve
  def initialize(number)
    @number_range = [*2..number].freeze
  end

  def primes
    range = number_range.dup
    range.each do |factor|
      range.reject! { |number| factor?(number, factor) }
    end
    range
  end

  private

  attr_reader :number_range

  def factor?(number, factor)
    number > factor && (number % factor).zero?
  end
end

class PrimeNumbers
  def initialize(known_primes: [2])
    @known_primes = known_primes
  end

  def nth_prime(n)
    index = n - 1
    return known_primes[index] if index < known_primes.length
    generate_primes(n)
    known_primes[index]
  end

  private

  attr_reader :known_primes

  def generate_primes(max)
    i = known_primes.last + 1
    while known_primes.length < max
      known_primes << i if prime?(i)
      i += 1
    end
  end

  def prime?(number)
    limit = Math.sqrt(number).ceil
    known_primes.each do |i|
      break if i > limit
      return false if (number % i).zero?
    end
    true
  end
end

module Prime
  @prime_numbers = PrimeNumbers.new(known_primes: Sieve.new(1000).primes)
  class << self
    def nth(n)
      raise ArgumentError if n < 1
      @prime_numbers.nth_prime(n)
    end
  end
end
