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
    number > factor && number % factor == 0
  end
end
