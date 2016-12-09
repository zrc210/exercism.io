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
    500 => 'D',
    100 => 'C',
    50 => 'L',
    10 => 'X',
    5 => 'V',
    1 => 'I'
  }.freeze

  LONG_TO_SHORT = {
    'DCCCC' => 'CM',
    'CCCC'  => 'CD',
    'LXXXX' => 'XC',
    'XXXX'  => 'XL',
    'VIIII' => 'IX',
    'IIII'  => 'IV'
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
      convert(result)
    end

    private
    def convert(roman_str)
      LONG_TO_SHORT.reduce(roman_str) do |converted, mapping|
        long, short = mapping
        converted.gsub(/#{long}/, short)
      end
    end
  end
end
