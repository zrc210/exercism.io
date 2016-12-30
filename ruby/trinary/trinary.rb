module BookKeeping
  VERSION = 1
end

class Trinary
  BASE = 3
  DEFAULT = 0
  def initialize(trinary_string)
    @trinary_string = trinary_string
  end

  def to_decimal
    return DEFAULT unless valid?
    exponent = trinary_string.length - 1
    trinary_string
      .chars
      .reduce(0) do |sum, value|
        sum += value.to_i * (BASE**exponent)
        exponent -= 1
        sum
    end
  end

  private

  attr_reader :base, :trinary_string

  def valid?
    valid = %r{^[0-2]+$} =~ trinary_string
    valid && valid.zero?
  end
end
