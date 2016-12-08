module BookKeeping
  VERSION = 5
end
module Gigasecond
  GIGASECOND = (10 ** 9).freeze
  class << self
    def from(time)
      time + GIGASECOND
    end
  end
end
