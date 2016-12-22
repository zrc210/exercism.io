class PhoneNumber
  attr_reader :number

  DEFAULT_NUMBER = ('0' * 10).freeze

  def initialize(number_string)
    @number = sanitize(number_string)
  end

  def area_code
    number[0..2]
  end

  def exchange
    #https://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers#North_America
    number[3..5]
  end

  def subscriber_number
    number[6..9]
  end

  def to_s
    "(#{area_code}) #{exchange}-#{subscriber_number}"
  end

  private

  def sanitize(number_string)
    return DEFAULT_NUMBER if %r{[A-Za-z]} =~ number_string
    cleaned_number = number_string.gsub(%r{[^0-9]}, '')
    return DEFAULT_NUMBER unless valid?(cleaned_number)
    cleaned_number[-10..-1]
  end

  def valid?(number_string)
    number_string.length == 10 ||
      (number_string.length == 11 &&
       number_string.start_with?('1'))
  end
end
