module BookKeeping
  VERSION = 2
end

class Year
  attr_reader :number

  def self.leap?(number)
    Year.new(number).leap?
  end

  def initialize(number)
    @number = number
  end

  def leap?
    factor_of?(400) || factor_of?(4) && !factor_of?(100)
  end

  def to_s
    number.to_s
  end

  def modulo(factor)
    number.modulo(factor)
  end

  alias_method :%, :modulo
  private

  def factor_of?(factor)
    (self % factor).zero?
  end
end
