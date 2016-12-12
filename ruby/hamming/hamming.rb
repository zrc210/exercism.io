module BookKeeping
  VERSION = 3
end

module Hamming
  class StrandLengthError < ArgumentError
    def initialize(message = 'Strands must be of equal length')
      super
    end
  end

  class << self
    def compute(strand_1, strand_2)
      raise StrandLengthError if strand_1.length != strand_2.length
      strand_1.chars.zip(strand_2.chars).count{ |pairs| pairs[0] != pairs[1] }
    end
  end
end
