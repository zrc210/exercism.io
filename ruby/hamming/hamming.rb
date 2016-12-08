module BookKeeping
  VERSION = 3
end

module Hamming
  class << self
    def compute(a,b)
      raise ArgumentError if a.length != b.length
      [*0...a.length]
        .map { |i| a[i] == b[i] ? 0 : 1}
        .reduce(0, :+)
    end
  end
end
