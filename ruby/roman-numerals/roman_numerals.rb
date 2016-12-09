module BookKeeping
  VERSION = 2
end

class Fixnum
  def to_roman
    RomanNumerals.to_roman(self)
  end
end

module RomanNumerals
  ROMAN_NUMERALS = {
    1000 => 'M',
    900 => 'CM',
    500 => 'D',
    400 => 'CD',
    100 => 'C',
    90 => 'XC',
    50 => 'L',
    40 => 'XL',
    10 => 'X',
    9 => 'IX',
    5 => 'V',
    4 => 'IV',
    1 => 'I'
  }.freeze

  class << self
    def to_roman(number)
      result = ''
      ROMAN_NUMERALS.reduce(number) do |to_convert, mapping|
        arabic_number, roman_letter = mapping
        needed, remainder = to_convert.divmod(arabic_number)
        result << roman_letter * needed
        remainder
      end
      result
    end
  end
end
