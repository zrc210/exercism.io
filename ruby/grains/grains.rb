class Grains
  def self.square(index)
    new.square(index)
  end

  def self.total
    new.total
  end

  def initialize(max_squares: 64)
    @max_squares = 64
  end

  def square(index)
    # the squares are indexed with a starting index of 1
    2**(index - 1)
  end

  def total
    # the sum(n=0, N) 2**n = (2**(N+1)) - 1
    square(max_squares + 1) - 1
  end

  private

  attr_reader :max_squares
end
