module BookKeeping
  VERSION = 3
end

module Raindrops
  CONVERSIONS = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }.freeze
  class << self
    def convert(num)
      output = CONVERSIONS.keys.map do |key|
        CONVERSIONS[key] if num % key == 0
      end.join('')
      output.empty? ? num.to_s : output
    end
  end
end
