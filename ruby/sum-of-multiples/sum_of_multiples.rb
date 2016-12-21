class SumOfMultiples
  def initialize(*number_set)
    @number_set = number_set.to_a.sort
  end

  def to(max)
    multiples(max).inject(:+)
  end

  private

  attr_reader :number_set

  def multiples(max)
    number_set
      .reduce([0]) { |array, number| array.push(*number.step(max - 1, number)) }
      .uniq
  end
end
