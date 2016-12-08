module BookKeeping
  VERSION = 3
end
class Squares
  def initialize(num)
    @num = num
  end

  def square_of_sum
    (1..num).reduce(0, :+)**2
  end

  def sum_of_squares
    (1..num).map { |i| i**2 }.reduce(0, :+)
  end

  def difference
    square_of_sum - sum_of_squares
  end

  private
  attr_reader :num
end
