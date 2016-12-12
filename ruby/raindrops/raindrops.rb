module BookKeeping
  VERSION = 3
end

module Raindrops
  TRANSLATION_MAPPINGS = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }.freeze
  class << self
    def convert(number)
      output = TRANSLATION_MAPPINGS.reduce('') do |string, translation_mapping|
        factor, translation = translation_mapping
        string << translation if (number % factor).zero?
        string
      end
      output.empty? ? number.to_s : output
    end
  end
end
